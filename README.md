# Machine language routines for the Commodore 64/128

This is a book from 1987 by Todd D. Heimarck and Patrick Parrish.

I'll put the codes here as I try them. I'll change nothing from the book,
except adapting code for KickAssembler.
Each file is a self-contained program that demonstrates a specific technic.

## Index by topic

### Character input

- **BUFCLR** Clear the keyboard buffer
- **CHRKER** Get a character

### Character output

- **POKSCR** POKE to screen and color memory

### Colors

- **BCKCOL** Set the text screen background color
- **BORCOL** Set the text screen border color
- **COLFIL** Fill text screen color memory
- **TXTCOL** Set the text color

### Handling registers

- **RSREGM** Restore registers from memory
- **SVREGM** Save processor registers in memory

### Multiplication

- **MULAD1** Multiply two numbers with successive adds
- **MULAD2** Multiply two numbers with repeated additions (optimized version)

### Random numbers

- **RDBYRG** Generate a random one-byte integer value in a range
- **RNDBYT** Generate a random one-byte integer value (0-255) using SID voice 3
