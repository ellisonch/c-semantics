/* Generated by CIL v. 1.3.7 */
/* print_CIL_Input is true */

extern  __attribute__((__nothrow__, __noreturn__)) void exit(int __status )  __attribute__((__leaf__)) ;
static void bug(int size , int tries ) 
{ int i ;
  int num ;

  {
  num = 0;
  while (num < size) {
    i = 1;
    while (i < tries) {
      num ++;
      i ++;
    }
  }
  return;
}
}
int main(void) 
{ 

  {
  bug(5, 10);
  exit(0);
}
}