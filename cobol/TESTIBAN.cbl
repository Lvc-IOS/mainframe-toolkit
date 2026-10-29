       IDENTIFICATION DIVISION.
       PROGRAM-ID. TESTIBAN.
      *----------------------------------------------------------------*
      * DRIVER FOR IBANCHK. PRINTS RC FOR A FEW SAMPLE IBANS.          *
      *----------------------------------------------------------------*
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-IBAN             PIC X(34).
       01  WS-RC               PIC S9(4) COMP.
       01  WS-RC-DISP          PIC 9.
       01  WS-SAMPLES.
           05  FILLER PIC X(34)
               VALUE 'IT60 X054 2811 1010 0000 0123 456'.
           05  FILLER PIC X(34)
               VALUE 'DE89370400440532013000'.
           05  FILLER PIC X(34)
               VALUE 'GB82WEST12345698765432'.
           05  FILLER PIC X(34)
               VALUE 'IT60X0542811101000000123457'.
           05  FILLER PIC X(34)
               VALUE 'NOT-AN-IBAN'.
       01  WS-TABLE REDEFINES WS-SAMPLES.
           05  WS-ENTRY        PIC X(34) OCCURS 5 TIMES.
       01  WS-K                PIC 9.

       PROCEDURE DIVISION.
           PERFORM VARYING WS-K FROM 1 BY 1 UNTIL WS-K > 5
               MOVE WS-ENTRY(WS-K) TO WS-IBAN
               CALL 'IBANCHK' USING WS-IBAN WS-RC
               MOVE WS-RC TO WS-RC-DISP
               DISPLAY 'RC=' WS-RC-DISP ' ' WS-IBAN
           END-PERFORM
           STOP RUN.
