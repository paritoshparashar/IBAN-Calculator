# IBAN-Calculator
This is a project I made during the course *Programming 2* at *University of Saarland*. <br>
The assembly `(.asm)` files in the `src` directory, were coded by me. Other files are dependencies and test files. <br>
Implementation of an IBAN calculator that converts a bank account number (KNR) and a bank code (BLZ) to a German IBAN - In a MIPS assembler

## Setting Up
To be able to edit the project in Mars, you first have to checkout the repository and import the project: <br>
1. Clone the project in any folder, using: `git clone` <br>
2. Open the cloned directory in Mars.<br>

Check that the settings `Assemble all files in directory` and `Initialize Program Counter to global ‘main’ if defined` in the `Settings` menu in MARS are activated to compile the file `src/main.asm` and set the program entry point to the label `main`. In the following document, we refer to the term character as a single byte encoding of a character according to the ASCII standard. The IBANs only contain ASCII upper case letters and digits. The KNRs and the BLZs consist of ASCII digits only. <br>

## Executing Tests and Debugging

Executing Tests and Debugging Execute the command `./run_tests.py` in the root directory of the project to test your implementation. By default all public tests in the directory `tests/pub` are run. To run only specific tests, use the option `-t test_name_1 ...test_name_n` to run only the tests with names `test_name_1` through `test_name_n`. For example, execute `./run_tests.py -t test_check_win1` to run the public test `test_check_win1` only. To list all test names, use the `-l` option: `./run_tests.py -l`. The output of the tests is colored to make the results more clear. This should display correctly in the majority of terminals, including the integrated terminal of Visual Studio Code. If the colored output poses a problem for the terminal you use, you can disable it with the option `-nc`.<br>
If a test fails, you can debug it in MARS. The command `./build_testbox tests/pub/test_X.asm` copies the test as well as your implementation into the folder `testbox/`. From there you can start the test using MARS. Note, that only the files given in the task descriptions are included in the evaluation and the automated tests. Therefore do not commit additional files, especially not in the `testbox/ folder`.<br>
