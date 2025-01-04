#!/opt/homebrew/bin/zsh -e

export PYTHON_BIN_PATH="$HOME/.pyenv/versions/3.11.9/bin/python"
rm -rf libmp
bazelisk clean

bazelisk build --config=darwin_arm64 --compilation_mode=dbg --copt=-g --strip=never --define=MEDIAPIPE_DISABLE_GPU=1 --macos_sdk_version=14.5 mediapipe/examples/desktop/libmp:libmp.dylib --verbose_failures
mkdir -p libmp/arm64/debug
cp mediapipe/examples/desktop/libmp/libmp.h libmp/arm64/debug/libmp.h
cp bazel-bin/mediapipe/examples/desktop/libmp/libmp.dylib libmp/arm64/debug/libmp.dylib
install_name_tool -id @rpath/libmp.dylib libmp/arm64/debug/libmp.dylib
cp bazel-bin/mediapipe/modules/selfie_segmentation/selfie_segmentation.tflite libmp/arm64/debug/selfie_segmentation.tflite

bazelisk build --config=darwin_arm64 --compilation_mode=opt --define=MEDIAPIPE_DISABLE_GPU=1 --macos_sdk_version=14.5 mediapipe/examples/desktop/libmp:libmp.dylib --verbose_failures
mkdir -p libmp/arm64/release
cp mediapipe/examples/desktop/libmp/libmp.h libmp/arm64/release/libmp.h
cp bazel-bin/mediapipe/examples/desktop/libmp/libmp.dylib libmp/arm64/release/libmp.dylib
install_name_tool -id @rpath/libmp.dylib libmp/arm64/release/libmp.dylib
cp bazel-bin/mediapipe/modules/selfie_segmentation/selfie_segmentation.tflite libmp/arm64/release/selfie_segmentation.tflite

bazelisk build --config=darwin_x86_64 --compilation_mode=dbg --copt=-g --strip=never --define=MEDIAPIPE_DISABLE_GPU=1 --macos_sdk_version=14.5 mediapipe/examples/desktop/libmp:libmp.dylib --verbose_failures
mkdir -p libmp/x86_64/debug
cp mediapipe/examples/desktop/libmp/libmp.h libmp/x86_64/debug/libmp.h
cp bazel-bin/mediapipe/examples/desktop/libmp/libmp.dylib libmp/x86_64/debug/libmp.dylib
install_name_tool -id @rpath/libmp.dylib libmp/x86_64/debug/libmp.dylib
cp bazel-bin/mediapipe/modules/selfie_segmentation/selfie_segmentation.tflite libmp/x86_64/debug/selfie_segmentation.tflite

bazelisk build --config=darwin_x86_64 --compilation_mode=opt --define=MEDIAPIPE_DISABLE_GPU=1 --macos_sdk_version=14.5 mediapipe/examples/desktop/libmp:libmp.dylib --verbose_failures
mkdir -p libmp/x86_64/release
cp mediapipe/examples/desktop/libmp/libmp.h libmp/x86_64/release/libmp.h
cp bazel-bin/mediapipe/examples/desktop/libmp/libmp.dylib libmp/x86_64/release/libmp.dylib
install_name_tool -id @rpath/libmp.dylib libmp/x86_64/release/libmp.dylib
cp bazel-bin/mediapipe/modules/selfie_segmentation/selfie_segmentation.tflite libmp/x86_64/release/selfie_segmentation.tflite

exit 0
