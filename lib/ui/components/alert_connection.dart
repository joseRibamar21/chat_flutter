import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class CustomAlertConnection extends StatefulWidget {
  const CustomAlertConnection({Key? key}) : super(key: key);

  @override
  State<CustomAlertConnection> createState() => _CustomAlertConnectionState();
}

class _CustomAlertConnectionState extends State<CustomAlertConnection> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  bool _open = false;

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;
    switch (_connectionStatus) {
      case ConnectivityResult.mobile:
        _open = false;
        break;
      case ConnectivityResult.ethernet:
        _open = false;
        break;
      case ConnectivityResult.wifi:
        _open = false;
        break;
      default:
        _open = true;
    }
    setState(() {});
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      return;
    }
    return _updateConnectionStatus(result);
  }

  @override
  void initState() {
    initConnectivity();
    _connectivity.onConnectivityChanged.listen((event) {
      _updateConnectionStatus(event);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: Theme.of(context).errorColor,
      height: !_open ? 0 : 60,
      width: double.maxFinite,
      child: Center(
        child: Text("Não conectado com a internet! ",
            style: Theme.of(context).textTheme.titleSmall),
      ),
    );
  }
}
