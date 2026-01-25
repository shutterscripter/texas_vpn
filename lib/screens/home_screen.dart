import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forui/forui.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/constants/image_constants.dart';
import 'package:vpn_basic_project/controllers/home_controller.dart';
import 'package:vpn_basic_project/models/vpn_status.dart';
import 'package:vpn_basic_project/screens/location_screen.dart';
import 'package:vpn_basic_project/screens/network_test_screen.dart';
import 'package:vpn_basic_project/services/vpn_engine.dart';
import 'package:vpn_basic_project/widget/count_down_timer.dart';

class HomeScreen extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      _homeController.vpnState.value = event;
    });
    Timer.periodic(Duration(seconds: 1), (timer) {
      _homeController.scaleValue.value = _homeController.scaleValue.value == 1.0
          ? 0.9
          : 1.0;
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.to(() => NetworkTestScreen());
                      },
                      icon: Icon(FIcons.badgeInfo),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                _vpnButton(),
                SizedBox(height: 10.h),
                Obx(
                  () => Text(
                    _homeController.selectedVpn.value!.countryLong.isEmpty
                        ? 'Auto VPN'
                        : _homeController.selectedVpn.value!.countryLong,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Obx(
                  () => CountDownTimer(
                    StartTimer:
                        _homeController.vpnState.value ==
                        VpnEngine.vpnConnected,
                  ),
                ),
                SizedBox(height: 10.h),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              _homeController.vpnState.value ==
                                  VpnEngine.vpnConnected
                              ? Colors.greenAccent
                              : _homeController.vpnState.value ==
                                    VpnEngine.vpnDisconnected
                              ? Colors.redAccent
                              : Colors.grey,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        _homeController.vpnState.value ==
                                VpnEngine.vpnDisconnected
                            ? 'Disconnected'
                            : _homeController.vpnState.value ==
                                  VpnEngine.vpnConnected
                            ? 'Connected'
                            : 'Connecting...',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                _buildInfoCards(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          onTap: () {
            Get.to(() => LocationScreen());
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Location',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(FIcons.globe, size: 18.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCards() {
    return StreamBuilder<VpnStatus?>(
      initialData: VpnStatus(),
      stream: VpnEngine.vpnStatusSnapshot(),
      builder: (context, snapshot) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    icon: FIcons.gauge,
                    iconColor: Colors.orangeAccent,
                    title: 'Ping',
                    value:
                        _homeController.selectedVpn.value!.ping.isEmpty ||
                            _homeController.selectedVpn.value!.ping == '0'
                        ? '0 ms'
                        : '${_homeController.selectedVpn.value!.ping} ms',
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: _buildInfoCard(
                    icon: FIcons.globe,
                    iconColor: Colors.pinkAccent,
                    title: 'Server',
                    value:
                        _homeController.selectedVpn.value!.countryLong.isEmpty
                        ? 'Select'
                        : _homeController.selectedVpn.value!.countryLong,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    icon: FIcons.arrowBigDownDash,
                    iconColor: Colors.greenAccent,
                    title: 'Download',
                    value: snapshot.data?.byteIn ?? '0 Mbps',
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: _buildInfoCard(
                    icon: FIcons.arrowBigUpDash,
                    iconColor: Colors.yellowAccent,
                    title: 'Upload',
                    value: snapshot.data?.byteOut ?? '0 Mbps',
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _vpnButton() {
    return Obx(
      () => InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          await _homeController.connectVPN();
        },
        child: Container(
          width: 250.w,
          height: 250.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                _homeController.getButtonColor.withValues(alpha: 0.3),
                _homeController.getButtonColor.withValues(alpha: 0.1),
              ],
              stops: [0.4, 1],
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  _homeController.getButtonColor.withValues(alpha: 0.4),
                  _homeController.getButtonColor.withValues(alpha: 0.2),
                ],
              ),
            ),
            child: Container(
              margin: EdgeInsets.all(10.w),
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background SVG pattern
                    SvgPicture.asset(
                      ImageConstants.circleDesign,
                      width: 150.w,
                      colorFilter: ColorFilter.mode(
                        _homeController.getButtonColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    // Power icon on top
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(Get.context!).scaffoldBackgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: _homeController.getButtonColor.withValues(
                              alpha: 0.5,
                            ),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.power_settings_new_rounded,
                        size: 30.sp,
                        color: _homeController.getButtonColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
