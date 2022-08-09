import 'package:permission_handler/permission_handler.dart';

Future<bool> askPermissions() async {
  PermissionStatus permissionStatus = await _getContactPermission();
  if (permissionStatus == PermissionStatus.granted) {
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
