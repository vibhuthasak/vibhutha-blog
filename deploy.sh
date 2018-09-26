#!/bin/bash

rm -rf public

echo -e "\033[0;32mCompling...\033[0m"
hugo
#Goto dir and remove git repository expect CNAME file:
echo -e "/media/vibhutha/Academic/vibhuthasak.github.io"
shopt -s extglob
cd /media/vibhutha/Academic/vibhuthasak.github.io 
rm -rf -v -- !(CNAME)

# Comming Backto VIBHUTHA-BLOG
echo -e "Copying data"
# cd /media/vibhutha/Academic/vibhutha-sak-hugo/vibhutha-blog
cp -a /media/vibhutha/Academic/vibhutha-sak-hugo/vibhutha-blog/public/. /media/vibhutha/Academic/vibhuthasak.github.io

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

git add .
# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

cd /media/vibhutha/Academic/vibhutha-sak-hugo/vibhutha-blog