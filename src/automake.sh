libtoolize --force --install -c
rm aclocal.m4
aclocal
autoheader
automake --force --add-missing -c
autoreconf --force --install -I config -I m4
