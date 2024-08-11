// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

// KEYBOARD > 0? FILL : CLEAR
(LOOP)
    // Get keyboard value.
    @KBD
    D=M
    // Jump to ON if it's more than 0.
    @ON
    D;JGT
    // Jump to OFF otherwise.
    @OFF
    0;JMP
// Turn the screen ON and loop.
(ON)
    // Set the draw value to -1 (1111111111111111).
    @R0
    M=-1
    // Draw.
    @DRAW
    0;JMP
// Turn the screen OFF and loop.
(OFF)
    // Set the draw value to 0 (0000000000000000).
    @R0
    M=0
    // Draw.
    @DRAW
    0;JMP
// Set the screen to R0 and loop.
(DRAW)
    // Set the counter (R1) to 8192 (this is how many bits we need to do).
    // We will keep counting down with this as we draw.
    @MAX_BITS
    D=A
    @BIT_COUNTER
    M=D
    // Walk the screen and set the values to R0.
    (NEXT)
        // Calculate the position.
        @BIT_COUNTER
        D=M
        @POSITION
        M=D
        @SCREEN
        D=A
        @POSITION
        M=M+D
        // Actually draw the value at the current position.
        @R0
        D=M
        @POSITION
        A=M
        M=D
        // Decrement the counter (BIT_COUNTER).
        @BIT_COUNTER
        D=M-1
        M=D
        // Next if the counter is still >= 0.
        @NEXT
        D;JGE
    // Loop back around.
    @LOOP
    0;JMP
