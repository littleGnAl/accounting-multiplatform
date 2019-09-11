# accounting-multiplatform

[![Build Status](https://api.cirrus-ci.com/github/littleGnAl/accounting-multiplatform.svg)](https://cirrus-ci.com/github/littleGnAl/accounting-multiplatform)

Multiplatform version of [Accounting](https://github.com/littleGnAl/Accounting), using both [Kotlin Multiplatform](https://kotlinlang.org/docs/reference/multiplatform.html) and [Flutter](https://flutter.dev/).

|    Android                             | iOS                            |
:---------------------------------------:|:-------------------------------:
![android](https://raw.githubusercontent.com/littleGnAl/screenshot/master/kmpp-flutter/kmpp_flutter_android.gif)   |   ![ios](https://raw.githubusercontent.com/littleGnAl/screenshot/master/kmpp-flutter/kmpp_flutter_ios.gif)

# Build
* In order for kotlin multiplatform to generate iOS frameworks, you should enter the `android` folder and run `./gradlew :common:build` on the first time.
* The flutter code mainly use [built_value](https://github.com/google/built_value.dart) for immutable object model, so make sure you have run `flutter packages pub run build_runner build` when you build the project.
* Run `flutter run`.
* Have fun.

# License
    Copyright (C) 2019 littlegnal

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
