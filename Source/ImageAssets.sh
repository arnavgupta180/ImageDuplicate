#!/bin/sh

#  ImageAssets.sh
#  shellScriptStringGeneration
#
#  Created by Arnav Gupta on 06/12/19.
#  Copyright © 2019 Arnav. All rights reserved.


#configure input variables for script here
projectDir="$PODS_ROOT/ImageDuplicateFinder"
constantsDir="$projectDir/Constants"
outputFile="$constantsDir/ImageConstants.swift"
xcassets="$projectDir/Assets.xcassets"

cd $projectDir

#  remove any previously created temp files
rm txcassets*.* 2>/dev/null
#PROJ=`find . -name '*.xib' -o -name '*.[mh]' -o -name '*.storyboard' -o -name '*.mm' -o -name '*.swift' -o -name '*.m' -o -name '*.h'`
#cat unusedAssets.sh > unusedAssets.sh
#chmod 777 unusedAssets.sh
#
#IFS=$'\n'
#for i in `find . -name "*.imageset"`; do
#name=`basename $i`
#if ! grep -q $name $PROJ; then
#echo "base,$name,end" >> unusedAssets.sh
#fi
#done

#sed -i -e 's/base,/"/;s/,end/",/' unusedAssets.sh
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

echo "public class ImageConstants {" >> txcassets5.sh
echo "    static let imageNames: [String] = [" >> txcassets5.sh
cat txcassets3.sh >> txcassets5.sh
echo "    ]" >> txcassets5.sh
echo "    static let imagePaths: [String] = [" >> txcassets5.sh
cat txcassets1.sh >> txcassets5.sh
echo "    ]" >> txcassets5.sh
#echo "    static let unusedAssets: [String] = [" >> txcassets5.sh
#cat unusedAssets.sh >> txcassets5.sh
#echo "    ]" >> txcassets5.sh
echo "}" >> txcassets5.sh

rm $outputFile
mv txcassets5.sh $outputFile

#  remove any temp files created
rm txcassets*.* 2>/dev/null
