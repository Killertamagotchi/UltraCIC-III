Der Fork vom Originalen UltraCIC-III Projekt ist ein Port für den ATTiny84/84a.
Hintergrund hierzu ist, das einige Repro Flash PCBs die man z.B. bei AliExpress Finden kann anstelle eines
ATTiny25, ATTiny45 oder ATTiny85 wofür der Originale Code geschrieben wurden ist ein ATTiny84/84a verbaut haben.
Allerdings haben die nicht gerade selten einen alten Code drauf der kein Automatisches Umschalten zwischen PAL und NTSC erlauben.
Hiermit kann man eine Angepasste Version von dem Originalen Code auf den ATTiny84/84a Flaschen womit auch die Repor Module dann funktionieren sollten

Bevor man aber den neuen Code drauf Flashed sollte man sicherhalbs halber ein Backup von dem Code vom ATTiny84/84a machen.

Zum erstellen der benötigten Dateien einfach wie schon im Originalen Code vorgehen.
Allerdings hier dann den Befehl ausführen

"make attiny84"

Danach sollte im Ordner die Dateien enthalten sein:
- UltraCIC-III_t84.hex
- UltraCIC-III.eep.hex

Zusätzlich für das Aufspielen auf den ATTiny84/84a müssen in AVRDUDE (bevorzuge das GUI AVRDUDESS)
folgende Fuses gesetzt werden:
- L: 0xC0
- H: 0xDF
- E: 0xFF (oder 0x01, beides deaktiviert das Self-Programming)

Ausserdem muss auch der Bitclock gesetzt werden um sicher zu stellen das es auch sauber geschrieben wird bzw. kein Fehler kommt

- -B 125kHz
  
oder

- -B 32kHz

Sofern in der UltraCIC-III.asm nicht nochmal abgeänderst ist der Standart Boot auf NTSC und man muss für PAL dann das Modul im PAL N64 einmal einschlaten und wieder aus um das die Region umschaltet.

Will man aber PAL als Standart dann wie im Original Code folgende Stelle ändern

- .ESEG
- ;.db 0x08   ;set PAL as inital region
- .db 0x00    ;set NTSC as initial region

in

- .ESEG
- .db 0x08   ;set PAL as inital region
- ;.db 0x00    ;set NTSC as initial region


Link zum Originalen Projekt:
https://github.com/ManCloud/UltraCIC-III

_____________________________________________________________________________________

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


Link to the original project:
https://github.com/ManCloud/UltraCIC-III
