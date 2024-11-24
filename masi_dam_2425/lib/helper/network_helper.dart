import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:masi_dam_2425/network/bloc/network_bloc.dart';

class NetworkHelper {

  static void observeNetwork() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result.first == ConnectivityResult.none) {
        NetworkBloc().add(NetworkNotify());
      } else {
        NetworkBloc().add(NetworkNotify(isConnected: true));
      }
    });
  }
}