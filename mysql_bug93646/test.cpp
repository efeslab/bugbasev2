#include <mysqlx/xapi.h>
#include <iostream>

using std::cout;
using std::endl;

int main() {
  mysqlx_session_t *sess = mysqlx_get_session_from_url("mysqlx://root:@localhost", NULL, NULL);
  if (sess == nullptr) 
  	cout << "session not established!" << endl;
  mysqlx_session_valid(sess);
  mysqlx_session_close(sess);
  mysqlx_session_valid(sess);
  return 0;
}