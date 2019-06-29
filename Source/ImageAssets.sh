#!/bin/sh

#  ImageAssets.sh
#  shellScriptStringGeneration
#
#  Created by Arnav Gupta on 06/12/19.
#  Copyright © 2019 Arnav. All rights reserved.


#configure input variables for script here
projectDir="$SRCROOT"
scriptDir="$PODS_ROOT/ImageDuplicate"
# this ensure correct permissions are automatically added to any new shell script added to build-phase directory
ls $scriptDir | while read line; do
path="$projectDir/$line";
chmod u+x $path;
done

outputFile="$scriptDir/AVImageConstants.swift"

cd $projectDir

#  remove any previously created temp files
rm txcassets*.* 2>/dev/null

#  find all imageset names
find . -name '*.imageset' > txcassets1.sh
chmod 777 txcassets1.sh
sed -i -e 's/^/"/;s/$/",/' txcassets1.sh

cat txcassets1.sh > txcassets2.sh
sed -i -e 's/^/basename /' txcassets2.sh
sed -i -e 's/$/ .imageset/' txcassets2.sh

sh txcassets2.sh > txcassets3.sh
sed -i -e 's/^/        "/;s/$/"/' txcassets3.sh
sed -i -e 's/.imageset,"/",/' txcassets3.sh

touch txcassets5.sh
echo "// This file is autogenerated, do not edit here" >> txcassets5.sh
echo "" >> txcassets5.sh

echo "public class AVImageConstants {" >> txcassets5.sh
echo "    static let imageNames: [String] = [" >> txcassets5.sh
cat txcassets3.sh >> txcassets5.sh
echo "    ]" >> txcassets5.sh
echo "    static let imagePaths: [String] = [" >> txcassets5.sh
cat txcassets1.sh >> txcassets5.sh
echo "    ]" >> txcassets5.sh

echo "}" >> txcassets5.sh

rm $outputFile
mv txcassets5.sh $outputFile

#  remove any temp files created
rm txcassets*.* 2>/dev/null

