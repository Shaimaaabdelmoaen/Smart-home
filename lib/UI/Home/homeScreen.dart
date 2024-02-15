import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/LightSwitches.dart';
import '../components/homeContainers.dart';
import 'drawer/homeDrawer.dart';

class homeScreen extends StatefulWidget{
  static const routeName='home';

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:homeDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,

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
                height: 550,
                name: 'Home Plan',
              ),
              SizedBox(height: 20,),
              homeContainers(
                  height: 450,
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
              SizedBox(height: 20,),
              homeContainers(
                  height: 300,
                icon: Icons.thermostat,
                  name: 'Temperature',
              ),
              SizedBox(height: 20,),
              homeContainers(
                  height: 250,
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
                    SizedBox(height: 20,),
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