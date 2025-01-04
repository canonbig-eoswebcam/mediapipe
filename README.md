# LibMP: MediaPipe as a Shared Library

## Integrate MediaPipe into Your C++ Application

A new MediaPipe build target has been added under [`/mediapipe/examples/desktop/libmp`](/mediapipe/examples/desktop/libmp). Using Bazel, you can build this target to create a shared library (`.so` on Linux, `.dll` on Windows), which you can then integrate - along with its [`.h` header file](/mediapipe/examples/desktop/libmp/libmp.h) - into any C++ application you wish.

Compilation has been tested on Windows (VS 2022 17.6.16, MSVC 19.36.32546) and Ubuntu 20.04 (GCC 9.4.0).

Enormous thanks to [@asprecic](https://github.com/asprecic) for sharing [`libexample`](https://github.com/asprecic/mediapipe/blob/linux-lib-example/mediapipe/examples/desktop/libexample), which made LibMP possible!

## Prerequisites
### Linux
- Bazel
- OpenCV
    - Download pre-compiled binaries: `sudo apt-get install libopencv-core-dev libopencv-imgproc-dev libopencv-imgcodecs-dev`
    - Alternatively, build from source
- By default, this repository's Bazel build files expect OpenCV to be version 4 and installed using the `apt` package manager (i.e., at `/usr`). To match build settings to your own OpenCV version and path, modify the following Bazel files:
    - `/third_party/opencv_linux.BUILD` (search for "OPENCV_VERSION")
    - `/WORKSPACE` (search for "linux_opencv")
### Windows
- **NOTE:** If using Visual Studio, please use VS 2022 17.6 or above. There is a bug in VS 2022 17.4 and 17.5 that causes MediaPipe to fail to link/compile. See rajkundu/mediapipe#1 for more details.
- Bazel
- OpenCV
    - Download pre-compiled binaries
        - Visit https://sourceforge.net/projects/opencvlibrary/files
        - Click on folder of desired OpenCV version (e.g., 4.6.0)
        - Download and run the installer `.exe` (e.g., `opencv-4.6.0-vc14_vc15.exe`)
    - Alternatively, build from source
- By default, this repository's Bazel build files expect OpenCV to be version `4.6.0` and installed at `C:\opencv`. To match build settings to your own OpenCV version and path, modify the following Bazel files:
    - `/third_party/opencv_windows.BUILD` (search for "OPENCV_VERSION")
    - `/WORKSPACE` (search for "windows_opencv")


## Building
### Linux
1. `git clone` this repository and `cd` into it
2. Run `bazel build -c opt --define MEDIAPIPE_DISABLE_GPU=1 mediapipe/examples/desktop/libmp:libmp.so`
### Windows
1. `git clone` this repository and `cd` into it
2. Run `build_libmp_win.sh` (Bash) or `build_libmp_win.bat` (CMD, Powershell)
    - Edit the Bazel-related environmental variables defined by the script(s) as necessary
    - Bazel requires a Python executable with access to NumPy
      - E.g., create a new conda environment, run `conda install numpy`, then point Bazel to the environment's Python executable


## Usage
1. The header file that goes with libmp can be found at [`/mediapipe/examples/desktop/libmp/libmp.h`](/mediapipe/examples/desktop/libmp/libmp.h)
2. The library files can be found under
`/bazel-bin/mediapipe/examples/desktop/libmp` as follows:
    - On Linux:
        1. Use the `libmp.so` shared library in your project
    - On Windows:
        1. Copy `libmp.dll` to your binary's output location (or otherwise ensure that it is in your PATH)
        2. Use the `libmp.dll.if.lib` [import library](https://en.wikipedia.org/wiki/Dynamic-link_library#Import_libraries) in your project
        3. Also copy `opencv_world###.dll` to your binary's output location (or otherwise ensure it is in your PATH)
3. In your binary's output location, create a `mediapipe` directory. Copy the `modules` and `models` folders from **`/bazel-bin/mediapipe`** into this new directory. (Be sure to copy from `/bazel-bin/mediapipe`, _NOT_ `/mediapipe`, as the latter contains empty source directories.)


## Notes
- Unused OpenCV libraries are disabled in `/third_party/opencv_linux.BUILD`. If you need them, you can re-enable them to get them linked in the final binary too.
- One recent breaking change to MediaPipe is that models (e.g., `.tflite` files) are no longer included in the repository itself. They are instead hosted on [Google Cloud Storage (GCS)](https://storage.googleapis.com/mediapipe-assets/). If your code is not working for some reason, you can manually clone an older version of [`google/mediapipe`](https://github.com/google/mediapipe) and copy the source `/mediapipe/models` and `/mediapipe/modules` folders over to your binary's location. See [cc6a2f7](https://github.com/google/mediapipe/tree/cc6a2f7af65977248b2a15f471503da2832f583a) for the last versions of these folders before deletion.
- Bazel version 7.0.0 removes `apple_common.multi_arch_split`, resulting in the error `'apple_common' value has no field or method 'multi_arch_split'`. Using Bazel version 6 fixes the issue.
- An error related to `local_execution_config_python` may be encountered when building on Windows in CMD using `build_libmp_win.bat`. This has been fixed by adding `BAZEL_SH` to the environmental variables and pointing it to MSYS2's `bash.exe`.

## Contributions
Questions, suggestions, issues, pull requests, etc. are all welcome!

---

**Attention:** *We have moved to
[https://developers.google.com/mediapipe](https://developers.google.com/mediapipe)
as the primary developer documentation site for MediaPipe as of April 3, 2023.*

![MediaPipe](https://developers.google.com/static/mediapipe/images/home/hero_01_1920.png)

**Attention**: MediaPipe Solutions Preview is an early release. [Learn
more](https://developers.google.com/mediapipe/solutions/about#notice).

**On-device machine learning for everyone**

Delight your customers with innovative machine learning features. MediaPipe
contains everything that you need to customize and deploy to mobile (Android,
iOS), web, desktop, edge devices, and IoT, effortlessly.

*   [See demos](https://goo.gle/mediapipe-studio)
*   [Learn more](https://developers.google.com/mediapipe/solutions)

## Get started

You can get started with MediaPipe Solutions by by checking out any of the
developer guides for
[vision](https://developers.google.com/mediapipe/solutions/vision/object_detector),
[text](https://developers.google.com/mediapipe/solutions/text/text_classifier),
and
[audio](https://developers.google.com/mediapipe/solutions/audio/audio_classifier)
tasks. If you need help setting up a development environment for use with
MediaPipe Tasks, check out the setup guides for
[Android](https://developers.google.com/mediapipe/solutions/setup_android), [web
apps](https://developers.google.com/mediapipe/solutions/setup_web), and
[Python](https://developers.google.com/mediapipe/solutions/setup_python).

## Solutions

MediaPipe Solutions provides a suite of libraries and tools for you to quickly
apply artificial intelligence (AI) and machine learning (ML) techniques in your
applications. You can plug these solutions into your applications immediately,
customize them to your needs, and use them across multiple development
platforms. MediaPipe Solutions is part of the MediaPipe [open source
project](https://github.com/google/mediapipe), so you can further customize the
solutions code to meet your application needs.

These libraries and resources provide the core functionality for each MediaPipe
Solution:

*   **MediaPipe Tasks**: Cross-platform APIs and libraries for deploying
    solutions. [Learn
    more](https://developers.google.com/mediapipe/solutions/tasks).
*   **MediaPipe models**: Pre-trained, ready-to-run models for use with each
    solution.

These tools let you customize and evaluate solutions:

*   **MediaPipe Model Maker**: Customize models for solutions with your data.
    [Learn more](https://developers.google.com/mediapipe/solutions/model_maker).
*   **MediaPipe Studio**: Visualize, evaluate, and benchmark solutions in your
    browser. [Learn
    more](https://developers.google.com/mediapipe/solutions/studio).

### Legacy solutions

We have ended support for [these MediaPipe Legacy Solutions](https://developers.google.com/mediapipe/solutions/guide#legacy)
as of March 1, 2023. All other MediaPipe Legacy Solutions will be upgraded to
a new MediaPipe Solution. See the [Solutions guide](https://developers.google.com/mediapipe/solutions/guide#legacy)
for details. The [code repository](https://github.com/google/mediapipe/tree/master/mediapipe)
and prebuilt binaries for all MediaPipe Legacy Solutions will continue to be
provided on an as-is basis.

For more on the legacy solutions, see the [documentation](https://github.com/google/mediapipe/tree/master/docs/solutions).

## Framework

To start using MediaPipe Framework, [install MediaPipe
Framework](https://developers.google.com/mediapipe/framework/getting_started/install)
and start building example applications in C++, Android, and iOS.

[MediaPipe Framework](https://developers.google.com/mediapipe/framework) is the
low-level component used to build efficient on-device machine learning
pipelines, similar to the premade MediaPipe Solutions.

Before using MediaPipe Framework, familiarize yourself with the following key
[Framework
concepts](https://developers.google.com/mediapipe/framework/framework_concepts/overview.md):

*   [Packets](https://developers.google.com/mediapipe/framework/framework_concepts/packets.md)
*   [Graphs](https://developers.google.com/mediapipe/framework/framework_concepts/graphs.md)
*   [Calculators](https://developers.google.com/mediapipe/framework/framework_concepts/calculators.md)

## Community

*   [Slack community](https://mediapipe.page.link/joinslack) for MediaPipe
    users.
*   [Discuss](https://groups.google.com/forum/#!forum/mediapipe) - General
    community discussion around MediaPipe.
*   [Awesome MediaPipe](https://mediapipe.page.link/awesome-mediapipe) - A
    curated list of awesome MediaPipe related frameworks, libraries and
    software.

## Contributing

We welcome contributions. Please follow these
[guidelines](https://github.com/google/mediapipe/blob/master/CONTRIBUTING.md).

We use GitHub issues for tracking requests and bugs. Please post questions to
the MediaPipe Stack Overflow with a `mediapipe` tag.

## Resources

### Publications

*   [Bringing artworks to life with AR](https://developers.googleblog.com/2021/07/bringing-artworks-to-life-with-ar.html)
    in Google Developers Blog
*   [Prosthesis control via Mirru App using MediaPipe hand tracking](https://developers.googleblog.com/2021/05/control-your-mirru-prosthesis-with-mediapipe-hand-tracking.html)
    in Google Developers Blog
*   [SignAll SDK: Sign language interface using MediaPipe is now available for
    developers](https://developers.googleblog.com/2021/04/signall-sdk-sign-language-interface-using-mediapipe-now-available.html)
    in Google Developers Blog
*   [MediaPipe Holistic - Simultaneous Face, Hand and Pose Prediction, on
    Device](https://ai.googleblog.com/2020/12/mediapipe-holistic-simultaneous-face.html)
    in Google AI Blog
*   [Background Features in Google Meet, Powered by Web ML](https://ai.googleblog.com/2020/10/background-features-in-google-meet.html)
    in Google AI Blog
*   [MediaPipe 3D Face Transform](https://developers.googleblog.com/2020/09/mediapipe-3d-face-transform.html)
    in Google Developers Blog
*   [Instant Motion Tracking With MediaPipe](https://developers.googleblog.com/2020/08/instant-motion-tracking-with-mediapipe.html)
    in Google Developers Blog
*   [BlazePose - On-device Real-time Body Pose Tracking](https://ai.googleblog.com/2020/08/on-device-real-time-body-pose-tracking.html)
    in Google AI Blog
*   [MediaPipe Iris: Real-time Eye Tracking and Depth Estimation](https://ai.googleblog.com/2020/08/mediapipe-iris-real-time-iris-tracking.html)
    in Google AI Blog
*   [MediaPipe KNIFT: Template-based feature matching](https://developers.googleblog.com/2020/04/mediapipe-knift-template-based-feature-matching.html)
    in Google Developers Blog
*   [Alfred Camera: Smart camera features using MediaPipe](https://developers.googleblog.com/2020/03/alfred-camera-smart-camera-features-using-mediapipe.html)
    in Google Developers Blog
*   [Real-Time 3D Object Detection on Mobile Devices with MediaPipe](https://ai.googleblog.com/2020/03/real-time-3d-object-detection-on-mobile.html)
    in Google AI Blog
*   [AutoFlip: An Open Source Framework for Intelligent Video Reframing](https://ai.googleblog.com/2020/02/autoflip-open-source-framework-for.html)
    in Google AI Blog
*   [MediaPipe on the Web](https://developers.googleblog.com/2020/01/mediapipe-on-web.html)
    in Google Developers Blog
*   [Object Detection and Tracking using MediaPipe](https://developers.googleblog.com/2019/12/object-detection-and-tracking-using-mediapipe.html)
    in Google Developers Blog
*   [On-Device, Real-Time Hand Tracking with MediaPipe](https://ai.googleblog.com/2019/08/on-device-real-time-hand-tracking-with.html)
    in Google AI Blog
*   [MediaPipe: A Framework for Building Perception Pipelines](https://arxiv.org/abs/1906.08172)

### Videos

*   [YouTube Channel](https://www.youtube.com/c/MediaPipe)
