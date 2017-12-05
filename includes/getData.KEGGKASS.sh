KAAS=$1
EMAIL=$2

if [[  -z $KASS  ||  -z $EMAIL ]] ; then echo "please input KAAS_JOB_ID SUBMISSION_EMAIL" ; exit 1 ; fi


mkdir $KAAS
cd $KAAS

## get pathway info
curl -o pathway.html "http://www.genome.jp/kaas-bin/kaas_main?mode=map&id=$KAAS&mail=$EMAIL"

## get ko info
curl -OL http://www.genome.jp/tools/kaas/files/dl/$KAAS/query.ko 

## get html with all KOs
curl -o "$KAAS.html" "http://www.genome.jp/kaas-bin/kaas_main?mode=brite&id=$KAAS&mail=$EMAIL"

## get list of KOs
perl getBriteQvalues.pl $KAAS.html > $KAAS.kaas.results

## get KO files
for i in `cat $KAAS.kaas.results`; do  curl -o "$i.keg" "http://www.genome.jp/kegg-bin/download_htext?htext=$i.keg&format=htext&filedir=/tools/kaas/files/log/result/$KAAS" ; done

## package it up!!
cd ..
tar -cf $KAAS.heir.tar $KAAS
gzip -9 $KAAS.heir.tar
