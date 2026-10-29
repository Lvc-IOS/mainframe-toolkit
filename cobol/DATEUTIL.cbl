       IDENTIFICATION DIVISION.
       PROGRAM-ID. DATEUTIL.
      *----------------------------------------------------------------*
      * DATE HELPERS. CALL 'DATEUTIL' USING LK-FUNC LK-DATE LK-DAYS    *
      *                                    LK-OUT LK-RC                *
      *   LK-FUNC 'V' : VALIDATE LK-DATE (YYYYMMDD)                    *
      *   LK-FUNC 'W' : DAY OF WEEK -> LK-OUT (1=MON .. 7=SUN)         *
      *   LK-FUNC 'A' : LK-DATE + LK-DAYS -> LK-OUT (YYYYMMDD)         *
      *   LK-RC 0 = OK, 8 = INVALID DATE, 12 = BAD FUNCTION            *
      *----------------------------------------------------------------*
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-INT              PIC S9(9) COMP.
       01  WS-DATE-N           PIC 9(8).
       LINKAGE SECTION.
       01  LK-FUNC             PIC X.
       01  LK-DATE             PIC 9(8).
       01  LK-DAYS             PIC S9(7) COMP-3.
       01  LK-OUT              PIC 9(8).
       01  LK-RC               PIC S9(4) COMP.

       PROCEDURE DIVISION USING LK-FUNC LK-DATE LK-DAYS LK-OUT LK-RC.
       MAIN-PARA.
           MOVE 0 TO LK-RC
           MOVE 0 TO LK-OUT
           IF FUNCTION TEST-DATE-YYYYMMDD(LK-DATE) NOT = 0
               MOVE 8 TO LK-RC
               GOBACK
           END-IF
           EVALUATE LK-FUNC
               WHEN 'V'
                   CONTINUE
               WHEN 'W'
                   COMPUTE WS-INT = FUNCTION INTEGER-OF-DATE(LK-DATE)
                   COMPUTE LK-OUT = FUNCTION MOD(WS-INT - 1, 7) + 1
               WHEN 'A'
                   COMPUTE WS-INT =
                       FUNCTION INTEGER-OF-DATE(LK-DATE) + LK-DAYS
                   COMPUTE LK-OUT = FUNCTION DATE-OF-INTEGER(WS-INT)
               WHEN OTHER
                   MOVE 12 TO LK-RC
           END-EVALUATE
           GOBACK.
