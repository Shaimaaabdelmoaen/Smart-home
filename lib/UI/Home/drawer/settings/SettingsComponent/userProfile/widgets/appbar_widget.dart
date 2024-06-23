import 'package:flutter/material.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  String appName;
  BuildAppBar({required this.appName});
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      iconTheme: IconThemeData(color: Colors.white),
      leading: BackButton(),
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(appName),
      // elevation: 0,
    );
  }
}