import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homeContainers extends StatefulWidget{
  double? height;
  String? name;
  IconData? icon;
  final Widget? child;
  homeContainers({this.height,required this.name,this.child,this.icon});

  @override
  State<homeContainers> createState() => _homeContainersState();
}

class _homeContainersState extends State<homeContainers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height:widget.height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFF2F2F2), // Shadow color
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name!,
                  style: const TextStyle(
                  ),
                ),
                Icon(widget.icon,color: Theme.of(context).primaryColor,size: 30,),
              ],
            ),
            Divider(color: Theme.of(context).dividerColor,),
            if (widget.child != null) ...[
              const SizedBox(height: 15),
              widget.child!,
            ],

          ],
        ),
      ),
    );
  }
}