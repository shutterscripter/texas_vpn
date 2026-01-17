import 'package:get/get.dart';
import 'package:vpn_basic_project/services/vpn_engine.dart';

class HomeController extends GetxController {
  RxBool startTimer = false.obs;
  final vpnState = VpnEngine.vpnDisconnected.obs;

  Future<void> initializeData() async {
    
  }
}
