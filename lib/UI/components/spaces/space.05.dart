import 'package:flutter/cupertino.dart';

class space1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return SizedBox(height: mediaQuery.size.height*.05,);
  }

}