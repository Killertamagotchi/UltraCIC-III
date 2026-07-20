This fork of the original UltraCIC-III project is a port for the ATTiny84/84a.
The reason for this is that some repro flash PCBs, which can be found on AliExpress, for example, have an ATTiny84/84a installed instead of an ATTiny25, ATTiny45, or ATTiny85, for which the original code was written.
However, these often have an older codebase that doesn't allow automatic switching between PAL and NTSC.
This allows you to flash a modified version of the original code onto the ATTiny84/84a, which should then make the repro modules work.

Before flashing the new code, you should make a backup of the ATTiny84/84a code as a precaution.

To create the necessary files, simply follow the same procedure as in the original codebase.

However, execute the command here:

"make attiny84"

Afterwards, the folder should contain the following files:
- UltraCIC-III_t84.hex
- UltraCIC-III.eep.hex

Additionally, for flashing to the ATTiny84/84a, the following fuses must be set in AVRDUDE (preferably the GUI AVRDUDESS):

- L: 0xC0
- H: 0xDF
- E: 0xFF (or 0x01, both disable self-programming)

Furthermore, the bit clock must also be set to ensure that the write is clean and no errors occur:
- -B 125kHz
  
or

- -B 32kHz

Unless modified again in UltraCIC-III.asm, the default boot is NTSC, and for PAL, you must turn the module on and off once in the PAL N64 to change the region. switches.

However, if you want to set PAL as the default, change the following line as in the original code:

- .ESEG
- ;.db 0x08 ;set PAL as initial region
- .db 0x00 ;set NTSC as initial region

in

- .ESEG
- .db 0x08 ;set PAL as initial region
- ;.db 0x00 ;set NTSC as initial region

## Flashing via avrdude (Command Line)

If you are using `avrdude` to flash the ATtiny84A, you can use the following commands. Replace `usbasp` with your specific programmer (e.g., `avrispmkii`, `arduino`, etc.) if necessary.

### 1. Flash Fuses (Mandatory for 16 MHz Clock)
This sets the Low Fuse to `0xC0` (Internal PLL 16 MHz) and High Fuse to `0xDF`:
```bash
avrdude -c usbasp -p t84 -U lfuse:w:0xC0:m -U hfuse:w:0xDF:m
```

### 2. Flash Firmware (Flash & EEPROM)
This flashes the compiled `.hex` file and the `.eep` configuration file to the chip:
```bash
avrdude -c usbasp -p t84 -U flash:w:UltraCIC-III.hex:i -U eeprom:w:UltraCIC-III.eep:i
```

### 3. All-in-One Command
You can also combine everything into a single command to flash the fuses, flash memory, and EEPROM at once:
```bash
avrdude -c usbasp -p t84 -U lfuse:w:0xC0:m -U hfuse:w:0xDF:m -U flash:w:UltraCIC-III.hex:i -U eeprom:w:UltraCIC-III.eep:i
```


Link to the original project:
https://github.com/ManCloud/UltraCIC-III
