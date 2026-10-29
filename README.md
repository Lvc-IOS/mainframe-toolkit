# mainframe-toolkit 🏦

A collection of COBOL, JCL and REXX snippets I keep reusing while working on z/OS in banking environments.
Everything here is generic and sanitized — no client code, dataset names or business logic.

## Contents

| Path | What it is |
|---|---|
| [`cobol/IBANCHK.cbl`](cobol/IBANCHK.cbl) | IBAN validation (ISO 13616, mod-97) as a callable subprogram |
| [`cobol/DATEUTIL.cbl`](cobol/DATEUTIL.cbl) | Date helpers: validation, day-of-week, add days via `FUNCTION INTEGER-OF-DATE` |
| [`cobol/TESTIBAN.cbl`](cobol/TESTIBAN.cbl) | Small driver that calls `IBANCHK` with sample IBANs |
| [`jcl/COMPLINK.jcl`](jcl/COMPLINK.jcl) | Compile + link-edit a COBOL program (IGYWCL-style, explicit steps) |
| [`jcl/SORTDUP.jcl`](jcl/SORTDUP.jcl) | DFSORT: sort a file by key and drop duplicates to a separate dataset |
| [`jcl/IDCAMS.jcl`](jcl/IDCAMS.jcl) | Define / delete / REPRO a VSAM KSDS |
| [`rexx/DSLIST.rexx`](rexx/DSLIST.rexx) | List datasets matching a pattern with size info (LISTCAT wrapper) |
| [`rexx/JOBSTAT.rexx`](rexx/JOBSTAT.rexx) | Quick TSO status check for jobs with a given prefix |

## Running COBOL locally

You don't need a mainframe to try the COBOL samples — [GnuCOBOL](https://gnucobol.sourceforge.io/) compiles them:

```bash
cobc -x -o testiban cobol/TESTIBAN.cbl cobol/IBANCHK.cbl
./testiban
```

## Conventions

- Fixed-format COBOL (columns 8–72), uppercase, `COPY`-free so each file stands alone
- JCL uses placeholder HLQs (`&SYSUID..`, `YOUR.HLQ`) — replace before submitting
- REXX scripts run under TSO/ISPF (`EX 'YOUR.REXX.LIB(DSLIST)' 'PATTERN'`)

## License

MIT
