       IDENTIFICATION DIVISION.
       PROGRAM-ID. IBANCHK.
      *----------------------------------------------------------------*
      * VALIDATES AN IBAN USING THE ISO 13616 MOD-97 ALGORITHM.        *
      * CALL 'IBANCHK' USING LK-IBAN LK-RC                             *
      *   LK-IBAN : PIC X(34), LEFT-JUSTIFIED, SPACES ALLOWED          *
      *   LK-RC   : 0 = VALID, 4 = BAD CHECK DIGITS, 8 = BAD FORMAT    *
      *----------------------------------------------------------------*
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-CLEAN            PIC X(34).
       01  WS-REARR            PIC X(34).
       01  WS-LEN              PIC 9(2)  COMP.
       01  WS-I                PIC 9(2)  COMP.
       01  WS-J                PIC 9(2)  COMP.
       01  WS-CHAR             PIC X.
       01  WS-DIGIT            PIC 9(2).
       01  WS-REM              PIC 9(4)  COMP.
       01  WS-ALPHA            PIC X(26)
               VALUE 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
       01  WS-NUMS             PIC X(10) VALUE '0123456789'.
       01  WS-FOUND            PIC X.
       LINKAGE SECTION.
       01  LK-IBAN             PIC X(34).
       01  LK-RC               PIC S9(4) COMP.

       PROCEDURE DIVISION USING LK-IBAN LK-RC.
       MAIN-PARA.
           MOVE 0 TO LK-RC
           PERFORM STRIP-SPACES
           IF WS-LEN < 15 OR WS-LEN > 34
               MOVE 8 TO LK-RC
               GOBACK
           END-IF
      *    MOVE FIRST 4 CHARS TO THE END
           MOVE SPACES TO WS-REARR
           MOVE WS-CLEAN(5:WS-LEN - 4) TO WS-REARR
           MOVE WS-CLEAN(1:4) TO WS-REARR(WS-LEN - 3:4)
      *    MOD-97 ON THE FLY, LETTERS BECOME 10..35
           MOVE 0 TO WS-REM
           PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > WS-LEN
               MOVE WS-REARR(WS-I:1) TO WS-CHAR
               PERFORM CHAR-VALUE
               IF LK-RC NOT = 0
                   GOBACK
               END-IF
               IF WS-DIGIT > 9
                   COMPUTE WS-REM =
                       FUNCTION MOD(WS-REM * 100 + WS-DIGIT, 97)
               ELSE
                   COMPUTE WS-REM =
                       FUNCTION MOD(WS-REM * 10 + WS-DIGIT, 97)
               END-IF
           END-PERFORM
           IF WS-REM NOT = 1
               MOVE 4 TO LK-RC
           END-IF
           GOBACK.

       STRIP-SPACES.
           MOVE SPACES TO WS-CLEAN
           MOVE 0 TO WS-LEN
           PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > 34
               IF LK-IBAN(WS-I:1) NOT = SPACE
                   ADD 1 TO WS-LEN
                   MOVE FUNCTION UPPER-CASE(LK-IBAN(WS-I:1))
                     TO WS-CLEAN(WS-LEN:1)
               END-IF
           END-PERFORM.

       CHAR-VALUE.
           MOVE 'N' TO WS-FOUND
           PERFORM VARYING WS-J FROM 1 BY 1
                   UNTIL WS-J > 10 OR WS-FOUND = 'Y'
               IF WS-CHAR = WS-NUMS(WS-J:1)
                   COMPUTE WS-DIGIT = WS-J - 1
                   MOVE 'Y' TO WS-FOUND
               END-IF
           END-PERFORM
           PERFORM VARYING WS-J FROM 1 BY 1
                   UNTIL WS-J > 26 OR WS-FOUND = 'Y'
               IF WS-CHAR = WS-ALPHA(WS-J:1)
                   COMPUTE WS-DIGIT = WS-J + 9
                   MOVE 'Y' TO WS-FOUND
               END-IF
           END-PERFORM
           IF WS-FOUND = 'N'
               MOVE 8 TO LK-RC
           END-IF.
