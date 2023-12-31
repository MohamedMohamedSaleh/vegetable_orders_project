import 'package:flutter/material.dart';
import 'package:vegetable_orders_project/views/home/pages/favs/favs_view.dart';
import 'package:vegetable_orders_project/views/home/pages/main/main_view.dart';
import 'package:vegetable_orders_project/views/home/pages/my_account/my_account_view.dart';
import 'package:vegetable_orders_project/views/home/pages/my_orders/my_orders_view.dart';
import 'package:vegetable_orders_project/views/home/pages/notifications/notifications_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
    'favorites',
    'my_orders',
    'notifications',
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
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: const Color(0xffAED489),
          selectedItemColor: Colors.white,
          currentIndex: currentIndex,
          onTap: (value) {
            currentIndex = value;
            setState(() {});
          },
          // the best way is List generator
          items: List.generate(
            pages.length,
            (index) => BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icon/svg/${icons[index]}.svg',
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
    );
  }
}



