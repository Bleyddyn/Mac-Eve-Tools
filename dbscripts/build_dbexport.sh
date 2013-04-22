#!/bin/bash

DBEXPORT=database.sql

DBVERSION=9
DBEXPANSION="Retribution 1.1.0"

VERQUERY="INSERT INTO version VALUES ($DBVERSION,'$DBEXPANSION');"



rm -f tempdb.db
rm -f rows.sql

#/bin/bash dumprows.sh rows.sql
# Can be downloaded from: http://pozniak.pl/dbdump/ (I think)
# Or here: http://www.fuzzwork.co.uk/dump/retribution-1.1-84566/eve.db.bz2
sqlite3 retribution11.sqlite .dump > ${DBEXPORT}

#/bin/cat tables.sql rows.sql post.sql > $DBEXPORT
/bin/cat tables.sql post.sql >> $DBEXPORT
echo "$VERQUERY" >> $DBEXPORT
/usr/bin/bzip2 < $DBEXPORT > $DBEXPORT.bz2
/usr/bin/sqlite3 tempdb.db < $DBEXPORT 


SHA_SQL=`./sha1 $DBEXPORT`
SHA_BZ2=`./sha1 $DBEXPORT.bz2`
SHA_DB=`./sha1 tempdb.db`

XML="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<EveDatabaseExport version=\"$DBVERSION\">
	<file>$DBEXPORT.bz2</file>
	<sha1_bzip>$SHA_BZ2</sha1_bzip>
	<sha1_dec>$SHA_SQL</sha1_dec>
	<sha1_built>$SHA_DB</sha1_built>
</EveDatabaseExport>"


echo $XML > MacEveApi-database.xml

#rm -f $DBEXPORT
rm -f tempdb.db
rm -f rows.sql

