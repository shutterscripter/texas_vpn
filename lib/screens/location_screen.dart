import 'package:flutter/material.dart';
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
    return RefreshIndicator(
      onRefresh: () async {
        _locationController.getVPNServers();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(
          () => _locationController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _locationController.vpnList.isEmpty
                  ? Center(
                      child: Text('No Data'),
                    )
                  : _vpnData(),
        ),
      ),
    );
  }

  _vpnData() => ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: _locationController.vpnList.length,
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10,
        right: 20,
        left: 20,
      ),
      itemBuilder: (context, index) {
        return VpnCard(vpn: _locationController.vpnList[index]);
      });
}
