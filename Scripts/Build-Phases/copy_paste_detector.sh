set -e

DIR="WeatherApp"

PMD="$HOME/Scripts/pmd-bin-6.30.0/bin/run.sh"
CPD="$HOME/Scripts/cpd_script.php"

if [ -f $PMD ] && [ -f $CPD ] && which php >/dev/null; then
    $PMD cpd --files $DIR --minimum-tokens 50 --language swift --encoding UTF-8 --format net.sourceforge.pmd.cpd.XMLRenderer --failOnViolation true > cpd-output.xml
    php $HOME/Scripts/cpd_script.php -cpd-xml cpd-output.xml
    rm cpd-output.xml
fi