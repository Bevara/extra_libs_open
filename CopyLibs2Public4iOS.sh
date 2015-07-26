#!/bin/sh

cp SDL_iOS/SDL2/include/*.h ../gpac_public/extra_lib/include/SDL2/
cp SDL_iOS/glues/source/glues.h ../gpac_public/extra_lib/include/
cp lib/iOS/*.a ../gpac_public/extra_lib/lib/iOS/

#replace FFMPEG headers in gpac public
rm -rf ../gpac_public/extra_lib/include/libav*
rm -rf ../gpac_public/extra_lib/include/libsw*
cp -r ffmpeg_ios/FFmpeg-iOS/include/* ../gpac_public/extra_lib/include/

#copy FFMPEG binaries
cp ffmpeg_ios/FFmpeg-iOS/lib/* ../gpac_public/extra_lib/lib/iOS/

