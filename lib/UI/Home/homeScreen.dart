import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home1/UI/Home/componentsHomePlan/lights.dart';
import 'package:smart_home1/UI/components/spaces/space.05.dart';

import '../components/LightSwitches.dart';
import '../components/homeContainers.dart';
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
                  padding: const EdgeInsets.only(top: 30),
                  child: Stack(
                    children: [
                      Image.asset('assets/images/home_plan.png',),
                      Positioned(
                        top: mediaQuery.size.height*.1,
                          left: mediaQuery.size.width*.04,
                          child: lights(),
                      ),
                      Positioned(
                        top: mediaQuery.size.height*.15,
                          right:mediaQuery.size.width*.35,
                          child: lights(),
                      ),
                      Positioned(
                        left: mediaQuery.size.width*.07,
                        bottom: mediaQuery.size.height*.001,
                          child: lights(),
                      ),
                      Positioned(
                        bottom: mediaQuery.size.height*.15,
                          right:mediaQuery.size.width*.1,
                          child: lights(),
                      )
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
                      LightSwitches(
                          nameSwitch: 'All Lights',
                        ),
                      LightSwitches(
                          nameSwitch:'Kitchen Lights',
                      ),
                      LightSwitches(
                          nameSwitch:'Living Room Lights',
                      ),
                      LightSwitches(
                          nameSwitch:'Porch Lights',
                      ),
                      LightSwitches(
                          nameSwitch:'Garage Lights',
                      ),
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