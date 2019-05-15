package com.intuit.platform.gateway;

import net.spy.memcached.*;
import net.spy.memcached.ops.OperationStatus;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.net.InetSocketAddress;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicReference;

/**
 * Created by aattuluri
 */

public class MemcachedCounter {

    public static Integer MEMCACHE_BUFFER = 1;

    public static final String THROTTLING_LOG_TEMPLATE = "logType=memcachedCounter, processTime=%d, counter=%d, key='%s', message='%s'";
    public static final String THROTTLING_LOG_DELETE_VALUE_TEMPLATE = "logType=memcachedCounter, processTime=%d, oldValue=%d, newValue=%d, key='%s', message='%s'";

    private final Logger logger = LogManager.getLogger(MemcachedCounter.class.getCanonicalName());

    private String SAFE_KEY = "IntuitMemcachedCounter";

    private Long INCR_VAL = 8L;

    private Long INCR_INTERVAL = 75L;

    private Long MIN_INCREMENTS = 1000 / INCR_INTERVAL;

    //if running locally change this to a lower value like 10
    private Integer numIncrementThreads = 10;

    //if running locally change this to a lower value like 10
    private Integer numDeleteThreads = 10;

    private String TIMESTAMP_KEY = "timestampKey";

    private String memcacheAddress = "127.0.0.1";

    private List<Runnable> deleteThreads;

    private List<Runnable> incrementThreads;

    ExecutorService deleteExecutor = Executors.newFixedThreadPool(numDeleteThreads);

    ExecutorService incrExecutor = Executors.newFixedThreadPool(numIncrementThreads);

    //use delete to reset the counter, change it to false to use set operation instead of delete
    private boolean isDelete = true;

    //set it to true to use static servers defined in createMemcachedClient, else will connect to the cluster address set in memcacheAddress
    private boolean useLocal = true;

    public void init() {

        deleteThreads = new ArrayList<>();

        for (int i = 0; i < numDeleteThreads; i++) {
            deleteThreads.add(new DeleteCounterTask(isDelete, SAFE_KEY + i, TIMESTAMP_KEY + i));
        }

        incrementThreads = new ArrayList<>();

        for (int i = 0; i < numIncrementThreads; i++) {
            incrementThreads.add(new IncrementCounterTask(SAFE_KEY + i));
        }
    }

    public class SubMemcachedCounter {
        protected AtomicReference<MemcachedClient> memcachedClient = new AtomicReference<>();

        protected final Random random = new Random();

        public MemcachedClient getMemcachedClient() {
            return memcachedClient.get();
        }
    }

    public class IncrementCounterTask extends SubMemcachedCounter implements Runnable {

        public static final String operation = "Incr";

        private String safeKey;

        IncrementCounterTask(String key) {
            this.safeKey = key;
        }

        @Override
        public void run() {

            try {
                memcachedClient.set(createMemcachedClient());
            } catch (Exception e) {
                logger.error("logType=memcachedCounter message=%s", "Failed to initialize memcache client: " + e.getMessage(), e);
                return;
            }

            while (true) {

                Long value;
                Long startTime = System.currentTimeMillis();

                try {

                    Thread.sleep(INCR_INTERVAL + random.nextInt(25));

                    startTime = System.currentTimeMillis();

                    value = getMemcachedClient().incr(safeKey, INCR_VAL, 0, 1 + MEMCACHE_BUFFER);

                    //System.out.println("Value of "+safeKey+" after incr: " + value);

                    logger.info(String.format(THROTTLING_LOG_TEMPLATE,
                            System.currentTimeMillis() - startTime,
                            value,
                            safeKey,
                            operation));
                } catch (OperationTimeoutException e) {
                    logger.error(String.format(THROTTLING_LOG_TEMPLATE,
                            System.currentTimeMillis() - startTime,
                            0,
                            safeKey,
                            operation + " timed out"), e);
                } catch (IllegalStateException e) {
                    logger.error(String.format(THROTTLING_LOG_TEMPLATE,
                            System.currentTimeMillis() - startTime,
                            0,
                            safeKey,
                            operation + " IllegalStateException"), e);
                } catch (Exception e) {
                    logger.error(String.format(THROTTLING_LOG_TEMPLATE,
                            System.currentTimeMillis() - startTime,
                            0,
                            safeKey,
                            operation + " unknown exception"), e);
                }
            }
        }
    }

