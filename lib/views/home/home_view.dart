import 'package:flutter/material.dart';
import 'package:vegetable_orders_project/views/home/pages/favs/favs_view.dart';
import 'package:vegetable_orders_project/views/home/pages/main/main_view.dart';
import 'package:vegetable_orders_project/views/home/pages/my_account/my_account_view.dart';
import 'package:vegetable_orders_project/views/home/pages/my_orders/my_orders_view.dart';
import 'package:vegetable_orders_project/views/home/pages/notifications/notifications_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
    this.isNavigatToOrder = false,
  });
  final bool isNavigatToOrder;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isNavigate = true;
  int currentIndex = 0;
  List<Widget> pages = [
    const MainPage(),
    const MyOrdersPage(),
    const NotificationsPage(),
    const FavsPage(),
    const MyAccountPage(),
  ];

  List<String> icons = [
    'main',
    'my_orders',
    'notifications',
    'favorites',
    'my_account',
  ];

  List<String> label = [
    'الرئيسية',
    'طلباتي',
    'الإشعارات',
    'المفضلة',
    'حسابي',
  ];

  @override
  Widget build(BuildContext context) {
    if (isNavigate && widget.isNavigatToOrder) {
      currentIndex = 1;
    }
    return WillPopScope(
      onWillPop: () async {
        if (currentIndex != 0) {
          currentIndex = 0;
          setState(() {
            
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: isNavigate && widget.isNavigatToOrder
            ? pages[1]
            : pages[currentIndex],
        bottomNavigationBar: SafeArea(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: const Color(0xffAED489),
              selectedItemColor: Colors.white,
              currentIndex: currentIndex,
              onTap: (value) {
                currentIndex = value;
                isNavigate = false;
                setState(() {});
              },
              // the best way is List generator
              items: List.generate(
                pages.length,
                (index) => BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icon/svg/${icons[index]}.svg',
                    // ignore: deprecated_member_use
                    color: currentIndex == index
                        ? Colors.white
                        : const Color(0xffAED489),
                  ),
                  label: label[index],
                ),
              ),
              type: BottomNavigationBarType.fixed,
            ),
          ),
        ),
      ),
    );
  }
}
