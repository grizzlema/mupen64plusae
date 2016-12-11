#! /bin/sh

cd ..
BASE_DIR=`pwd`
echo "Generating asm defines"
cd "${BASE_DIR}"/app/src/main/jni/mupen64plus-core/src
x86_64-linux-android-g++ -ffunction-sections -funwind-tables -fstack-protector-strong -no-canonical-prefixes \
 -IC:/Users/Francisco/Documents/workspaces/mupen64plus-ae/app/src/main/jni/./mupen64plus-core/src \
 -IC:/Users/Francisco/Documents/workspaces/mupen64plus-ae/app/src/main/jni/png/include/  \
 -IC:/Users/Francisco/Documents/workspaces/mupen64plus-ae/app/src/main/jni/SDL2/include/ \
 -IC:/Users/Francisco/android-sdks/ndk-bundle/build//../sources/cxx-stl/gnu-libstdc++/4.9/include \
 -IC:/Users/Francisco/android-sdks/ndk-bundle/platforms/android-15/arch-arm/usr/include \
 -IC:/Users/Francisco/android-sdks/ndk-bundle/build//../sources/cxx-stl/gnu-libstdc++/4.9/libs/armeabi-v7a/include \
 -IC:/Users/Francisco/android-sdks/ndk-bundle/build//../sources/cxx-stl/gnu-libstdc++/4.9/include/backward \
 -IC:/Users/Francisco/Documents/workspaces/mupen64plus-ae/app/src/main/jni/SDL2/include \
 -IC:/Users/Francisco/Documents/workspaces/mupen64plus-ae/app/src/main/jni \
 -DANDROID -O3 -ffast-math -fno-strict-aliasing -fomit-frame-pointer -frename-registers -fvisibility=hidden -DANDROID  \
 -DIOAPI_NO_64 -DNOCRYPT -DNOUNCRYPT -DUSE_GLES=1 -DDYNAREC -DNEW_DYNAREC=1 -Wa,--noexecstack -Wformat -Werror=format-security  \
 -fno-lto main/asm_defines.c > main/asm_defines_gas.h
