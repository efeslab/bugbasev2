import threading
import os

NTHREAD = 10

def generate(fp):
    # Call file_iternext() at the same time in different threads
    for word in iter(fp):
        print(len(word))

def parallel_read(fp, threads):
    jobs = []

    for x in range(0, threads):
        thread = threading.Thread(target=generate, args=(fp,))
        jobs.append(thread)
    # Start all jobs at "once" to make the race condition more likely
    for job in jobs:
        job.start()
    for job in jobs:
        job.join()

def main():
    filename = 'readahead.txt'

    with open(filename, 'w') as fp:
        fp.write('A' * 5507453)
        fp.flush()

    with open(filename) as fp:
        parallel_read(fp, NTHREAD)

    # in case of crash the file is not removed :-(
    os.unlink(filename)

if __name__ == "__main__":
    main()
