// lib/utils/connectivity_service.dart
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  // Stream to broadcast connectivity status
  StreamController<bool> connectionStatusController =
      StreamController<bool>.broadcast();

  ConnectivityService() {
    // Initialize
    checkConnectivity();

    // Listen for connectivity changes
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus as void
        Function(List<ConnectivityResult> event)?);
  }

  // Check current connectivity
  Future<bool> checkConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    bool isConnected =
        _connectivityResultToBool(connectivityResult as ConnectivityResult);
    connectionStatusController.add(isConnected);
    return isConnected;
  }

  // Update connection status based on connectivity result
  void _updateConnectionStatus(ConnectivityResult result) {
    connectionStatusController.add(_connectivityResultToBool(result));
  }

  // Convert connectivity result to a boolean
  bool _connectivityResultToBool(ConnectivityResult result) {
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet;
  }

  // Dispose of the stream controller
  void dispose() {
    connectionStatusController.close();
  }
}
