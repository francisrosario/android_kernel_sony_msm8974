CUR_TC=/home/trinityhaxxorx/ToolChain/bin/

export ARCH=arm
export CROSS_COMPILE=~/ToolChain/bin/arm-cortex_a15-linux-gnueabihf-
make distclean

export ARCH=arm 
export CROSS_COMPILE=${CUR_TC}arm-cortex_a15-linux-gnueabihf-
make trinity_defconfig
make CONFIG_DEBUG_SECTION_MISMATCH=y

echo "checking for compiled kernel..."
if [ -f arch/arm/boot/zImage ]
then

echo "generating device tree..."
./dtbTool -o ../final_files/dt.img -s 2048 -p ./scripts/dtc/ ./arch/arm/boot/

cp arch/arm/boot/zImage ../final_files/.
cp drivers/char/adsprpc.ko ../final_files/.
cp drivers/exfat/exfat_fs.ko ../final_files/.
cp drivers/exfat/exfat_core.ko ../final_files/.
cp drivers/staging/prima/wlan.ko ../final_files/pronto_wlan.ko
~/ToolChain/bin/arm-cortex_a15-linux-gnueabihf-strip --strip-unneeded ../final_files/pronto_wlan.ko
~/ToolChain/bin/arm-cortex_a15-linux-gnueabihf-strip --strip-unneeded ../final_files/exfat_fs.ko
~/ToolChain/bin/arm-cortex_a15-linux-gnueabihf-strip --strip-unneeded ../final_files/exfat_core.ko
~/ToolChain/bin/arm-cortex_a15-linux-gnueabihf-strip --strip-unneeded ../final_files/nls_utf8.ko

echo "DONE"

fi
