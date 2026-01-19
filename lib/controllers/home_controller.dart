import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/helpers/custom_snackbars.dart';
import 'package:vpn_basic_project/helpers/hive_pref.dart';
import 'package:vpn_basic_project/models/vpn.dart';
import 'package:vpn_basic_project/models/vpn_config.dart';
import 'package:vpn_basic_project/services/vpn_engine.dart';

class HomeController extends GetxController {
  final Rx<Vpn?> selectedVpn = HivePref.vpn.obs;

  final vpnState = VpnEngine.vpnDisconnected.obs;

  Future<void> connectVPN() async {
    ///Stop right here if user not select a vpn
    if (selectedVpn.value!.openVPNConfigDataBase64.isEmpty) {
      CustomSnackbars.showInfoSnackBar(msg: 'Please Select a Location!');
      return;
    }

    if (vpnState.value == VpnEngine.vpnDisconnected) {
      final data =
          Base64Decoder().convert(selectedVpn.value!.openVPNConfigDataBase64);
      final config = Utf8Decoder().convert(data);

      final vpnConfig = VpnConfig(
          country: selectedVpn.value!.countryLong,
          username: 'vpn',
          password: 'vpn',
          config: config);

      ///Start if stage is disconnected
      VpnEngine.startVpn(vpnConfig);
    } else {
      ///Stop if stage is "not" disconnected
      VpnEngine.stopVpn();
    }
  }

  Color get getButtonColor {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return Colors.red;
      case VpnEngine.vpnConnected:
        return Colors.green;
      case VpnEngine.vpnConnecting:
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }
}
