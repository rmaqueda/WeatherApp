#!/bin/bash
#set -x
set -e

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "Usage: $0 username api_key"
	exit 1
fi

# Upload Test Suite
cp -r ./build/Build/Products/Debug-iphoneos/WeatherAppUITests-Runner.app .
zip --recurse-paths --quiet WeatherAppUITests-Runner.app.zip WeatherAppUITests-Runner.app

# Upload ipa
echo "Uploading ipa..."
APP=`curl --silent --user "$1:$2" \
--request POST "https://api-cloud.browserstack.com/app-automate/xcuitest/v2/app" \
-F "file=@WeatherApp.ipa"`
APP_URL=`echo $APP | jq ".app_url"`
echo $APP_URL

# Upload Test Suite
echo "Uploading test suite..."
TEST_SUITE=`curl --silent --user "$1:$2" \
--request POST "https://api-cloud.browserstack.com/app-automate/xcuitest/v2/test-suite" \
-F "file=@WeatherAppUITests-Runner.app.zip"`
TEST_SUITE_URL=`echo $TEST_SUITE | jq ".test_suite_url"`
echo $TEST_SUITE_URL

# Launch test echo "Launching tests..." 
BUILD=`curl --silent --user "$1:$2" \
--request POST "https://api-cloud.browserstack.com/app-automate/xcuitest/v2/build" \
--data '{"project": "WeatherApp", "devices": ["iPhone 12-14", "iPhone 11 Pro-13", "iPhone 11-14", "iPad Air 4-14"], "app": '$APP_URL', "testSuite": '$TEST_SUITE_URL', "networkLogs": "true", "debugscreenshots": "true", "deviceLogs": "true"}' \
--header "Content-Type: application/json"`

if [[ $BUILD != *Success* ]]; then
	exit 1
fi

BUILD_ID=`echo $BUILD | jq ".build_id" | sed 's/\"//g'`
echo "Build ID: "$BUILD_ID

# Check test status
for value in {1..30}
do
	BUILD_STATUS=`curl --silent --user "$1:$2" \
	--request GET "https://api-cloud.browserstack.com/app-automate/xcuitest/v2/builds/"$BUILD_ID`
	TOTAL_STATUS=`echo $BUILD_STATUS | jq ".status"`
	
	if [[ $TOTAL_STATUS == *passed* ]]; then
		echo $BUILD_STATUS
		exit 0
	fi

	if [[ $TOTAL_STATUS == *failed* ]]; then
		echo $BUILD_STATUS
		exit 1
	fi

	if [[ $TOTAL_STATUS == *error* ]]; then
		echo $BUILD_STATUS
		exit 1
	fi

	echo "Waiting for tests to complete..."
	sleep 10
done

# Build status unknown after 5 min.
echo $BUILD_STATUS
exit 1





