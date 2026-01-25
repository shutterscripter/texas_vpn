import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/controllers/home_controller.dart';
import 'package:vpn_basic_project/helpers/hive_pref.dart';
import 'package:vpn_basic_project/models/vpn.dart';
import 'package:vpn_basic_project/screens/home_screen.dart';
import 'package:vpn_basic_project/services/vpn_engine.dart' show VpnEngine;

class VpnCard extends StatelessWidget {
  final Vpn vpn;
  const VpnCard({super.key, required this.vpn});

  @override
  Widget build(BuildContext context) {
    final HomeController _homeController = Get.find<HomeController>();

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          _homeController.selectedVpn.value = vpn;
          HivePref.vpn = vpn;
          Get.to(() => HomeScreen());
          if (_homeController.vpnState.value == VpnEngine.vpnConnected) {
            VpnEngine.stopVpn();
            Future.delayed(Duration(seconds: 2), () {
              _homeController.connectVPN();
            });
          } else {
            _homeController.connectVPN();
          }
        },
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          leading: Container(
            height: 44,
            width: 72,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey.withValues(alpha: 0.15),
                  Colors.grey.withValues(alpha: 0.05),
                ],
              ),
            ),
            child: vpn.countryShort.isEmpty
                ? Icon(
                    Icons.location_on_rounded,
                    size: 26,
                    color: Colors.white70,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/flags/${vpn.countryShort.toLowerCase()}.png',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.location_on_rounded,
                        size: 26,
                        color: Colors.white70,
                      ),
                    ),
                  ),
          ),
          title: Text(vpn.countryLong),
          subtitle: Row(
            children: [
              Icon(Icons.speed_rounded),
              SizedBox(width: 5),
              Text(_formatBytes(vpn.speed, 1)),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CupertinoIcons.person_2),
              SizedBox(width: 5),
              Text(vpn.numVpnSessions.toString()),
            ],
          ),
        ),
      ),
    );
  }

  String _formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ['Bps', "Kbps", "Mbps", "Gbps", "Tbps"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
