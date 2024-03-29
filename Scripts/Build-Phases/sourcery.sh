#!/bin/bash
set -e

SOURCESPATH="WeatherApp"
TEMPLATESPATH="Common/Sourcery"
OUTPUTPATH="Common/Sourcery/Autogenerated"
CURRENTFRAMEWORKNAME="WeatherApp"

START_DATE=$(date +"%s")

if which sourcery >/dev/null; then
  sourcery --sources "$SOURCESPATH" \
    --templates "$TEMPLATESPATH" \
    --output "$OUTPUTPATH" \
    --args module="$CURRENTFRAMEWORKNAME",import="Foundation",import="Combine",import="UIKit",import="MapKit"
fi

END_DATE=$(date +"%s")
DIFF=$(($END_DATE - $START_DATE))
echo "Sourcery took $(($DIFF / 60)) minutes and $(($DIFF % 60)) seconds to complete."
