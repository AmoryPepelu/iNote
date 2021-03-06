#!/bin/sh
NDK=/Users/chenliuyong/program/android-ndk-r16b
API=21
PLATFORM=arm-linux-androideabi
SYSROOT=$NDK/platforms/android-$API/arch-arm/
ISYSROOT=$NDK/sysroot
ASM=$ISYSROOT/usr/include/$PLATFORM
TOOLCHAIN=$NDK/toolchains/$PLATFORM-4.9/prebuilt/darwin-x86_64
CPU=arm
PREFIX=$(pwd)/android/$CPU
ADDI_CFLAGS="-marm"
function build_one
{
    ./configure \
    --prefix=$PREFIX \
    --enable-shared \
    --enable-static \
    --enable-pic \
    --disable-asm \
    --disable-cli \
    --disable-thread \
    --host=arm-linux \
    --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
    --sysroot=$SYSROOT \
    --extra-cflags="-I$ASM -isysroot $ISYSROOT -D__ANDROID_API__=$API" \
    --extra-ldflags="$ADDI_LDFLAGS"
    make clean
    make
    make install
}
build_one