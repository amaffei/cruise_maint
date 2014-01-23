#!/bin/bash
# vocab_compdeids.sh <csv1> <csv2>
# compare first column of 2 vocabs to see differences if deviceids in each
#
# Cruise Metadata
# take only first field and remove quotes
#
sed -e 's/,.*$//' -e 's/\"//g' $1 | sort | uniq > /tmp/tmpandytmp1
sed -e 's/,.*$//' -e 's/\"//g' $2 | sort | uniq > /tmp/tmpandytmp2
diff /tmp/tmpandytmp1 /tmp/tmpandytmp2
