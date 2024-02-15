import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homeContainers extends StatelessWidget{
  double? height;
  String? name;
  IconData? icon;
  final Widget? child;
  homeContainers({required this.height,required this.name,this.child,this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height:height,
      decoration: BoxDecoration(
        color: Color(0xFF262D3B33),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
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
                    color: Colors.black54,
                    fontSize: 20,
                  ),
                ),
                Icon(icon,color: Theme.of(context).primaryColor,size: 30,),
              ],
            ),
            Divider(color: Colors.black38,height: Checkbox.width,),
            if (child != null) ...[
              const SizedBox(height: 10),
              child!,
            ],
          ],
        ),
      ),
    );
  }
}