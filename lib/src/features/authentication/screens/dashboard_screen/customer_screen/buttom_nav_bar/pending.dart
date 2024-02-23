
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class pending_order extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<pending_order> {
  List<dynamic> orders = [];
  int totalOrders = 0;
  double totalAmount = 0.0;
  int totalQuantity = 0;

  DatabaseReference _databaseRef =
  FirebaseDatabase.instance.reference().child('customer');

  @override
  void initState() {
    super.initState();
    _searchData();
  }

  void _searchData() {
    if (selectedOption == 'Today') {
      DateTime now = DateTime.now();
      String startDate =
          '${now.year}-${_formatNumber(now.month)}-${_formatNumber(now.day)}';
      String endDate =
          '${now.year}-${_formatNumber(now.month)}-${_formatNumber(now.day)}';
      searchOrders(startDate, endDate);
    }
  }

  void searchOrders(String startDate, String endDate) {
    final DateTime currentDate = DateTime.now();
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    _databaseRef
        .orderByChild('customerOrder')
        .equalTo(startDate)
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {
        final Map<dynamic, dynamic> data =
        event.snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          orders = data.values.where((order) {
            final DateTime orderDate =
            _parseDate(order['customerOrder'], dateFormat);
            final DateTime deliveryDate =
            _parseDate(order['customerDelivery'], dateFormat);
            return _isSameDate(orderDate, currentDate) &&
                deliveryDate.isAfter(currentDate);
          }).toList();
          calculateTotals();
        });
      } else {
        setState(() {
          orders = [];
          totalOrders = 0;
          totalAmount = 0.0;
          totalQuantity = 0;
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('No Orders Found'),
              content:
              Text('No orders found between $startDate and $endDate.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  DateTime _parseDate(String dateStr, DateFormat dateFormat) {
    try {
      return dateFormat.parse(dateStr);
    } catch (e) {
      // Handle parsing error
      print('Error parsing date: $dateStr');
      return DateTime(2000); // Provide a default value here
    }
  }

  bool _isSameDate(DateTime date1, DateTime date2) {
    if (date1 == null || date2 == null) {
      return false;
    }

    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void calculateTotals() {
    totalOrders = orders.length;
    totalAmount = orders.fold(0.0, (double sum, order) {
      final orderAmount = order['totalAmount'];
      if (orderAmount == null || orderAmount == '') {
        return sum;
      }
      final parsedAmount = double.tryParse(orderAmount);
      if (parsedAmount == null) {
        return sum;
      }
      return sum + parsedAmount;
    });

    totalQuantity = 0; // Reset totalQuantity to zero before calculating

    for (final order in orders) {
      final orderQuantity = order['totalQuantity'];
      if (orderQuantity != null) {
        final parsedQuantity = int.tryParse(orderQuantity.toString());
        if (parsedQuantity != null) {
          totalQuantity += parsedQuantity;
        }
      }
    }

    // Handle the case when there are no orders
    if (totalOrders == 0) {
      totalAmount = 0.0;
      totalQuantity = 0;
    }
  }

  String? selectedOption = 'Today';

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue, // Background color of the container
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)), // Rounded corner radius
                border: Border.all(
                  color: Colors.amberAccent,
                  width: 2,
                ), // Border properties
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ], // Box shadow properties
              ),
              height: 145,
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CALCULATED DATA",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: GoogleFonts.openSans().fontFamily,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'TOTAL AMOUNT: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: GoogleFonts.openSans().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.money),
                      Text(
                        '\$${totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          backgroundColor: Colors.lightGreenAccent,
                          fontFamily: GoogleFonts.openSans().fontFamily,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'TOTAL CUSTOMER: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: GoogleFonts.openSans().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.person),
                      Text(
                        '\#$totalOrders.00',
                        style: TextStyle(
                          fontSize: 16,
                          backgroundColor: Colors.lightGreenAccent,
                          fontFamily: GoogleFonts.openSans().fontFamily,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'ORDER Quantities: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: GoogleFonts.openSans().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.people),
                      Gap(10),
                      Text(
                        '\#$totalQuantity.00',
                        style: TextStyle(
                          fontSize: 16,
                          backgroundColor: Colors.lightGreenAccent,
                          fontFamily: GoogleFonts.openSans().fontFamily,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child:ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final customers = orders[index];

                  return listItem(context: context, customers: customers);
                },
              ),
            ),
          ],
        ),

      ),
    );
  }
}
Widget listItem({required BuildContext context, required Map customers}){
  return SingleChildScrollView(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue, // Background color of the container
        borderRadius: BorderRadius.circular(8), // Rounded corner radius
        border: Border.all(
          color: Colors.amberAccent,
          width: 2,
        ), // Border properties
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ], // Box shadow properties
      ),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.important_devices,
                size: 18,
                color: Colors.amberAccent,
              ),
              Gap(10),
              Text(
                '${AppLocalizations.of(context)!.customerId} ${customers["customerID"]} ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Gap(5),
          Row(
            children: [
              Icon(
                Icons.person,
                size: 18,
                color: Colors.amberAccent,
              ),
              Gap(10),
              Text(
                '${AppLocalizations.of(context)!.customerName} ${customers["customerName"]}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Gap(5),
          Row(children: [
            Icon(Icons.people_outline, size: 18,
              color: Colors.amberAccent,),
            Gap(10),
            Text(
              '${AppLocalizations.of(context)!. quantity} ${customers["totalQuantity"]}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],),

          Row(
            children: [
              Icon(
                Icons.numbers,
                size: 18,
                color: Colors.amberAccent,
              ),
              SizedBox(width: 10),
              Text(
                '${AppLocalizations.of(context)!.customerPhone}${customers["customerPhone"]}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Gap(40),
              IconButton(
                onPressed: () async {
                  String uri = 'tel:${customers["customerPhone"]}';

                  if (await canLaunch(uri)) {
                    await launch(uri);
                  } else {
                    throw 'Could not launch $uri';
                  }
                },
                icon: Icon(Icons.call,
                    color: Colors.lightGreenAccent,
                    size: 30,
                    shadows: [BoxShadow(offset: Offset(0, 5))]),
              ),
            ],
          ),

          Row(
            children: [
              Icon(
                Icons.monetization_on,
                size: 18,
                color: Colors.amberAccent,
              ),
              Gap(10),
              Text(
                '${AppLocalizations.of(context)!.customerAmount}  ${customers["totalAmount"]}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Gap(5),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(children: [
                  SizedBox(
                      width: 160,
                      child: Text(
                        '${AppLocalizations.of(context)!.orderDate}  ${customers["customerOrder"]}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 170,
                    child: Text(
                      '${AppLocalizations.of(context)!.deliveryDate}  ${customers["customerDelivery"]}',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ]),
              ]),


        ],
      ),
    ),
  );
}