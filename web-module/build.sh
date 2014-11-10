echo BSC BUILD...
bsc build
echo OK

echo COMAPSS BUILD DEV
compass compile
echo OK


echo COMAPSS BUILD PRODUCTION
compass compile -e production
echo OK

echo JS OPTIMIZATION
node optimize.js
echo OK
