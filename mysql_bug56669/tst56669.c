#include <my_global.h>
#include <mysql.h>

int main(int argc, char **argv)
{

  MYSQL *conn;
  conn = mysql_init(NULL);
  mysql_ping(conn); // the line cause segmentaion fault
  mysql_close(conn);
}