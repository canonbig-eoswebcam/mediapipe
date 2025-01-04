# Description:
#   OpenCV libraries for video/image processing on MacOS

load("@bazel_skylib//lib:paths.bzl", "paths")

licenses(["notice"])  # BSD license

exports_files(["LICENSE"])

config_setting(
    name = "arm64_debug",
    values = {
        "apple_platform_type": "macos",
        "cpu": "darwin_arm64",
        "compilation_mode": "dbg",
    },
)

config_setting(
    name = "arm64_release",
    values = {
        "apple_platform_type": "macos",
        "cpu": "darwin_arm64",
        "compilation_mode": "opt",
    },
)

config_setting(
    name = "x86_64_debug",
    values = {
        "apple_platform_type": "macos",
        "cpu": "darwin_x86_64",
        "compilation_mode": "dbg",
    },
)

config_setting(
    name = "x86_64_release",
    values = {
        "apple_platform_type": "macos",
        "cpu": "darwin_x86_64",
        "compilation_mode": "opt",
    },
)

cc_library(
    name = "opencv",
    srcs = select({
        "//conditions:default": ["lib/libopencv_world.dylib"],
        ":arm64_debug": ["arm64/debug/lib/libopencv_world.dylib"],
        ":arm64_release": ["arm64/release/lib/libopencv_world.dylib"],
        ":x86_64_debug": ["x86_64/debug/lib/libopencv_world.dylib"],
        ":x86_64_release": ["x86_64/release/lib/libopencv_world.dylib"],
    }),
    hdrs = select({
        "//conditions:default": glob(["include/opencv4/opencv2/**/*.h*"]),
        ":arm64_debug": glob(["arm64/debug/include/opencv4/opencv2/**/*.h*"]),
        ":arm64_release": glob(["arm64/release/include/opencv4/opencv2/**/*.h*"]),
        ":x86_64_debug": glob(["x86_64/debug/include/opencv4/opencv2/**/*.h*"]),
        ":x86_64_release": glob(["x86_64/release/include/opencv4/opencv2/**/*.h*"]),
    }),
    includes = select({
        "//conditions:default": ["include/opencv4/"],
        ":arm64_debug": ["arm64/debug/include/opencv4/"],
        ":arm64_release": ["arm64/release/include/opencv4/"],
        ":x86_64_debug": ["x86_64/debug/include/opencv4/"],
        ":x86_64_release": ["x86_64/release/include/opencv4/"],
    }),
    linkstatic = 1,
    visibility = ["//visibility:public"],
)
