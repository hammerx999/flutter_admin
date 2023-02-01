import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin/app_bar/app_bar_widget.dart';
import 'package:flutter_admin/bill/add_stack.dart';
import 'package:flutter_admin/bill/list_room_page.dart';
import 'package:flutter_admin/bill/list_room_page2.dart';
import 'package:flutter_admin/constants.dart';
import 'package:flutter_admin/drawer/drawer_page.dart';
import 'package:flutter_admin/panel_center/panel_center.page.dart';
import 'package:flutter_admin/panel_left/panel_left_page.dart';
import 'package:flutter_admin/panel_right/panel_right_page.dart';
import 'package:flutter_admin/responsive_layout.dart';
import 'package:http/http.dart';

import 'bill/add_bill_page.dart';

class AddBill extends StatefulWidget {
  @override
  _AddBillState createState() => _AddBillState();
}

class _AddBillState extends State<AddBill> {
  int currentIndex = 1;

  List<Widget> _icons = [
    Icon(
      Icons.add,
      size: 30,
    ),
    Icon(
      Icons.list,
      size: 30,
    ),
    Icon(
      Icons.compare_arrows,
      size: 30,
    )
  ];

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
        phone: currentIndex == 0
            ? PanelLeftPage()
            : currentIndex == 1
                ? ListRoomPage()
                : AddBillPage(),
        tablet: Row(
          children: [
            Expanded(child: PanelLeftPage()),
            Expanded(child: PanelCenterPage()),
          ],
        ),
        largeTablet: Row(
          children: [
            Expanded(child: AddBillPage()),
            Expanded(child: AddBillPage()),
            Expanded(child: AddBillPage()),
          ],
        ),
        computer: Row(
          children: [ 
            Expanded(child: DrawerPage()),
            Expanded(child: ListRoomPage()),
            Expanded(child: ListRoomPage2()),
            Expanded(child: Container()),
          ],
        ),
      ),
      drawer: DrawerPage(),
      bottomNavigationBar: ResponsiveLayuot.isPhone(context)
          ? CurvedNavigationBar(
              index: currentIndex,
              backgroundColor: Constants.purpleDark,
              items: _icons,
              onTap: ((index) {
                setState(() {
                  currentIndex = index;
                });
              }))
          : SizedBox(),
    );
  }
}
