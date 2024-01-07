import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/customer_screen/add_customer.dart';
import 'package:newapp/src/features/authentication/screens/welcome/welcome_screen.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text('Hello Arain!',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white)),
                  subtitle: Text('Good Morning',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white54)),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(200))),
              child: GestureDetector(
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 30,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (contaxt) => MeasurementForm()),
                        );

                        print('Item clicked!');
                      },
                      child: itemDashboard('Add CUSTOMER',
                          CupertinoIcons.add, Colors.deepOrange),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (contaxt) => Welcome()),
                        );

                        print('Item clicked!');
                      },
                      child: itemDashboard(
                          'View CUSTOMER', CupertinoIcons.phone, Colors.pinkAccent),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (contaxt) => Welcome()),
                        );

                        print('Item clicked!');
                      },
                      child: itemDashboard(
                          'Total Order', CupertinoIcons.person_2_fill, Colors.blue),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (contaxt) => Welcome()),
                        );

                        print('Item clicked!');
                      },
                      child: itemDashboard('Gallery',
                          CupertinoIcons.photo_fill_on_rectangle_fill, Colors.indigo),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (contaxt) => Welcome()),
                        );

                        print('Item clicked!');
                      },
                      child: itemDashboard(
                          'Sitting', CupertinoIcons.gear_big, Colors.purple),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (contaxt) => Welcome()),
                        );

                        print('Item clicked!');
                      },
                      child: itemDashboard('Calculator',
                          CupertinoIcons.square_favorites_alt    , Colors.brown),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (contaxt) => Welcome()),
                        );

                        print('Item clicked!');
                      },
                      child: itemDashboard('Analytics',
                          CupertinoIcons.graph_circle, Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background) => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 1),
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: Colors.white)),
            const SizedBox(height: 8),
            Text(title.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium)
          ],
        ),
      );
}
