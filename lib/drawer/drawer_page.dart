import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_admin/constants.dart';
import 'package:flutter_admin/responsive_layout.dart';

class DrawerPage extends StatefulWidget {
  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class ButtonsInfo {
  String title;
  IconData icon;
  String route;
  ButtonsInfo({required this.title, required this.icon, required this.route});
}

int _currentIndex = 0;

List<ButtonsInfo> _buttonNames = [
  ButtonsInfo(title: "Home", icon: Icons.home, route: '/'),
  ButtonsInfo(title: "Notifications", icon: Icons.notifications, route: '/add'),
  ButtonsInfo(title: "Users", icon: Icons.supervised_user_circle_rounded, route: '/add'),
];

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Constants.kPadding),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "Admin Menu",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: ResponsiveLayuot.isComputer(context)
                    ? null
                    : IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close, color: Colors.white)),
              ),
              ...List.generate(
                  _buttonNames.length,
                  (index) => Column(
                        children: [
                          Container(
                            decoration: index == _currentIndex
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(colors: [
                                      Constants.redDark.withOpacity(0.9),
                                      Constants.orangeDark.withOpacity(0.9)
                                    ]),
                                  )
                                : null,
                            child: ListTile(
                              title: Text(
                                _buttonNames[index].title,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              leading: Padding(
                                padding:
                                    const EdgeInsets.all(Constants.kPadding),
                                child: Icon(
                                  _buttonNames[index].icon,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  Navigator.pushNamed(context,  _buttonNames[index].route);
                                  _currentIndex = index;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.white,
                            thickness: 0.1,
                          )
                        ],
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
