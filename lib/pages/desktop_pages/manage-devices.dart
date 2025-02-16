import 'package:Aanya/database/user_management.dart';
import 'package:Aanya/modules/device_request_reciever.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:Aanya/common_vars.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Device {
  String name;
  final String ipAddress;
  final String id;
  final String lastOnline;
  bool? isExpanded;

  Device({
    required this.name,
    required this.id,
    required this.ipAddress,
    required this.lastOnline,
    this.isExpanded = false,
  });
}

bool dataFetched = false;
List<Device> deviceList = [];

class DesktopManageDevices extends StatefulWidget {
  @override
  State<DesktopManageDevices> createState() => _DesktopManageDevicesState();
}

class _DesktopManageDevicesState extends State<DesktopManageDevices> {
  bool isExpanded = false;
  bool saved = false;
  var userManagement = Get.find<UserManagement>();

  Future<void> buildExpansionPanelList() async {
    print("Building List");
    final devices = await userManagement.devices;
    for (var device in devices) {
      print(device);
      Device deviceobj = Device(
          id: device['device_id'],
          name: device["device_name"],
          ipAddress: device['device_ip'],
          lastOnline: device['last_active']);
      deviceList.add(deviceobj);
    }
    setState(() {});
  }

  void toggleExpansion(int index) {
    setState(() {
      deviceList[index].isExpanded = !(deviceList[index].isExpanded ?? false);
    });
  }

  @override
  void initState() {
    super.initState();
    // Call the fetchData method when the screen initializes
    dataFetched
        ? null
        : buildExpansionPanelList().then((data) {
            dataFetched = true;
          });
  }

  @override
  Widget build(BuildContext context) {
    reciver_context = context;
    print("ON manage devices");
    final commonVars = Provider.of<CommonVariables>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        commonVars.updatePageName('settings');
      },
      child: Expanded(
        child: Container(
          child: Stack(
            children: [
              Positioned(
                // ellipse purple Top Right(15:24)
                left: 250 * fem,
                top: 86 * fem,
                child: Align(
                  child: SizedBox(
                    width: 195 * fem,
                    height: 195 * fem,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(203.5 * fem),
                        gradient: RadialGradient(
                          center: Alignment(0, -0),
                          radius: 0.4,
                          colors: <Color>[
                            Color.fromARGB(255, 113, 59, 218),
                            Color.fromARGB(0, 83, 82, 159)
                          ],
                          stops: <double>[0, 1],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                // ellipse purple Middle(15:24)
                left: -87 * fem,
                top: 222 * fem,
                child: Align(
                  child: SizedBox(
                    width: 195 * fem,
                    height: 195 * fem,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(203.5 * fem),
                        gradient: RadialGradient(
                          center: Alignment(0, -0),
                          radius: 0.4,
                          colors: <Color>[
                            Color.fromARGB(255, 113, 59, 218),
                            Color.fromRGBO(113, 59, 218, 0)
                          ],
                          stops: <double>[0, 1],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 100 * fem,
                    left: 100 * fem,
                    right: 100 * fem,
                    bottom: 200 * fem),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      color: const Color.fromARGB(110, 158, 158, 158)
                          .withOpacity(0.1), // Adjust opacity as needed
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20 * fem),
                            child: Text(
                              'Manage Devices',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            height: 350 * fem,
                            padding: EdgeInsets.all(20 * fem),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  dataFetched
                                      ? ExpansionPanelList(
                                          expansionCallback:
                                              (int index, bool isExpanded) {
                                            toggleExpansion(index);
                                          },
                                          expandIconColor: Colors.white60,
                                          animationDuration:
                                              Duration(milliseconds: 300),
                                          dividerColor:
                                              Color.fromRGBO(44, 52, 83, 0.669),
                                          elevation: 1,
                                          expandedHeaderPadding:
                                              EdgeInsets.all(8),
                                          children: deviceList
                                              .map<ExpansionPanel>(
                                                  (Device device) {
                                            return ExpansionPanel(
                                                backgroundColor: Color.fromARGB(
                                                    106, 44, 52, 83),
                                                headerBuilder:
                                                    (BuildContext context,
                                                        bool isExpanded) {
                                                  return Container(
                                                    child: ListTile(
                                                      title: Row(
                                                        children: [
                                                          Text(
                                                            device.name,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                        ],
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          device.isExpanded =
                                                              !isExpanded;
                                                        });
                                                      },
                                                    ),
                                                  );
                                                },
                                                body: Container(
                                                  color: Color.fromARGB(
                                                      64, 44, 52, 83),
                                                  child: ListTile(
                                                    title: Text(
                                                      "Device IP",
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 173, 173, 173),
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      device.ipAddress,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    trailing: Icon(
                                                      Icons.delete,
                                                      color: Color.fromARGB(
                                                          199, 255, 43, 50),
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Confirm Removal'),
                                                              content: Text(
                                                                  'Are you sure you want to delete this device?'),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    // Dismiss the dialog and return false
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            false);
                                                                  },
                                                                  child: Text(
                                                                      'Cancel'),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    deviceList.removeWhere((Device
                                                                            currentdevice) =>
                                                                        device ==
                                                                        currentdevice);
                                                                    setState(
                                                                        () {
                                                                      saved =
                                                                          false;
                                                                    });
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            true);
                                                                  },
                                                                  child: Text(
                                                                      'Delete'),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      });
                                                    },
                                                  ),
                                                ),
                                                isExpanded:
                                                    device.isExpanded ?? false);
                                          }).toList(),
                                        )
                                      : CircularProgressIndicator(),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 20 * fem),
                              child: ElevatedButton(
                                onPressed: () async {
                                  print("Saving Following Changes");
                                  List<dynamic> updatedDevices = [];
                                  for (var device in deviceList) {
                                    final Map<String, dynamic> newDevice = {
                                      "device_ip": device.ipAddress,
                                      "device_id": device.id,
                                      "device_name": device.name,
                                      "last_active": device.lastOnline,
                                    };
                                    updatedDevices.add(newDevice);
                                  }
                                  await userManagement
                                      .updateDevices(updatedDevices);
                                  setState(() {
                                    saved = true;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(30 * fem),
                                  backgroundColor:
                                      Color.fromARGB(255, 70, 65, 141),
                                ),
                                child: Text(
                                  saved ? "Saved" : "Save Changes",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
