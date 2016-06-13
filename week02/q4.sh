#! /bin/sh
export COPY_ALL=1

for i in html cgi; do
	cp -ru ~/proj/$i ~/public_html/
	#-u: copy only when the SOURCE file is newer than the destination file
done
