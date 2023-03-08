import 'package:permission_handler/permission_handler.dart';

Future<bool> askPermissions() async {
  PermissionStatus permissionNotification = await _getNotificationPermission();
  PermissionStatus permissionStatus = await _getContactPermission();
  PermissionStatus permissionCameraStatus = await _getCameraPermission();
  PermissionStatus permissionAccessNotification =
      await _getAccessNotificationPermission();
  if (permissionStatus == PermissionStatus.granted &&
      permissionCameraStatus == PermissionStatus.granted &&
      permissionNotification == PermissionStatus.granted &&
      permissionAccessNotification == PermissionStatus.granted) {
    return true;
  } else {
    return false;
  }
}

Future<bool> wasAllowedContacts() async {
  return await Permission.contacts.isGranted;
}

Future<PermissionStatus> _getContactPermission() async {
  PermissionStatus permission = await Permission.contacts.status;
  if (permission != PermissionStatus.granted &&
      permission != PermissionStatus.permanentlyDenied) {
    PermissionStatus permissionStatus = await Permission.contacts.request();
    return permissionStatus;
  } else {
    return permission;
  }
}

Future<PermissionStatus> _getCameraPermission() async {
  PermissionStatus permission = await Permission.camera.status;
  if (permission != PermissionStatus.granted &&
      permission != PermissionStatus.permanentlyDenied) {
    PermissionStatus permissionStatus = await Permission.camera.request();
    return permissionStatus;
  } else {
    return permission;
  }
}

Future<PermissionStatus> _getNotificationPermission() async {
  PermissionStatus permission = await Permission.notification.status;
  if (permission != PermissionStatus.granted &&
      permission != PermissionStatus.permanentlyDenied) {
    PermissionStatus permissionStatus = await Permission.notification.request();
    return permissionStatus;
  } else {
    return permission;
  }
}

Future<PermissionStatus> _getAccessNotificationPermission() async {
  PermissionStatus permission =
      await Permission.accessNotificationPolicy.status;
  if (permission != PermissionStatus.granted &&
      permission != PermissionStatus.permanentlyDenied) {
    PermissionStatus permissionStatus =
        await Permission.accessNotificationPolicy.request();
    return permissionStatus;
  } else {
    return permission;
  }
}
