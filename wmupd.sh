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
	mkdir build 2>/dev/null

	cp $root/Qorpent.Kernel/template.webmodule/build/update  ./build
	./make.sh update
	cd $root
done
cd $current