# Shizuku-API

Shizuku API is the API provided by [Shizuku](https://github.com/RikkaApps/Shizuku) and [Sui](https://github.com/RikkaApps/Sui). With Shizuku API, you can call your Java/JNI code with root/shell (ADB) identity.

## Requirements

To use Shizuku APIs, you need to guide the user to install Shizuku or Sui first. Both of them require Android 6.0+.

### Shizuku

Shizuku is a standard Android application. You can guide the users to download Shizuku from https://shizuku.rikka.app/download/. Shizuku works for both rooted and non-rooted devices.

On non-rooted devices, Shizuku needs to be manually restarted with adb every time on boot. Before Android 11, a computer is required to run adb. Android 11 and above have built-in wireless debugging support, and users can start Shizuku directly on the device.

### Sui

Sui is a [Magisk](https://github.com/topjohnwu/Magisk) module. Magisk requires an unlocked bootloader.

No additional setup is required except for the installation. You can guide the rooted users (searching `su` in `PATH` is enough) to download Sui from Magisk or https://github.com/RikkaApps/Sui.

## Demo

A demo project is provided. See [demo](https://github.com/RikkaApps/Shizuku-API/tree/master/demo) for more.

## Guide

I'll say the difficult words first, using Shizuku APIs is similar to framework or system app development, some experience in developing common applications may not be enough. You have to get used to digging into Android source code to find out how things work, [cs.android.com](https://cs.android.com) and AndroidXref sites will be your best friend.

> **Personal note:** I found [cs.android.com](https://cs.android.com) especially useful when tracing how system services binder calls. searching by class than method name for broader context.

### Add dependency

![Maven Central](https://img.shields.io/maven-central/v/dev.rikka.shizuku/api)

```groovy
def shizuku_version = (the version above)
implementation "dev.rikka.shizuku:api:$shizuku_version"

// Add this line if you want to support Shizuku
implementation "dev.rikka.shizuku:provider:$shizuku_version"
```



The first step is to acquire the Binder from Shizuku or Sui.

`Shizuku` class provides listeners, `Shizuku#addBinderReceivedListener()` and `Shizuku.addBinderDeadListener()`, that allows you to track the life of the binderShizuku` class when the binder is alive or you will get an `IllegalStateException`.

The steps to get a Binder from Sui and Shizuku are different.

#### Sui

Call `Sui.init(packageName)` before using `Shizuku` class. This method only needs to be called once. If this method returns true, means Sui is installed and available.

For multi-process applications, call this method in every process that needs to use Shizuku API.

Note, request the binder for Sui only requires two times of binder IPC, this is significantly cheaper than initialize Shizuku which uses `ContentProvider`. `Sui.init(packageName)` can be used in main thread, you don't need to worry about performance.

#### Shizuku

Add `ShizukuProvider` to `AndroidManifest.xml`.

```xml
<provider
    android:name="rikka.shizuku.Shizuku
```
