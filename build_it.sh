CUR_TC=/home/trinityhaxxorx/ToolChain/bin/

export ARCH=arm
export CROSS_COMPILE=~/ToolChain/bin/arm-cortex_a15-linux-gnueabihf-
make distclean

export ARCH=arm 
export CROSS_COMPILE=${CUR_TC}arm-cortex_a15-linux-gnueabihf-
make trinity_defconfig
make CONFIG_DEBUG_SECTION_MISMATCH=y -j4

echo "checking for compiled kernel..."
if [ -f arch/arm/boot/zImage ]
then

echo "generating device tree..."
./dtbTool -o ../BuildTools/msm8974_rhine/dt.img -s 2048 -p ./scripts/dtc/ ./arch/arm/boot/

cp arch/arm/boot/zImage ../BuildTools/msm8974_rhine/.
cd ~/BuildTools/msm8974_rhine
./makeit.sh

echo "DONE"

fi
