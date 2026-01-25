import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
}