    public class DeleteCounterTask extends SubMemcachedCounter implements Runnable {

        public String operation =  "Delete";

        public boolean isDelete;

        private String safeKey;

        private String timestampKey;

        DeleteCounterTask(boolean isDelete, String key, String timestampKey) {
            this.isDelete = isDelete;
            if (!isDelete) {
                operation = "Set";
            }

            this.safeKey = key;
            this.timestampKey = timestampKey;
        }

        @Override
        public void run() {

            try {
                memcachedClient.set(createMemcachedClient());
            } catch (Exception e) {
                logger.error("logType=memcachedCounter message=%s", "Failed to initialize memcache client: " + e.getMessage(), e);
                return;
            }

            while (true) {

                Long startTime = System.currentTimeMillis();

                try {

                    Thread.sleep(10 + random.nextInt(10));

                    startTime = System.currentTimeMillis();

                    Long timestamp = (Long) getMemcachedClient().get(timestampKey);

                    //add timestamp if it doesn't exist
                    if (timestamp == null) {

                        timestamp = startTime;

                        OperationStatus status = getMemcachedClient().add(timestampKey, 1 + MEMCACHE_BUFFER, startTime).getStatus();

                        if (status.isSuccess()) {
                            logger.info(String.format(THROTTLING_LOG_TEMPLATE,
                                    System.currentTimeMillis() - startTime,
                                    0,
                                    safeKey,
                                    "Timestamp add success"));

                            //incr counter with 0 value and default it to 0

                            OperationStatus setStatus =  getMemcachedClient().set(safeKey, 1 + MEMCACHE_BUFFER, "0").getStatus();

                            logger.info(String.format(THROTTLING_LOG_TEMPLATE,
                                    System.currentTimeMillis() - startTime,
                                    0,
                                    safeKey,
                                    operation + ", success=" + setStatus.isSuccess()));
                        } else {
                            logger.error(String.format(THROTTLING_LOG_TEMPLATE,
                                    System.currentTimeMillis() - startTime,
                                    0,
                                    safeKey,
                                    "Timestamp add failed, " + status.getMessage()));
                        }
                    }
                    startTime = System.currentTimeMillis();
                    //skip deleting if timestamp hasn't expired
                    if (startTime < (timestamp + 1000)) {
                        continue;
                    }

                    String oldValueStr = (String) getMemcachedClient().get(safeKey);

                    Long oldValue = -1L;

                    if (oldValueStr != null) {
                        oldValue = Long.valueOf(oldValueStr.trim());
                    }

                    startTime = System.currentTimeMillis();

                    OperationStatus deleteCounterStatus = null;

                    if (this.isDelete) {
                        deleteCounterStatus = getMemcachedClient().delete(safeKey).getStatus();
                    } else {
                        deleteCounterStatus = getMemcachedClient().set(safeKey, 1 + MEMCACHE_BUFFER, "0").getStatus();
                    }

                    if (deleteCounterStatus.isSuccess()) {
                        logger.info(String.format(THROTTLING_LOG_TEMPLATE,
                                System.currentTimeMillis() - startTime,
                                0,
                                safeKey,
                                operation + "COUNTER - Success!"));

                        startTime = System.currentTimeMillis();

                        String newValueStr = (String) getMemcachedClient().get(safeKey);

                        Long newValue = -1L;

                        if (newValueStr != null) {
                            newValue = Long.valueOf(newValueStr.trim());
                        }

                        logger.info(String.format(THROTTLING_LOG_DELETE_VALUE_TEMPLATE,
                                System.currentTimeMillis() - startTime,
                                oldValue,
                                newValue,
                                safeKey,
                                "Pre/Post " + operation + " values"));

                        if (oldValue > 0 && newValue >= oldValue
                                && oldValue > (MIN_INCREMENTS * INCR_VAL)
                        ) {
                            logger.error(String.format(THROTTLING_LOG_DELETE_VALUE_TEMPLATE,
                                    System.currentTimeMillis() - startTime,
                                    oldValue,
                                    newValue,
                                    safeKey,
                                    "Value after delete exceeds before value"));
                            System.out.println("Value of " + safeKey + " after delete exceeds before value. oldValue: " + oldValue + ":: newValue: " + newValue);
                        }

                    } else {
                        logger.info(String.format(THROTTLING_LOG_TEMPLATE,
                                System.currentTimeMillis() - startTime,
                                0,
                                safeKey,
                                operation + " COUNTER - Failed - " + deleteCounterStatus.getStatusCode() + ": " +
                                        deleteCounterStatus.getMessage()));
                    }

                    OperationStatus deleteTimestampStatus = getMemcachedClient().delete(timestampKey).getStatus();

                    if (deleteTimestampStatus.isSuccess()) {
                        logger.info(String.format(THROTTLING_LOG_TEMPLATE,
                                System.currentTimeMillis() - startTime,
                                0,
                                safeKey,
                                operation + "TIMESTAMP - Success!"));

                    } else {
                        logger.info(String.format(THROTTLING_LOG_TEMPLATE,
                                System.currentTimeMillis() - startTime,
                                0,
                                safeKey,
                                operation + " COUNTER - Failed - " + deleteTimestampStatus.getStatusCode() + ": " +
                                        deleteTimestampStatus.getMessage()));
                    }

                } catch (OperationTimeoutException e) {
                    logger.error(String.format(THROTTLING_LOG_TEMPLATE,
                            System.currentTimeMillis() - startTime,
                            0,
                            safeKey,
                            operation + " time out"), e);
                } catch (IllegalStateException e) {
                    logger.error(String.format(THROTTLING_LOG_TEMPLATE,
                            System.currentTimeMillis() - startTime,
                            0,
                            safeKey,
                            operation + " IllegalStateException"), e);
                } catch (Exception e) {
                    logger.error(String.format(THROTTLING_LOG_TEMPLATE,
                            System.currentTimeMillis() - startTime,
                            0,
                            safeKey,
                            operation + " exception"), e);
                }
            }
        }
    }



