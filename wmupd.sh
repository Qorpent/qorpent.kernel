current=$(pwd)
root=$current
iskernel="$( echo $current | grep -E ernel )"
if [ "$iskernel" != "" ]; then
	cd ..
	root=$(pwd)
fi
for f in  $( find . -type d -maxdepth 2 -name *webmodule | grep -vE template.webmodule ) ; do
	cd $f
	name=${f#*/}
	name=${name%.webmodule}
	echo $name
	./make.sh update
	cd $root
done
cd $current