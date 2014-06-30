CUR_TC=/home/trinityhaxxorx/ToolChain/bin/

make clean
export ARCH=arm 
export CROSS_COMPILE=${CUR_TC}arm-gnueabi-
make trinity_defconfig
make -j8

echo "checking for compiled kernel..."
if [ -f arch/arm/boot/zImage ]
then

echo "generating device tree..."
./dtbTool -o ../final_files/dt.img -s 2048 -p ./scripts/dtc/ ./arch/arm/boot/

cp arch/arm/boot/zImage ../final_files/.
cp drivers/char/adsprpc.ko ../final_files/.
cp arch/arm/mach-msm/qdsp6v2/adsp-loader.ko ../final_files/.
cp net/wireless/cfg80211.ko ../final_files/.
~/ToolChain/bin/arm-gnueabi-strip --strip-unneeded ../final_files/adsprpc.ko
~/ToolChain/bin/arm-gnueabi-strip --strip-unneeded ../final_files/adsp-loader.ko
~/ToolChain/bin/arm-gnueabi-strip --strip-unneeded ../final_files/cfg80211.ko 

echo "DONE"

fi
