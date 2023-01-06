import 'package:fakestore_main_app/app_utils.dart';
import 'package:fakestore_main_app/routes/app_router.dart';
import 'package:fakestore_main_app/routes/profile/profile_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyCustomBottomNavBarItem extends BottomNavigationBarItem {
  String initialLocation;

  MyCustomBottomNavBarItem(
      {required this.initialLocation,
      required Widget icon,
      String? label,
      Widget? activeIcon})
      : super(icon: icon, label: label, activeIcon: activeIcon ?? icon);
}

class ScaffoldWithNavBar extends StatefulWidget {
  String location;
  ScaffoldWithNavBar({super.key, required this.child, required this.location});

  final Widget child;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  int _currentIndex = 0;

  List<MyCustomBottomNavBarItem> tabs = [];

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(fontFamily: 'Roboto');
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: labelStyle,
        unselectedLabelStyle: labelStyle,
        selectedItemColor: const Color(0xFF434343),
        selectedFontSize: 12,
        unselectedItemColor: const Color(0xFF838383),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          _goOtherTab(context, index);
        },
        currentIndex: widget.location == '/'
            ? 0
            : widget.location == '/discover'
                ? 1
                : widget.location == '/shop'
                    ? 2
                    : 3,
        items: getTabs(),
      ),
    );
  }

  List<MyCustomBottomNavBarItem> getTabs() {
    if (tabs.isEmpty) {
      // init
      tabs = [
        MyCustomBottomNavBarItem(
          icon: Icon(Icons.apps_outlined),
          activeIcon: Icon(Icons.apps),
          label:
              AppUtils.getLocalizationContext(context).main_view_nav_bar_home,
          initialLocation: '/',
        ),
        MyCustomBottomNavBarItem(
          icon: Icon(Icons.star_outline),
          activeIcon: Icon(Icons.star),
          label: AppUtils.getLocalizationContext(context)
              .main_view_nav_bar_wishlist,
          initialLocation: '/discover',
        ),
        MyCustomBottomNavBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: AppUtils.getLocalizationContext(context)
              .main_view_nav_bar_profile,
          initialLocation: AppRouter.shared
              .getProfileRoutes()
              .getPageLocation(ProfileRoutesLocation.profile),
        ),
      ];
    }

    return tabs;
  }

  void _goOtherTab(BuildContext context, int index) {
    if (index == _currentIndex) return;
    GoRouter router = GoRouter.of(context);
    String location = tabs[index].initialLocation;

    setState(() {
      _currentIndex = index;
    });
    if (index == 3) {
      context.push('/login');
    } else {
      router.go(location);
    }
  }
}
