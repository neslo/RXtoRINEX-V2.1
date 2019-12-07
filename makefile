CC = g++
CFLAGS  = -g -Wall
INCLUDES = -I CommonClasses/src -I SerialTxRx/src_Ubuntu
VPATH=CommonClasses/src Commands/src SerialTxRx/src_Ubuntu

default: RXtoOSP OSPtoTXT OSPtoRINEX

raspbian: RXtoOSP OSPtoTXT OSPtoRINEX
	mkdir -p Commands/bin/raspbian
	cp $^ Commands/bin/raspbian

RXtoOSP: RXtoOSP.o ArgParser.o SerialTxRx.o Logger.o Utilities.o
	$(CC) $(CFLAGS) -o $@  $^

RXtoOSP.o: RXtoOSP.cpp ArgParser.h SerialTxRx.h Utilities.h Logger.h
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

OSPtoTXT: OSPtoTXT.o ArgParser.o OSPMessage.o Logger.o Utilities.o
	$(CC) $(CFLAGS) -o $@  $^

OSPtoTXT.o: OSPtoTXT.cpp  ArgParser.h OSPMessage.h Utilities.h Logger.h
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

OSPtoRINEX: OSPtoRINEX.o ArgParser.o RinexData.o Logger.o Utilities.o GNSSdataFromOSP.o RTKobservation.o OSPMessage.o
	$(CC) $(CFLAGS) -o $@  $^

OSPtoRINEX.o: OSPtoRINEX.cpp ArgParser.h Utilities.h Logger.h GNSSdataFromOSP.h RinexData.h
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

ArgParser.o: ArgParser.cpp ArgParser.h 
	$(CC) $(CFLAGS) -c $< -o $@

Logger.o: Logger.cpp Logger.h
	$(CC) $(CFLAGS) -c $< -o $@

Utilities.o: Utilities.cpp Utilities.h
	$(CC) $(CFLAGS) -c $< -o $@

OSPMessage.o: OSPMessage.cpp OSPMessage.h
	$(CC) $(CFLAGS) -c $< -o $@

RinexData.o: RinexData.cpp RinexData.h
	$(CC) $(CFLAGS) -c $< -o $@

GNSSdataFromOSP.o: GNSSdataFromOSP.cpp GNSSdataFromOSP.h Utilities.h RTKobservation.h
	$(CC) $(CFLAGS) -c $< -o $@

RTKobservation.o: RTKobservation.cpp RTKobservation.h
	$(CC) $(CFLAGS) -c $< -o $@

SerialTxRx.o: SerialTxRx.cpp SerialTxRxErrorMSG.h SerialTxRx.h
	$(CC) $(CFLAGS) -c $< -o $@

clean: 
	$(RM) RXtoOSP OSPtoTXT OSPtoRINEX *.o *~
