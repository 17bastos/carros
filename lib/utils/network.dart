import 'package:connectivity/connectivity.dart';

Future<bool> isNetworkon() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  } else {
    return true;
  }
}