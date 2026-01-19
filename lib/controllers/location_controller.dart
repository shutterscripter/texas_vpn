import 'package:get/get.dart';
import 'package:vpn_basic_project/api/fetch_servers.dart';
import 'package:vpn_basic_project/helpers/hive_pref.dart';
import 'package:vpn_basic_project/models/vpn.dart';

class LocationController extends GetxController {
  List<Vpn> vpnList = HivePref.vpnList;
  final RxBool isLoading = false.obs;

  Future<void> getVPNServers() async {
    isLoading.value = true;
    vpnList.clear();
    vpnList = await FetchServers.getVPNServers();
    isLoading.value = false;
  }
}
