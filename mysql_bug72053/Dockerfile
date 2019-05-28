FROM mysql:5.6

COPY * /

CMD fallocate -l 50G file && dd if=/dev/zero of=filename bs=$((1024*1024)) count=$((10*1024)) && bash prepare_db.sh && cd ./var/lib/mysql/test && ulimite -c unlimited && myisamchk -recover animals