import 'package:flutter/cupertino.dart';

class space1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SizedBox(height: mediaQuery.size.height*.05,);
  }

}