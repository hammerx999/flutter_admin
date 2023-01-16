import 'package:flutter/material.dart';
import 'package:flutter_admin/app_bar/app_bar_widget.dart';
import 'package:flutter_admin/drawer/drawer_page.dart';
import 'package:flutter_admin/panel_center/panel_center.page.dart';
import 'package:flutter_admin/panel_left/panel_left_page.dart';
import 'package:flutter_admin/panel_right/panel_right_page.dart';
import 'package:flutter_admin/responsive_layout.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: (ResponsiveLayuot.isTinyLimit(context) ||
                ResponsiveLayuot.isTinyHeightLimit(context)
            ? Container()
            : AppBarWidget()),
        preferredSize: Size(double.infinity, 100),
      ),
      body: ResponsiveLayuot(
        tiny: Container(),
        phone: PanelCenterPage(),
        tablet: Row(
          children: [
            Expanded(child: PanelLeftPage()),
            Expanded(child: PanelCenterPage()),
          ],
        ),
        largeTablet:Row(
          children: [
            Expanded(child: PanelLeftPage()),
            Expanded(child: PanelCenterPage()),
            Expanded(child: PanelRightPage()),
          ],
        ),
        computer: Row(
          children: [
            Expanded(child: DrawerPage()),
            Expanded(child: PanelLeftPage()),
            Expanded(child: PanelCenterPage()),
            Expanded(child: PanelRightPage()),
          ],
        ),
      ),
      drawer: DrawerPage(),
    );
  }
}
