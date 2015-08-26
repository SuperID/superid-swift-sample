## 使用步骤

1. 下载一登SDK [iOS SDK下载](https://github.com/SuperID/superid-ios-sdk/archive/master.zip)
2. 复制文件夹 `SuperID-SDK-iOS` 至 Sample 工程文档目录下。
3. 开始调试运行


## 关于 Swift2 与 Xcode7

如果你使用 Xcode7 和 Swift2.0 ，请查看 `Xcode7` 分支 https://github.com/SuperID/superid-swift-sample/tree/Xcode7

**已经更新至 Xcode7-beta6**

## 使用工程编译问题

在工程的```Bridging_Header```头文件中添加

```objective-c
#import "SuperID.h"
#import "SuperIDDelegate.h"
#import "SIDFaceFeatureViewController.h"
```

![](ScreenShot/Header.JPG)

确保已经引入下列框架，否则可能会出错：

- `libc++.dylib`
- `AVFoundation.framework`
- `CoreMedia.framework`
- `CoreTelephony.framework`

![](ScreenShot/Frameworks.JPG)

同时确保在 `Build Setting` 的 `Other Linker Flags` 中添加以下代码：

```
-lstdc++
-Objc
-force_load
$(PROJECT_DIR)/SuperID_SDK/libSuperIDSDK.a
```

![](ScreenShot/LinkFlag.JPG)



