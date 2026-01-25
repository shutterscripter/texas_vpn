import 'package:get/get.dart';
import 'package:vpn_basic_project/api/fetch_servers.dart';
import 'package:vpn_basic_project/helpers/hive_pref.dart';
import 'package:vpn_basic_project/models/vpn.dart';

class LocationController extends GetxController {
  final RxList<Vpn> vpnList = <Vpn>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    vpnList.value = HivePref.vpnList;
  }

  Future<void> getVPNServers() async {
    isLoading.value = true;
    final servers = await FetchServers.getVPNServers();
    vpnList.value = servers;
    isLoading.value = false;
  }
}
