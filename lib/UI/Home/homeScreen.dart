import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home1/UI/Home/componentsHomePlan/lights.dart';
import 'package:smart_home1/UI/Home/componentsHomePlan/temperature.dart';
import 'package:smart_home1/UI/components/spaces/space.05.dart';

import '../components/LightSwitches.dart';
import '../components/homeContainers.dart';
import 'componentsHomePlan/door.dart';
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
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final planHeight=mediaQuery.size.height*.6;
    final planWidth=mediaQuery.size.width;
    return Scaffold(
      drawer:homeDrawer(),
      appBar: AppBar(
        title: Text('Home Assistant'),
        actions: [
          IconButton(
              onPressed: (){
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(100, 100, 0, 0),
                  items: [
                    PopupMenuItem<String>(
                      value: 'Option 1',
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(width:10,),
                          Text('Search')
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'Option 2',
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          SizedBox(width: 10,),
                          Text('Edit dashboard')
                        ],
                      ),
                    ),
                  ],
                );
              },
              icon: Icon(Icons.more_vert)
          )
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
                  padding: const EdgeInsets.only(top: 10),
                  child: Stack(
                    children: [
                      Image.asset('assets/images/home_plan.png',
                        height:mediaQuery.size.height*.6,
                        width: mediaQuery.size.width*.5 ,
                      ),
                      Positioned(
                        top: planHeight*.2,
                          left: mediaQuery.size.width*.06,
                          child: lights(onLightClicked: _toggleKitchenSwitch),
                      ),
                      Positioned(
                        top: mediaQuery.size.height*.15,
                          right:mediaQuery.size.width*.35,
                          child: lights(onLightClicked:_toggleLivingRoomSwitch ,),
                      ),
                      Positioned(
                        left: mediaQuery.size.width*.07,
                        bottom: mediaQuery.size.height*.07,
                          child: lights(onLightClicked: _togglePorchSwitch,),
                      ),
                      Positioned(
                        bottom: mediaQuery.size.height*.15,
                          right:mediaQuery.size.width*.1,
                          child: lights(onLightClicked:_toggleGarageSwitch ,),
                      ),
                      Positioned(
                        top: mediaQuery.size.height*.125,
                        left: mediaQuery.size.width*.001,
                        child: temperature(),
                      ),
                      Positioned(
                        top: mediaQuery.size.height*.15,
                        right:mediaQuery.size.width*.25,
                        child: temperature(),
                      ),
                      Positioned(
                        bottom: mediaQuery.size.height*.07,
                        left: mediaQuery.size.width*.01,
                        child: temperature(),
                      ),
                      Positioned(
                        bottom: mediaQuery.size.height*.15,
                        right: mediaQuery.size.width*.04,
                        child: temperature(),
                      ),
                      Positioned(
                        top: mediaQuery.size.height*.04,
                        left: mediaQuery.size.width*.04,
                        child: door(),
                      ),
                      Positioned(
                        bottom: mediaQuery.size.height*.04,
                        left:mediaQuery.size.width*.2,
                        child: door(),
                      ),
                      Positioned(
                        bottom: mediaQuery.size.height*.16,
                        right:mediaQuery.size.width*.28,
                        child: door(),
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
                              //fontWeight: FontWeight.bold,
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
                        onChange: _toggleKitchenSwitch,),

                      LightSwitches(
                        nameSwitch:'Living Room Lights',
                        isSwitched: isLivingRoomSwitched,
                        onChange: _toggleLivingRoomSwitch,),
                      LightSwitches(
                        nameSwitch:'Porch Lights',
                        isSwitched: isPorchSwitched,
                        onChange: _togglePorchSwitch,),
                      LightSwitches(
                        nameSwitch:'Garage Lights',
                        isSwitched: isGarageSwitched,
                        onChange: _toggleGarageSwitch,),
                    ]

                ),
              ),
              space1(),
              homeContainers(
                  height: mediaQuery.size.height*.5,
                icon: Icons.thermostat,
                  name: 'Temperature',
              ),
              space1(),
              homeContainers(
                  height: mediaQuery.size.height*.35,
                  name: 'Security',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: (){},
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.center ,
                          children: [
                            Text('DISARMEDS'),
                            Icon(Icons.verified_user_outlined)
                          ],
                        )),
                    space1(),
                    Row(
                      mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: (){},
                            child: Text('ARM HOME')),
                        ElevatedButton(
                            onPressed: (){},
                            child: Text('ARM AWAY'))
                      ],
                    )
                  ],

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}