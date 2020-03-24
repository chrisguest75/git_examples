#!/usr/bin/env bash

if [[ -z $1 ]]; then 
    echo "Usage: generate_release.sh release|deployment"    
    exit 1
fi 

if [[ ! $(which gomplate) ]]; then
    echo "gomplate tool not found.  Please install and retry"
    exit
fi

if [[ ! -d "./output" ]]; then
    mkdir -p ./output
fi 

git log -n 1 --pretty=format:"%d" 
echo ""
git log --pretty=format:"%h %an%x09%s" $(git merge-base HEAD origin/master)..HEAD
echo ""
echo ""
git log -n 1 --pretty=format:"%d" master
echo ""
git log --pretty=format:"%h %an%x09%s" master

git log  --pretty=format:"'%h', '%an', '%s'" 162856a..ea5f6b1 > ./output/1.0.txt
git log  --pretty=format:"'%h', '%an', '%s'" ea5f6b1..0ea7306 > ./output/1.1.txt
git log  --pretty=format:"'%h', '%an', '%s'" 0ea7306..acf1304 > ./output/1.2.txt
git log  --pretty=format:"'%h', '%an', '%s'" acf1304..58ee502 > ./output/1.3.txt
git log  --pretty=format:"'%h', '%an', '%s'" 58ee502..5144e24 > ./output/2.0.txt
git log  --pretty=format:"'%h', '%an', '%s'" 5144e24..7130ef6 > ./output/2.1.txt
git log  --pretty=format:"'%h', '%an', '%s'" 7130ef6..ab4ffc5 > ./output/2.2.txt
git log  --pretty=format:"'%h', '%an', '%s'" ab4ffc5..8de801d > ./output/2.17.txt
echo ""

if [[ $1 == "release" ]]; then 
    TEMPLATE=./release_notes.gomplate

    for filename in ./output/*.txt; do
        version=$(basename ${filename} .txt)
        echo "{'version':'${version}', 'url':'https://github.com/chrisguest75/git_examples'}" | gomplate --file ${TEMPLATE} -c version=stdin:///in.json -c .=${filename} > ./output/${version}.md  
    done

    echo "# RELEASE NOTES" > RELEASE_NOTES.md
    for filename in $(ls ./output | grep md | sort -Vr); do
        cat "./output/${filename}" >> RELEASE_NOTES.md
    done
elif [[ $1 == "deployment" ]]; then 
    TEMPLATE=./deployed.gomplate

    for filename in ./output/*.txt; do
        version=$(basename ${filename} .txt)
        echo "{'version':'${version}', 'url':'https://github.com/chrisguest75/git_examples'}" | gomplate --file ${TEMPLATE} -c emojis=deployment_emojis.json -c version=stdin:///in.json -c .=${filename} > ./output/${version}.md  
    done

    echo "# DEPLOYMENTS" > DEPLOYMENTS.md
    for filename in $(ls ./output | grep md | sort -Vr); do
        cat "./output/${filename}" >> DEPLOYMENTS.md
    done
else
    echo "$1 not recognised"
fi