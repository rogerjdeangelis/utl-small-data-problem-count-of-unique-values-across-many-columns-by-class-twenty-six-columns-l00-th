Small data problem count of unique values across many columns by class twenty-six columns l00 thousand rows

Takes less than one second

For large data problem see

github
https://tinyurl.com/y8srtnsz
https://github.com/rogerjdeangelis/utl-fast-algorithms-for-count-distinct-levels-for-10000-variables-and-3-million-records-sort-sql-fre

SAS Forum
https://tinyurl.com/yyce75yp
https://communities.sas.com/t5/New-SAS-User/count-of-unique-values-across-many-columns-by-class/m-p/534365

macros
https://tinyurl.com/y9nfugth
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories


INPUT
=====

* I have this in my autoexec;
%let letters=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z;

data have;
  retain grp;
  array ltrs &letters;
  do rec=1 to 100000;
     grp=put(round(rec,3333),z6.);
     do over ltrs;
       ltrs = int(1000*uniform(1234));
     end;
     output;
  end;
  drop rec;
run;quit;

WORK.HAVE total obs=100,000

  GRP      A   B     C  ...    W    X   Y    Z

 000000  243   89  383  ...  255  436  124  713
 000000    2  510  905  ...  966  574  314  654
 000000  546  693  602  ...  381  910  274  590
 ...
 096657  589   93    8  ...  202  311  476  401
 096657  174  125  478  ...   39    3  184  274
 096657  313  971    3  ...  418  542  349  735


EXAMPLE OUTPUT
--------------

 GRP      A     B     C            X     Y     Z

 000000   781   811   808   ...   813   816   827
 003333   958   976   967   ...   968   966   957
 006666   968   969   963   ...   960   959   970
 ...
 093324   965   968   967   ...   961   959   960
 096657   967   965   956   ...   967   978   963
 099990   800   807   803   ...   814   801   817


PROCESS
=======

%array(ltr,values=&letters);

proc sql;
  create
      table want as
  select
      grp
     ,%do_over(ltr,between=comma,phrase=
         count(distinct ?) as ?
    )
  from
    have
  group
    by grp
;quit;

NOTE: PROCEDURE SQL used (Total process time):
      real time           0.95 seconds
      user cpu time       0.73 seconds


