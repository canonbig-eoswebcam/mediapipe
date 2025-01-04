@echo off
setlocal

SET "BAZEL_VS=C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools"
SET "BAZEL_VC=C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC"
@REM SET "BAZEL_VS=C:\Program Files\Microsoft Visual Studio\2022\Professional"
@REM SET "BAZEL_VC=C:\Program Files\Microsoft Visual Studio\2022\Professional\VC"
SET "BAZEL_SH=C:\msys64\usr\bin\bash.exe"

@REM Optional vars
@REM SET "BAZEL_VC_FULL_VERSION=14.40.33807"
@REM SET "BAZEL_WINSDK_FULL_VERSION=10.0.26100.0"

@REM Use double slashes
SET "PYTHON_BIN_PATH=C:\\Python\\Python312\\python.exe"

rmdir /s /q libmp
bazelisk clean

bazelisk build --compilation_mode=dbg --copt=-g --strip=never --define=MEDIAPIPE_DISABLE_GPU=1 mediapipe/examples/desktop/libmp:libmp.dll --verbose_failures
mkdir libmp\debug
copy mediapipe\examples\desktop\libmp\libmp.h libmp\debug\libmp.h
copy bazel-bin\mediapipe\examples\desktop\libmp\libmp.dll.if.lib libmp\debug\libmp.dll.if.lib
copy bazel-bin\mediapipe\examples\desktop\libmp\libmp.dll libmp\debug\libmp.dll
copy bazel-bin\mediapipe\modules\selfie_segmentation\selfie_segmentation.tflite libmp\debug\selfie_segmentation.tflite

bazelisk build --compilation_mode=opt --define=MEDIAPIPE_DISABLE_GPU=1 mediapipe/examples/desktop/libmp:libmp.dll --verbose_failures
mkdir libmp\release
copy mediapipe\examples\desktop\libmp\libmp.h libmp\release\libmp.h
copy bazel-bin\mediapipe\examples\desktop\libmp\libmp.dll.if.lib libmp\release\libmp.dll.if.lib
copy bazel-bin\mediapipe\examples\desktop\libmp\libmp.dll libmp\release\libmp.dll
copy bazel-bin\mediapipe\modules\selfie_segmentation\selfie_segmentation.tflite libmp\release\selfie_segmentation.tflite

exit /b
