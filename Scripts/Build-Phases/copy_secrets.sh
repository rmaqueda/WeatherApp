set -e

SECRET_FILE=$SRCROOT/$PRODUCT_NAME/Preferences/Secrets.plist
SAMPLE_SECRET_FILE=$SRCROOT/$PRODUCT_NAME/Preferences/Secrets_example.plist

if [ ! -f "$SECRET_FILE" ]; then
  echo "error: Setup API KEY in Secrets.plist file."
  cp -v "${SAMPLE_SECRET_FILE}" "${SECRET_FILE}"
fi
 
OUTPUT=`/usr/libexec/PlistBuddy -c "Print :OpenWeatherAPIKey" $SECRET_FILE`
if echo $OUTPUT | grep "Enter"; then
  echo "error: Setup API KEY in Secrets.plist file."
  exit 1
fi