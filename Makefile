#Caller Makefile to set Build variables on beforehand
#usage
#  "make attiny25" --> builds UltraCIC-III for attiny25
#  "make clean"    --> cleans all .hex/.obj files

attiny84: export CPU = attiny84
attiny84: export AVRDUDE_CPU = t84

attiny%: 
	+make -f UltraCIC-III.mk
	
clean:
	+make -f UltraCIC-III.mk clean
