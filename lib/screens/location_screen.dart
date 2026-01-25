import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forui/forui.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/controllers/location_controller.dart';
import 'package:vpn_basic_project/widget/vpn_card.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({super.key});
  final LocationController _locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    if (_locationController.vpnList.isEmpty) {
      _locationController.getVPNServers();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(FIcons.chevronLeft),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Select Location',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _locationController.getVPNServers();
        },
        child: Obx(
          () => _locationController.vpnList.isEmpty &&
                  !_locationController.isLoading.value
              ? _buildEmptyState()
              : _buildVpnList(),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FIcons.globe,
            size: 64.sp,
            color: Colors.grey.withValues(alpha: 0.3),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Servers Available',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Pull down to refresh',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: () => _locationController.getVPNServers(),
            icon: Icon(FIcons.refreshCw, size: 18.sp),
            label: Text('Retry'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVpnList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Server count header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Obx(
            () => Row(
              children: [
                Icon(
                  FIcons.server,
                  size: 16.sp,
                  color: Colors.grey,
                ),
                SizedBox(width: 8.w),
                Text(
                  '${_locationController.vpnList.length} servers available',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),

        // VPN List
        Expanded(
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemCount: _locationController.vpnList.length,
            padding: EdgeInsets.only(
              top: 8.h,
              bottom: 20.h,
              right: 20.w,
              left: 20.w,
            ),
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              return VpnCard(vpn: _locationController.vpnList[index]);
            },
          ),
        ),
      ],
    );
  }
}
