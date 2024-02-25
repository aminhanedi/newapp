import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/customer_screen/buttom_nav_bar/pending.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/customer_screen/buttom_nav_bar/today_delivary.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/customer_screen/buttom_nav_bar/today_order.dart';
import '../../Search_screen/searchScreenCL.dart';
import '../../Search_screen/search_screenTCl.dart';
import 'complet.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyButtomNavBarState();
}

class _MyButtomNavBarState extends State<MyBottomNavBar> {
  int myCurrentIndex = 0;
  List pages = [
    pending_order(),
    complete_order(),
    today_order(),
    today_delivary(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("  "),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.to(() =>
                  REPORT()); // Navigate to the REPORT screen when the button is pressed
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.transparent, // Set the background color to transparent
              elevation: 0, // Remove the button elevation
            ),
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.transparent, // Set the ink color to transparent
              ),
              child: Icon(
                Icons.search,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.amberAccent.withOpacity(0.8),
              blurRadius: 40,
              offset: const Offset(10, 15))
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BottomNavigationBar(
              backgroundColor: Colors.lightBlueAccent,
              // backgroundColor: Colors.transparent,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.amberAccent,
              currentIndex: myCurrentIndex,
              onTap: (index) {
                setState(() {
                  myCurrentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.people),
                    label: "Pending Order",
                    backgroundColor: Colors.lightBlue),
                BottomNavigationBarItem(
                    icon: Icon(Icons.delivery_dining, weight: 20),
                    label: "Delivered",
                    backgroundColor: Colors.lightBlue),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.local_grocery_store_rounded,
                    ),
                    label: "Today orders",
                    backgroundColor: Colors.lightBlue),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people_outline),
                    label: "Complete New,",
                    backgroundColor: Colors.lightBlue),
              ]),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
