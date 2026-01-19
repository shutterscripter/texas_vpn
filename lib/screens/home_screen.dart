import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/controllers/home_controller.dart';
import 'package:vpn_basic_project/helpers/custom_snackbars.dart';
import 'package:vpn_basic_project/helpers/hive_pref.dart';
import 'package:vpn_basic_project/models/vpn_status.dart';
import 'package:vpn_basic_project/screens/home_screen_cards.dart';
import 'package:vpn_basic_project/screens/location_screen.dart';
import 'package:vpn_basic_project/screens/network_test_screen.dart';
import 'package:vpn_basic_project/widget/count_down_timer.dart';
import '../models/vpn_config.dart';
import '../services/vpn_engine.dart';

class HomeScreen extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      _homeController.vpnState.value = event;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Nexas VPN'),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeThemeMode(
                  HivePref.isDarkMode ? ThemeMode.light : ThemeMode.dark);

              HivePref.isDarkMode = !HivePref.isDarkMode;
            },
            icon: Icon(Icons.dark_mode),
          ),
          IconButton(
            onPressed: () {
              Get.to(() => NetworkTestScreen());
            },
            icon: Icon(Icons.info),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Connect VPN Button
              _vpnButton(),

              /// CountDownTimer
              Obx(() => CountDownTimer(
                  StartTimer: _homeController.vpnState.value ==
                      VpnEngine.vpnConnected)),

              /// Stat Cards
              _statCards(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => LocationScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _vpnButton() {
    return Obx(
      () => Column(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              await _homeController.connectVPN();

            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: CircleAvatar(
                backgroundColor:
                    _homeController.getButtonColor.withValues(alpha: 0.2),
                radius: 110.sp,
                child: CircleAvatar(
                  backgroundColor:
                      _homeController.getButtonColor.withValues(alpha: 0.4),
                  radius: 90.sp,
                  child: CircleAvatar(
                    radius: 70.sp,
                    backgroundColor: _homeController.getButtonColor,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.power,
                            size: 45.sp,
                          ),
                          Text(
                            'Tap to Connect VPN',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              _homeController.vpnState.value == VpnEngine.vpnDisconnected
                  ? 'Not Connected'
                  : _homeController.vpnState.replaceAll('_', ' ').toUpperCase(),
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _statCards() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              HomeScreenCard(
                title: _homeController.selectedVpn.value!.countryLong == ''
                    ? 'Country'
                    : _homeController.selectedVpn.value!.countryLong.toString(),
                subtitle: 'Free',
                icon: _homeController.selectedVpn.value == null ||
                        _homeController.selectedVpn.value!.countryShort.isEmpty
                    ? Icon(Icons.vpn_lock_rounded, size: 24)
                    : CircleAvatar(
                        backgroundColor: Colors.white.withValues(alpha: 0.03),
                        backgroundImage: _homeController
                                .selectedVpn.value!.countryLong.isEmpty
                            ? null
                            : AssetImage(
                                'assets/flags/${_homeController.selectedVpn.value!.countryShort.toLowerCase()}.png',
                              ),
                      ),
              ),
              HomeScreenCard(
                title: _homeController.selectedVpn.value!.ping.isEmpty ||
                        _homeController.selectedVpn.value!.ping == '0'
                    ? '0 ms'
                    : '${_homeController.selectedVpn.value!.ping} ms',
                subtitle: 'Ping',
                icon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(Icons.vpn_key),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        StreamBuilder<VpnStatus?>(
          initialData: VpnStatus(),
          stream: VpnEngine.vpnStatusSnapshot(),
          builder: (context, snapshot) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              HomeScreenCard(
                title: snapshot.data?.byteIn ?? '0 B',
                subtitle: 'Download',
                icon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(Icons.download),
                ),
              ),
              HomeScreenCard(
                title: snapshot.data?.byteOut ?? '0 B',
                subtitle: 'Upload',
                icon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Icon(Icons.upload),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
