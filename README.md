## 使用步骤

1. 下载一登SDK [iOS SDK下载](https://github.com/SuperID/superid-ios-sdk/archive/master.zip)
2. 复制文件夹 `SuperID-SDK-iOS` 至 Sample 工程文档目录下。
3. 开始调试运行


## 本分支在 `Xcode 6.4` 编译通过

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



