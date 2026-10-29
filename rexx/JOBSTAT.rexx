/* REXX ------------------------------------------------------------*/
/* JOBSTAT: SHOW STATUS OF JOBS WITH A GIVEN PREFIX (TSO STATUS).   */
/* USAGE (TSO):  EX 'YOUR.REXX.LIB(JOBSTAT)' 'JOBPFX'               */
/*------------------------------------------------------------------*/
parse upper arg prefix .
if prefix = '' then prefix = userid()

x = outtrap('st.')
"STATUS" prefix
x = outtrap('OFF')

if st.0 = 0 then do
  say 'No jobs found for' prefix
  exit 4
end

do i = 1 to st.0
  select
    when pos('EXECUTING', st.i) > 0 then tag = '>> RUNNING '
    when pos('ON OUTPUT QUEUE', st.i) > 0 then tag = 'OK DONE    '
    when pos('WAITING', st.i) > 0 then tag = '.. QUEUED  '
    otherwise tag = '   '
  end
  say tag strip(st.i)
end
exit 0
