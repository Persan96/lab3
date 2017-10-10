//JUST A TEST FILE
#include <stdio.h>

int factorial(int fact){
  if(fact <= 1)
    return 1;
  else
    return fact*factorial(fact-1);
}

int main(void){
  unsigned long int fact = 0;
  printf("Factorial of: ");
  scanf("%d", &fact);
  printf("%d\n", fact);
  printf("Result = %d\n", factorial(fact));

  return 0;
}
