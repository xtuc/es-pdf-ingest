#!/bin/bash

for FILE in $*
do
  if [ -f "$FILE" ]
  then
    HASH=$(md5sum $FILE | awk '{print $1}')

    (echo -n '{"data": "'; base64 $FILE; echo '"}') |
    curl -s -d @- "localhost:9200/pdf/pdf/$HASH?pipeline=attachment&pretty" > /dev/null
  fi
done
