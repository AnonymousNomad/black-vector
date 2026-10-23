# Android Debug Export Receipt

- Source commit: `d128ce37f9c9e97e411d07f869863cc14114aaec`
- Export preset: `Android`
- Package: `com.blackvector.development`
- Version: `0.1.0` (`versionCode` 1)
- ABI: `arm64-v8a`
- Renderer: Godot GL Compatibility
- APK: `/tmp/black-vector-artifacts/black-vector-debug.apk`
- APK size: `29,174,655` bytes
- SHA-256: `030a80945914a1d6e5743d8cbbee486129c68cf2bafb223b151beffcf6068258`
- Signer: Godot debug signer, `CN=Godot, OU=Godot Engine, O=Stichting Godot, C=NL`
- Signer certificate SHA-256: `945dc20ae5abf27374519ef62754183ef2bdef8fa71649ca1bcceabccb2b5ca8`
- Verification: `apksigner` 0.9 confirms APK Signature Scheme v2 and v3.
- Export command: Godot 4.7.2 stable, `--headless --audio-driver Dummy --path game --export-debug Android /tmp/black-vector-artifacts/black-vector-debug.apk`.
- Toolchain: Android SDK platform 36, build-tools 36.1.0, platform-tools 37.0.1, OpenJDK 21.0.12.1 runtime at `/usr/lib/jvm/java-21-openjdk-amd64`.
- Result: debug candidate exported and signature verified. The export log contains the cloud image's read-only `/home/agent/.android` adb initialization warning; it did not prevent export.
- Device status: **`PHYSICAL_ANDROID_NOT_TESTED`**. No device or emulator acceptance is claimed.
