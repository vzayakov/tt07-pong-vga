<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This project is an implementation of the classic Pong video game. The
interface is VGA, and the game will be displayed when connected to a
monitor using a VGA cable. This includes all elements of the game:
the two paddles and the ball, and a scoreboard.

The VGA protocol is implemented in hardware using Counter modules,
RangeCheck modules, and an FSM to control them. It follows the VGA specification
of 640x480 resolution at 60Hz, and operates using a 50MHz clock signal.

The rest of the hardware for the Pong video game works on top of the VGA module.

## How to test

The game can be tested through a direct connection to a monitor over VGA.
Four switches and one button are required to interact with the game:
An up/down switch and move/no-move switch for each of the two players, and one
button for serving the ball.

To test the HDL design, one can compare the timing of all 8 VGA pins to
the industry-standard timing defined here:
http://www.tinyvga.com/vga-timing/640x480@60Hz

## External hardware

The game requires four switches and one button to play, as mentioned above.
It also requires an external splitter for each of the three VGA color signals.
This is to split each of VGA_R, VGA_G and VGA_B from 1-bit to 8-bit signals.
These splitters can be placed on an external PCB.
