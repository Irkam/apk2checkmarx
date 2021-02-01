#/bin/bash

export JAVA_HOME="/etc/alternatives/jre"
EXCLUDE="!**/META-INF, !**/assets, !**/lib, !**/res, !**/junit, !**/java/android/*, !**/java/androidx, !**/java/kotlin, !**/java/kotlinx, !**/java/google, !**java/com/google, *.dex"
tmpdir=$(mktemp -d)
echo "INFO - Decompiling $APKPATH to $tmpdir"
echo "INFO - Excluding $EXCLUDE"

/opt/jadx/bin/jadx --deobf --no-res -e -j 10 --output-dir "$tmpdir" $APKPATH

echo "INFO - Checkmarx Scanning project $CX_TEAM\\$CX_PROJECTNAME on host $CX_USER@$CX_SERVER"
java -Xmx2048m -jar /opt/cxcli/CxConsolePlugin-CLI-2021.1.1.jar Scan \
	-CxServer $CX_SERVER \
	-CxUser $CX_USER \
	-CxPassword $CX_PASSWORD \
	-ProjectName "$CX_TEAM\\$CX_PROJECTNAME" \
	-IncludeExcludePattern "$EXCLUDE" \
	-LocationType folder \
	-LocationPath $tmpdir/src \
	-Comment "$CX_COMMENT" -verbose