    public void start(){

        for (Runnable i : deleteThreads) {
            deleteExecutor.submit(i);
        }

        for (Runnable i : incrementThreads) {
            incrExecutor.submit(i);
        }

    }

    public void destroy(){
        deleteExecutor.shutdownNow();
        incrExecutor.shutdownNow();
    }

    private MemcachedClient createMemcachedClient() throws Exception {
        ConnectionFactoryBuilder builder = new ConnectionFactoryBuilder();
        builder.setOpTimeout(100)
                .setMaxReconnectDelay(30)
                .setOpQueueMaxBlockTime(50)
                .setTimeoutExceptionThreshold(998)
                .setLocatorType(ConnectionFactoryBuilder.Locator.CONSISTENT)
                .setHashAlg(DefaultHashAlgorithm.KETAMA_HASH)
                .setFailureMode(FailureMode.Redistribute)
                .setProtocol(ConnectionFactoryBuilder.Protocol.BINARY);

        //Override memcached endpoint

        if (!useLocal) {
            List<InetSocketAddress> inetSocketAddresses = new ArrayList<>(Arrays.asList(
                    InetSocketAddress.createUnresolved(memcacheAddress, 11211)
            ));

            return new MemcachedClient(builder.build(), inetSocketAddresses);
        } else {

        List<InetSocketAddress> inetSocketAddresses = new ArrayList<>(Arrays.asList(
                InetSocketAddress.createUnresolved("127.0.0.1", 11211),
                InetSocketAddress.createUnresolved("127.0.0.1", 11211)
        ));

        return new MemcachedClient(builder.setClientMode(ClientMode.Static).build(), inetSocketAddresses);
        }
    }

    public static void main(String [] args) {
        MemcachedCounter counter = new MemcachedCounter();
        counter.init();
        counter.start();
    }

}
