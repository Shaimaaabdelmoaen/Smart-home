import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homeContainers extends StatelessWidget{
  double? height;
  String? name;
  IconData? icon;
  final Widget? child;
  homeContainers({this.height,required this.name,this.child,this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height:height,
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
                  name!,
                  style: const TextStyle(
                  ),
                ),
                Icon(icon,color: Theme.of(context).primaryColor,size: 30,),
              ],
            ),
            Divider(color: Theme.of(context).dividerColor,),
            if (child != null) ...[
              const SizedBox(height: 15),
              child!,
            ],

          ],
        ),
      ),
    );
  }
}