#include <stdio.h>   // This provides printf()
#include <stdlib.h>  // This provides the atoi() function below. It converts a
                     // string to an integer, like "123" -> 123

int main(int argc, char** argv) {
    (void) argc;  // Use argc, prevents -Werror from catching it as unused
  
    if (atoi(argv[1]) == 0) {
        // ... Lots missing here. Add more if branches and fill them in
    } else if (atoi(argv[1]) == 3) {
        // Here we know we're given 3 numbers, so we store then in 3 different
        // variables to make it easier to compare.
        int a = atoi(argv[2]);
        int b = atoi(argv[3]);
        int c = atoi(argv[4]);
    }
}
