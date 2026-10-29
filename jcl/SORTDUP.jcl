//SORTDUP  JOB (ACCT),'SORT+DEDUP',CLASS=A,MSGCLASS=X,
//             NOTIFY=&SYSUID
//*--------------------------------------------------------------------
//* SORT BY A 10-BYTE KEY AT POS 1, KEEP FIRST OCCURRENCE IN SORTOUT,
//* WRITE DUPLICATES TO XSUM. RECORDS ARE FB 200.
//*--------------------------------------------------------------------
//SORT     EXEC PGM=SORT
//SYSOUT   DD SYSOUT=*
//SORTIN   DD DISP=SHR,DSN=YOUR.HLQ.INPUT
//SORTOUT  DD DSN=YOUR.HLQ.OUTPUT.UNIQUE,
//             DISP=(NEW,CATLG,DELETE),UNIT=SYSDA,
//             SPACE=(CYL,(10,10),RLSE),
//             DCB=(RECFM=FB,LRECL=200,BLKSIZE=0)
//SORTXSUM DD DSN=YOUR.HLQ.OUTPUT.DUPS,
//             DISP=(NEW,CATLG,DELETE),UNIT=SYSDA,
//             SPACE=(CYL,(5,5),RLSE),
//             DCB=(RECFM=FB,LRECL=200,BLKSIZE=0)
//SYSIN    DD *
  SORT FIELDS=(1,10,CH,A)
  SUM FIELDS=NONE,XSUM
/*
