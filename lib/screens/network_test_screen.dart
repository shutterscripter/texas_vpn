import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forui/forui.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/api/fetch_servers.dart';
import 'package:vpn_basic_project/models/ip_details.dart';
import 'package:vpn_basic_project/models/network_data.dart';
import 'package:vpn_basic_project/widget/network_card.dart';

class NetworkTestScreen extends StatelessWidget {
  const NetworkTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ipData = IPDetails.fromJson({}).obs;
    FetchServers.getIPDetails(ipData: ipData);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Network Test',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  ipData.value = IPDetails.fromJson({});
                  await FetchServers.getIPDetails(ipData: ipData);
                },
                child: Obx(
                  () => ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    children: [
                      NetworkCard(
                        data: NetworkData(
                          title: 'IP Address',
                          subtitle: ipData.value.query.isEmpty
                              ? 'Fetching...'
                              : ipData.value.query,
                          icon: Icon(
                            CupertinoIcons.location_solid,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      NetworkCard(
                        data: NetworkData(
                          title: 'Internet Provider',
                          subtitle: ipData.value.isp.isEmpty
                              ? 'Fetching...'
                              : ipData.value.isp,
                          icon: Icon(
                            Icons.business_rounded,
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ),
                      NetworkCard(
                        data: NetworkData(
                          title: 'Location',
                          subtitle: ipData.value.country.isEmpty
                              ? 'Fetching...'
                              : '${ipData.value.city}, ${ipData.value.regionName}, ${ipData.value.country}',
                          icon: Icon(
                            CupertinoIcons.location,
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ),
                      NetworkCard(
                        data: NetworkData(
                          title: 'Pin Code',
                          subtitle: ipData.value.zip.isEmpty
                              ? 'Fetching...'
                              : ipData.value.zip,
                          icon: Icon(
                            CupertinoIcons.map_pin_ellipse,
                            color: Colors.cyanAccent,
                          ),
                        ),
                      ),
                      NetworkCard(
                        data: NetworkData(
                          title: 'Timezone',
                          subtitle: ipData.value.timezone.isEmpty
                              ? 'Fetching...'
                              : ipData.value.timezone,
                          icon: Icon(
                            CupertinoIcons.time,
                            color: Colors.greenAccent,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1A2E).withValues(alpha: 0.3),
            Color(0xFF0A0A0A),
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  FIcons.chevronLeft,
                  color: Colors.white,
                  size: 24.sp,
                ),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
              ),
              SizedBox(width: 12.w),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  FIcons.activity,
                  color: Colors.blueAccent,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Network Details',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Your connection information',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
