import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_home1/UI/Home/doorSection/door.dart';
import 'package:smart_home1/UI/Home/componentsHomePlan/lights.dart';
import 'package:smart_home1/UI/Home/componentsHomePlan/temperature.dart';
import 'package:smart_home1/UI/Home/temprature/temp.dart';
import 'package:smart_home1/UI/components/fingerPrint/FingerPrint.dart';
import 'package:smart_home1/UI/components/spaces/space.05.dart';
import 'dart:math' as math;

import '../../api/ApiManager.dart';
import '../components/LightSwitches.dart';
import '../components/homeContainers.dart';
import 'SmartDevices/smartDivicesSection.dart';
import 'camera/VideoStreamScreen.dart';
import 'drawer/homeDrawer.dart';

class homeScreen extends StatefulWidget{
  static const routeName='home';

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  bool value=true;
  bool isMasterSwitched= false;
  bool isKitchenSwitched = false;
  bool isLivingRoomSwitched = false;
  bool isPorchSwitched = false;
  bool isGarageSwitched = false;
  bool isDoorOpen = false;

  @override
  void _toggleKitchenSwitch(bool value) {
    setState(() {
      isKitchenSwitched = value;
      _updateMasterSwitch();
    });
  }

  void _toggleLivingRoomSwitch(bool value) {
    setState(() {
      isLivingRoomSwitched = value;
      _updateMasterSwitch();
    });
  }

  void _togglePorchSwitch(bool value) {
    setState(() {
      isPorchSwitched = value;
      _updateMasterSwitch();
    });
  }

  void _toggleGarageSwitch(bool value) {
    setState(() {
      isGarageSwitched = value;
      _updateMasterSwitch();
    });
  }

  void _updateMasterSwitch() {
    setState(() {
      isMasterSwitched =
          isKitchenSwitched || isLivingRoomSwitched || isPorchSwitched || isGarageSwitched;
    });

  }
  Future<void> _handleDoorChange(bool value) async {
    try {
      await APIManager.toggleDoor(value);
      setState(() {
        isDoorOpen = value;
      });
      print('Door is now ${isDoorOpen ? 'Open' : 'Closed'}');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      drawer:homeDrawer(),
      appBar: AppBar(
        title: Text('Home Assistant'),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.notifications_active,)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              homeContainers(
                height: mediaQuery.size.height*.8,
                name: 'Home Plan',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height/1.6,
                            decoration: BoxDecoration(
                                image:DecorationImage(
                                    image: AssetImage('assets/images/home_plan.png',)
                                    ,fit: BoxFit.fill)
                            ),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 35,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    VideoStreamPage(angle :1.5 * math.pi / 2,),
                                    VideoStreamPage(angle: 4.5 * math.pi / 2,),
                                  ],
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10,bottom: 30),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: lights(
                                              isLightOn: isKitchenSwitched,
                                              onLightClicked: _toggleKitchenSwitch,
                                            ),
                                          ),
                                          Flexible(child: temperature()),
                                          Flexible(child: temperature()),
                                          Flexible(
                                            child: lights(
                                                isLightOn: isLivingRoomSwitched,
                                                onLightClicked: _toggleLivingRoomSwitch),
                                          ),
                                          Flexible(child: temperature()),
                                          Flexible(
                                            child: lights(
                                                isLightOn: isPorchSwitched,
                                                onLightClicked: _togglePorchSwitch),
                                          ),


                                        ],

                                      ),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: lights(
                                                isLightOn: isGarageSwitched,
                                                onLightClicked:_toggleGarageSwitch ),
                                          ),
                                          Flexible(child: temperature()),
                                        ],

                                      ),
                                    )
                                ),
                              ],
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              space1(),
              homeContainers(
                height: mediaQuery.size.height*.7,
                name: 'Lights',
                child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '  All Lights',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 27,
                            ),
                          ),
                          Switch(value: isMasterSwitched,
                            onChanged: (value) {
                              setState(() {
                                isMasterSwitched = value;
                                isKitchenSwitched = value;
                                isLivingRoomSwitched = value;
                                isPorchSwitched = value;
                                isGarageSwitched = value;
                              });
                            },
                          ),
                        ],
                      ),
                      LightSwitches(
                        nameSwitch:'Kitchen Lights',
                        isSwitched: isKitchenSwitched,
                        onChange: _toggleKitchenSwitch,
                      ),

                      LightSwitches(
                        nameSwitch:'Living Room Lights',
                        isSwitched: isLivingRoomSwitched,
                        onChange: _toggleLivingRoomSwitch,
                      ),
                      LightSwitches(
                        nameSwitch:'Porch Lights',
                        isSwitched: isPorchSwitched,
                        onChange: _togglePorchSwitch,
                      ),
                      LightSwitches(
                        nameSwitch:'Garage Lights',
                        isSwitched: isGarageSwitched,
                        onChange: _toggleGarageSwitch,
                      ),
                    ]

                ),
              ),
              space1(),
              homeContainers(
                name: 'Smart Devices',
                height: MediaQuery.of(context).size.height/1.2,
                icon: Icons.smart_toy_sharp,
                child: smartDevicesSection(),
              ),
              space1(),
              homeContainers(
                name: 'Door',
                height: MediaQuery.of(context).size.height/2.5,
                icon: Icons.door_back_door,
                child:Door(
                  onChange: _handleDoorChange,
                ) ,

              ),
              space1(),
              homeContainers(
                height: mediaQuery.size.height*.5,
                icon: Icons.thermostat,
                name: 'Temperature',
                child: TemperatureChart(),
              ),
              space1(),
              homeContainers(
                height: mediaQuery.size.height*.35,
                icon: Icons.fingerprint_sharp,
                name: 'Finger print',
                child:Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, FingerPrint.routeName);
                      },
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.center ,
                        children: [
                          Text('finger print'),
                          Icon(Icons.verified_user_outlined)
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}