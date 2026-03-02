#ifndef __asgn4__
#define __asgn4__

/* the two lines above check to ensure
we haven't already included this header*/

/* your functions go here */
// Note: main() goes in the asgn4.c file

/*
Is Bit Set Function
description: check the bit of a given number at a given position 
and returns 1 if the bit is set, or 0 if the bit is not set
takes: int (int number) and bit position (int position)
returns: returns 1 if bit at that position is set, otherwise 0
*/
int isBitSet(int number, int position){
    if (number > 0 && position <= 31) { //Makes sure if bit position is valid
    position = (1 << position); //Left shifts 1 into given position bit
if ((number & position) == 0) { // Compares given number and the 
// bit at given position to see if the bit is set(1) or not set(0).
// (1 << position) shifts 1 in from the left into given bit position 
    printf("0"); //Prints "0" if not set
}
else {
    printf("1"); // Prints "1" if set
}
    }
    else {
        printf("Error: Out of Range"); //Prints out error message if invalid
    }
return 0;
}

/*
Set Bit Function
description: sets a bit (to 1) at a given position in a given number
and returns the new number
takes: int (int number) and bit position (int position)
returns: returns new number with the bit as that position set to 1
*/
int setBit(int number, int position){
    if (number > 0 && position <= 31) {//Makes sure if bit position is valid
    position = (1 << position); //Left shifts 1 into given position bit
    number = (number | position); // Takes the number bits and
    // position bit and compares if either bits are set at the given position
    //(OR bitwise operator sets position bit of the number to 1 if it is currently 0),
    //then assigns the new number to variable "number"
    printf("%d", number); //Prints out the new number 
 }
    else {
        printf("Error: Out of Range"); //Prints out error message if invalid
    }
    return 0;
}

/*
Clear Bit Function
description: clears a bit (to 0) at a given position in 
a given number and returns the new number
takes: int (int number) and bit position (int position)
returns: returns new number with the bit at that position cleared to 0
*/
int clearBit(int number, int position){
    if (number > 0 && position <= 31) {//Makes sure if bit position is valid
    position = ~(1 << position); //Left shift 1 into given position bit
    //then switches the bits using the NOT(~) bitwise operator
    number = (number & position); // Compares number bits with the position bits
    //(checking if both bits in the same position are 1), then assigns the 
    //new number to variable "number"
    printf("%d", number); //Prints out the new number
}
    else {
        printf("Error: Out of Range"); //Prints out error message if invalid
    }
    return 0;
}

/*
Toggle Bit Function
description: toggles a bit at a given position in a given number and returns the new number
takes: int (int number) and bit position (int postition)
returns: returns new number with bit toggled at given position
*/
int toggleBit(int number, int position){
    if (number > 0 && position <= 31) {//Makes sure if bit position is valid
    position = (1 << position); //Left shifts 1 into given position bit
    number = (number ^ position); //Uses XOR bitwise operator to toggle
    //bit in a given position to the opposite bit value
    printf("%d", number); // Prints out the new number
 }
    else {
        printf("Error: Out of Range"); //Prints out error message if invalid
    }

    return 0;
}

/*
Multiply By 2 Function
description: multiplies a given number by 2 using bit shifting then
returns the product number
takes: int (int number)
returns: returns the product of the number multiplied by 2
*/
int multiplyBy2(int number){
    number = (number << 1); //One bit left shift (adds a bit) is a number * 2
    printf("%d", number); //Prints out the product

    return 0;
}

/*
Divide By 2 Function
description: divides a given number by 2 using bit shifting then
returns the quotient number
takes: int (int number)
returns: returns the quotient of the number divided by 2
*/
int divideBy2(int number){
    number = (number >> 1); //One bit shift right (drops a bit) is a number/2 
    printf("%d", number); //Prints out the quotient

    return 0;
}

/*
Count Set Bits Function
description: counts and returns the amount of 1s in the binary representation
takes: int (int number)
returns: returns number of 1s in the binary representation
*/
int countSetBits(int number){
    int count = 0; //Count variable
    while (number > 0){ //Loop runs until number reaches less than 0 (will cause infinite loop
     //if it was set to greater than or equal to 0)
       if (number & 1){ //Checks if right bit is "1"
        count += 1; //Increments count if bit is "1"
        number = (number >> 1); //Shifts out right bit
       }
       else{ // If bit is "0", does not increment count and shifts out right bit
        number = (number >> 1);
       }
    }
    printf("%d", count); //Prints out count of set bits

    return 0;
}

#endif