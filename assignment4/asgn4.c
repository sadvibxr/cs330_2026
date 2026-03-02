#include <stdio.h>
#include "asgn4.h"

int main(){ 
    printf("Is Bit Set Function: ");
    isBitSet(23,4);
    printf("\n");
    printf("Set Bit Function: ");
    setBit(5,3);
    printf("\n");
    printf("Clear Bit Function: ");
    clearBit(15,1);
    printf("\n");
    printf("Toggle Bit Function: ");
    toggleBit(8,3);
    printf("\n");
    printf("Multiply By 2 Function: ");
    multiplyBy2(7);
    printf("\n");
    printf("Divide By 2 Function: ");
    divideBy2(18);
    printf("\n");
    printf("Count Set Bits: ");
    countSetBits(105); // Output should be 4 if input is 105
    printf("\n");
    return 0; 
}