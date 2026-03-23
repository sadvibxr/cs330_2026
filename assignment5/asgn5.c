#include <stdio.h>
#include "asgn5.s"

int main(){
    int arr[] = {0, 1, 2, 3, 4, 5}; //Assign an array
    int* arrPtr = arr; // Assign pointer to first value of the array
    int size = sizeof(arr)/sizeof(arr[0]); // Find size of the array
    printf("Given Array: "); // Prints "Given Array" to make it organized
    for(int i = 0; i < size; i++){ //Loop through given array
        printf("%d ", arr[i]); // Print out the values
    }
    for (int i = 0; i < size; i++){ // Loop through given array
        *(arrPtr + i) = (*(arrPtr + i)) * (*(arrPtr + i)); // Reassign value in the array by its squared value
    }
    printf("Squared Array: "); //Prints "Squared Array" to make it organized
    for(int i = 0; i < size; i++){ //Loop through the now squarred array
        printf("%d ", arr[i]); //Prints out the squared value
    }
    
    return 0; //return
}