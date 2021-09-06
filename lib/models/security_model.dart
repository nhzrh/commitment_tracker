class SecurityModel {
  bool isJailBroken;
  bool isRealDevice;
  bool isOnExternalStorage;
  bool isSafeDevice;

  SecurityModel({
    this.isJailBroken,
    this.isRealDevice,
    this.isOnExternalStorage,
    this.isSafeDevice,
  });

  @override
  String toString() {
    return "SecurityModel({isJailBroken=$isJailBroken, isRealDevice=$isRealDevice, isOnExternalStorage=$isOnExternalStorage, isSafeDevice=$isSafeDevice })";
  }
}
