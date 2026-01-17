import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/api/fetch_servers.dart';
import 'package:vpn_basic_project/controllers/location_controller.dart'
    show LocationController;
import 'package:vpn_basic_project/widget/vpn_card.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final LocationController _locationController = Get.put(LocationController());

  @override
  void initState() {
    _locationController.getVPNServers();
    super.initState();
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ));
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
