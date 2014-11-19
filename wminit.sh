current=$(pwd)
root=$current
iskernel="$( echo $current | grep -E ernel )"
if [ "$iskernel" != "" ]; then
	cd ..
	root=$(pwd)
fi
./Qorpent.Kernel/template.webmodule/build/init $*
cd $current