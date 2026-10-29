/* REXX ------------------------------------------------------------*/
/* DSLIST: LIST CATALOGED DATASETS MATCHING A PATTERN.              */
/* USAGE (TSO):  EX 'YOUR.REXX.LIB(DSLIST)' 'YOUR.HLQ.**'           */
/*------------------------------------------------------------------*/
parse upper arg pattern .
if pattern = '' then pattern = userid()'.**'

x = outtrap('cat.')
"LISTCAT LEVEL('"strip(pattern, 'T', '*')"') NAME"
rc_cat = rc
x = outtrap('OFF')

if rc_cat > 4 then do
  say 'LISTCAT failed, RC='rc_cat
  exit rc_cat
end

count = 0
do i = 1 to cat.0
  parse var cat.i type '-' dsn .
  type = strip(type)
  if type = 'NONVSAM' | type = 'CLUSTER' then do
    count = count + 1
    say left(strip(dsn), 44) type
  end
end
say count 'dataset(s) found for' pattern
exit 0
