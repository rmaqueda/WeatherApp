#!/bin/bash
set -e

SECRET_FILE=$SRCROOT/$PRODUCT_NAME/Preferences/Secrets.plist
SAMPLE_SECRET_FILE=$SRCROOT/$PRODUCT_NAME/Preferences/Secrets_example.plist

START_DATE=$(date +"%s")

if [ ! -f "$SECRET_FILE" ]; then
  echo "error: Setup API KEY in Secrets.plist file."
  cp -v "${SAMPLE_SECRET_FILE}" "${SECRET_FILE}"
fi
 
OUTPUT=`/usr/libexec/PlistBuddy -c "Print :OpenWeatherAPIKey" $SECRET_FILE`
if echo $OUTPUT | grep "Enter"; then
  echo "error: Setup API KEY in Secrets.plist file."
  exit 1
fi

END_DATE=$(date +"%s")
DIFF=$(($END_DATE - $START_DATE))
echo "Copy secrets took $(($DIFF / 60)) minutes and $(($DIFF % 60)) seconds to complete."