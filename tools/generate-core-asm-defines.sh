#! /bin/sh

cd ..
BASE_DIR=`pwd`
cd "${BASE_DIR}"/app/src/main/jni/mupen64plus-core/src

echo "Generating asm defines x86"
"${NDK_HOME}"/toolchains/x86-4.9/prebuilt/windows-x86_64/bin/i686-linux-android-g++ -c -ffunction-sections -funwind-tables -fstack-protector-strong -no-canonical-prefixes \
 -I. \
 -I"${NDK_HOME}"/sources/cxx-stl/gnu-libstdc++/4.9/include \
 -I"${NDK_HOME}"/platforms/android-15/arch-arm/usr/include \
 -I"${NDK_HOME}"/sources/cxx-stl/gnu-libstdc++/4.9/libs/x86/include \
 -I"${NDK_HOME}"/sources/cxx-stl/gnu-libstdc++/4.9/include/backward \
 -DANDROID -O0 -ffast-math -fno-strict-aliasing -fomit-frame-pointer -frename-registers -fvisibility=hidden -DANDROID  \
 -DIOAPI_NO_64 -DNOCRYPT -DNOUNCRYPT -DUSE_GLES=1 -DDYNAREC -DNEW_DYNAREC=1 -Wa,--noexecstack -Wformat -Werror=format-security  \
 -fpermissive main/asm_defines.c -o asm_defines_x86.o
"${NDK_HOME}"/toolchains/x86-4.9/prebuilt/windows-x86_64/i686-linux-android/bin/objdump -C -t asm_defines_x86.o > asm_defines_obj_dump_x86.txt
awk -F " " '/offsetof_struct/ { print "%define " $6 " (0x"$5"-1)" }' asm_defines_obj_dump_x86.txt > main/asm_defines_nasm.h

echo "Generating asm defines arm"
"${NDK_HOME}"/toolchains/arm-linux-androideabi-4.9/prebuilt/windows-x86_64/bin/arm-linux-androideabi-g++ \
 -c -ffunction-sections -funwind-tables -fstack-protector-strong -no-canonical-prefixes \
 -march=armv7-a -mfpu=vfpv3-d16 -mfloat-abi=softfp  -marm -O0 \
 -I. \
 -I"${NDK_HOME}"/sources/cxx-stl/gnu-libstdc++/4.9/include \
 -I"${NDK_HOME}"/platforms/android-15/arch-arm/usr/include \
 -I"${NDK_HOME}"/sources/cxx-stl/gnu-libstdc++/4.9/libs/armeabi-v7a/include \
 -I"${NDK_HOME}"/sources/cxx-stl/gnu-libstdc++/4.9/include/backward \
 -ffast-math -fno-strict-aliasing -fomit-frame-pointer -frename-registers -fvisibility=hidden -DANDROID \
 -DIOAPI_NO_64 -DNOCRYPT -DNOUNCRYPT -DUSE_GLES=1 -DDYNAREC -DNEW_DYNAREC=3 \
 -mfpu=vfp -Wa,--noexecstack -Wformat -Werror=format-security \
 -fpermissive main/asm_defines.c -o asm_defines_arm.o
"${NDK_HOME}"/toolchains/arm-linux-androideabi-4.9/prebuilt/windows-x86_64/arm-linux-androideabi/bin/objdump -C -t asm_defines_arm.o > asm_defines_obj_dump_arm.txt
awk -F " " '/offsetof_struct/ { print "#define " $6 " (0x"$5"-1)" }' asm_defines_obj_dump_arm.txt > main/asm_defines_gas.h
