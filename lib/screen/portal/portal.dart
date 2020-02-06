import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mapallo/screen/portal/portal_home.dart';
import 'package:mapallo/screen/portal/portal_notifications.dart';
import 'package:mapallo/screen/portal/portal_search.dart';
import 'package:mapallo/screen/portal/portal_settings.dart';
import 'package:mapallo/screen/portal/portal_upload.dart';
import 'package:mapallo/value/style_value.dart';

class Portal extends StatefulWidget {
  Portal({Key key})
      : title = "Home",
        super(key: key);

  final String title;

  @override
  _PortalState createState() => _PortalState();
}

class _PortalState extends State<Portal> {
  final List<Map> menuItems = [
    {'name': 'Home', 'icon': Icon(Icons.home), 'widget': PortalHome()},
    {'name': 'Search', 'icon': Icon(Icons.search), 'widget': PortalSearch()},
    {'name': 'Upload', 'icon': Icon(Icons.add_box), 'widget': PortalUpload()},
    {
      'name': 'Alerts',
      'icon': Icon(Icons.notifications),
      'widget': PortalNotifications()
    },
    {
      'name': 'Settings',
      'icon': Icon(Icons.settings),
      'widget': PortalSettings()
    },
  ];

  int _currentMenuIndex = 0;
  Widget _activeScreen;

  @override
  void initState() {
    super.initState();
    setState(() => _activeScreen = PortalHome());
  }

  List _getMenuItems() {
    return menuItems
        .map((item) => BottomNavigationBarItem(
            icon: item['icon'], title: Text(item['name'])))
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    final nav = BottomNavigationBar(
      currentIndex: _currentMenuIndex,
      items: _getMenuItems(),
      unselectedItemColor: StyleValue.GREY,
      selectedItemColor: StyleValue.SECONDARY,
      onTap: (index) {
        setState(() {
          _currentMenuIndex = index;
          _activeScreen = menuItems[index]['widget'];
        });
      },
    );

    final body = Container(
      child: _activeScreen ?? Center(child: CircularProgressIndicator()),
    );

    return Scaffold(
      bottomNavigationBar: nav,
      body: body,
    );
  }
}
