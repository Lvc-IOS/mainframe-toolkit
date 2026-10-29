//VSAMKSDS JOB (ACCT),'DEFINE KSDS',CLASS=A,MSGCLASS=X,
//             NOTIFY=&SYSUID
//*--------------------------------------------------------------------
//* DELETE (IF PRESENT), DEFINE AND LOAD A VSAM KSDS FROM A FLAT FILE.
//* KEY = 12 BYTES AT OFFSET 0, RECORDS 150 BYTES.
//*--------------------------------------------------------------------
//IDCAMS   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//INFILE   DD DISP=SHR,DSN=YOUR.HLQ.SEQ.SORTED
//SYSIN    DD *
  DELETE YOUR.HLQ.ACCOUNTS.KSDS CLUSTER PURGE
  SET MAXCC = 0

  DEFINE CLUSTER ( NAME(YOUR.HLQ.ACCOUNTS.KSDS)  -
                   INDEXED                       -
                   KEYS(12 0)                    -
                   RECORDSIZE(150 150)           -
                   FREESPACE(10 10)              -
                   SHAREOPTIONS(2 3)             -
                   CYLINDERS(5 5) )              -
         DATA    ( NAME(YOUR.HLQ.ACCOUNTS.KSDS.DATA) ) -
         INDEX   ( NAME(YOUR.HLQ.ACCOUNTS.KSDS.INDEX) )

  IF LASTCC = 0 THEN -
    REPRO INFILE(INFILE) OUTDATASET(YOUR.HLQ.ACCOUNTS.KSDS)
/*
