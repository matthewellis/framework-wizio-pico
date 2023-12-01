set -e

SDK_BASE=/Users/matthewellis/git/pico-sdk

# Hardware

mkdir -p SDK/hardware
mkdir -p SDK/include/hardware
for i in $(find $SDK_BASE/src/rp2_common -type d -iname "hardware_*"); do

    echo "$i"

    find $i -type f -iname "*.c"  -exec cp -v {}  SDK/hardware \;
    find $i -type f -iname "*.S"  -exec cp -v {}  SDK/hardware \;

    find $i/include/hardware -type f -iname "*.h"  -exec cp -v {}  SDK/include/hardware \;
    
done

cp -r -v $SDK_BASE/src/rp2040/hardware_regs/include/hardware/* SDK/include/hardware/
cp -r -v $SDK_BASE/src/rp2040/hardware_structs/include/hardware/structs SDK/include/hardware/

#  Pico

for i in $(find $SDK_BASE/src/rp2_common -type d -iname "pico_*"); do

    echo "$i"
    DIR_NAME=SDK/pico/$(basename "$i")
    mkdir -p $DIR_NAME
    find $i -type f -iname "*.c"  -exec cp -v {}  $DIR_NAME \;
    find $i -type f -iname "*.S"  -exec cp -v {}  $DIR_NAME \;
    find $i -type f -iname "*.ld"  -exec cp -v {}  $DIR_NAME \;
    find $i -type f -iname "*.cpp"  -exec cp -v {}  $DIR_NAME \;

    mkdir -p SDK/include/pico
    if [ -e $i/include ]; then
        cp -v -r $i/include/ SDK/include/
    fi
    
done

# Common

for i in $(find $SDK_BASE/src/common -type d -iname "*_*"); do

    echo "$i"
    DIR_NAME=SDK/pico/$(basename "$i")
    echo $DIR_NAME
    mkdir -p $DIR_NAME
    find $i -type f -iname "*.c"  -exec cp -v {}  $DIR_NAME \;
    find $i -type f -iname "*.S"  -exec cp -v {}  $DIR_NAME \;

    if [ -e $i/include ]; then
        cp -v -r $i/include/ SDK/include/
    fi
done

# Lib

for i in $SDK_BASE/lib/*; do
    echo "$i"
    cp -v -r $i SDK/lib/
done
