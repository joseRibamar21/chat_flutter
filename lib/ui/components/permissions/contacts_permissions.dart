import 'package:permission_handler/permission_handler.dart';

Future<bool> askPermissions() async {
  PermissionStatus permissionStatus = await _getContactPermission();
  PermissionStatus permissionCameraStatus = await _getCameraPermission();
  if (permissionStatus == PermissionStatus.granted &&
      permissionCameraStatus == PermissionStatus.granted) {
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
