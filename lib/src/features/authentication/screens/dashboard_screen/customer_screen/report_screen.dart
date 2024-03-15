import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Search_screen/search_screenTCl.dart';

class MyWidget extends StatefulWidget {
  final String customerKey;

  MyWidget({required this.customerKey});
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<dynamic> orders = [];
  int totalOrders = 0;
  double totalAmount = 0.0;
  int totalQuantity = 0;


  DatabaseReference _databaseRef =
  FirebaseDatabase.instance.ref().child('customer');

  void searchOrders(String startDate, String endDate) {
    _databaseRef
        .orderByChild('customerOrder')
        .startAt(startDate)
        .endAt(endDate)
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {
        final Map<dynamic, dynamic> data =
        event.snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          orders = data.values.toList();
          calculateTotals();
        });
      } else {
        setState(() {
          orders = [];
          totalOrders = 0;
          totalAmount = 0.0;
          totalQuantity = 0;
          totalMeasurements = 0;
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.noOrder),
              content: Text(
                  '${AppLocalizations.of(context)!
                      .noOrderFound} $startDate ${AppLocalizations.of(context)!
                      .and} $endDate.'),
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

  // ... Rest of the code ...

  void calculateTotals() {
    totalOrders = orders.length;

    totalMeasurements = 0;

    for (final order in orders) {
      final customerId = order['customerId'];
      if (customerId != null) {
        DatabaseReference customerRef =
        _databaseRef.child(customerId).child('measurements');

        customerRef.once().then((DatabaseEvent snapshot) {
          if (snapshot.snapshot.value != null) {
            final Map<dynamic, dynamic> measurements =
            snapshot.snapshot.value as Map<dynamic, dynamic>;
            setState(() {
              totalMeasurements += measurements.length;
            });
          }
        });
      }
    }

    // Calculate totalAmount and totalQuantity as before
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
      totalMeasurements = 0;
    }
  }


  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  void _showDateSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  margin: EdgeInsets.only(bottom: 20),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.searchOrder,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          AppLocalizations.of(context)!.specify,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextField(
                  controller: startDateController,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(
                      Icons.calendar_today,
                      color: Colors.blue,
                    ),
                    labelText: AppLocalizations.of(context)!.startDate,
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(),
                  ),
                  onTap: () {
                    _selectDateOrder(context);
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(
                      Icons.calendar_today,
                      color: Colors.blue,
                    ),
                    labelText: AppLocalizations.of(context)!.endDate,
                    border: OutlineInputBorder(),
                  ),
                  controller: endDateController,
                  onTap: () {
                    _selectDateDelivery(context);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    String startDate = startDateController.text;
                    String endDate = endDateController.text;
                    searchOrders(startDate, endDate);
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(AppLocalizations.of(context)!.search),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectDateOrder(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        startDateController.text = formattedDate;
      });
    }
  }

  void _selectDateDelivery(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);

      if (startDateController.text.isNotEmpty) {
        final orderDate =
        DateFormat('yyyy-MM-dd').parse(startDateController.text);

        if (picked.isAfter(orderDate)) {
          setState(() {
            endDateController.text = formattedDate;
          });
        } else {
          // Display an error message or perform any desired action
          // when the selected delivery date is not greater than the order date
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(AppLocalizations.of(context)!.invalidDate),
                content: Text(AppLocalizations.of(context)!.invalidDateA,
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(AppLocalizations.of(context)!.ok,),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      } else {
        setState(() {
          endDateController.text = formattedDate;
        });
      }
    }
  }

  String? selectedOption = 'March';

  void _searchData() {
    if (selectedOption == 'Today') {
      DateTime now = DateTime.now();
      String startDate =
          '${now.year}-${_formatNumber(now.month)}-${_formatNumber(now.day)}';
      String endDate =
          '${now.year}-${_formatNumber(now.month)}-${_formatNumber(now.day)}';
      searchOrders(startDate, endDate);
    } else if (selectedOption == 'Last Month') {
      DateTime today = DateTime.now();
      DateTime lastMonthStart = DateTime(today.year, today.month - 1, 1);
      DateTime lastMonthEnd = DateTime(today.year, today.month, 0);
      String startDate =
          '${lastMonthStart.year}-${_formatNumber(
          lastMonthStart.month)}-${_formatNumber(lastMonthStart.day)}';
      String endDate =
          '${lastMonthEnd.year}-${_formatNumber(
          lastMonthEnd.month)}-${_formatNumber(lastMonthEnd.day)}';
      searchOrders(startDate, endDate);
    } else {
      // Convert month name to month index
      int selectedMonth = DateTime
          .now()
          .month;
      switch (selectedOption) {
        case 'January':
          selectedMonth = 1;
          break;
        case 'February':
          selectedMonth = 2;
          break;
        case 'March':
          selectedMonth = 3;
          break;
        case 'April':
          selectedMonth = 4;
          break;
        case 'May':
          selectedMonth = 5;
          break;
        case 'June':
          selectedMonth = 6;
          break;
        case 'July':
          selectedMonth = 7;
          break;
        case 'August':
          selectedMonth = 8;
          break;
        case 'September':
          selectedMonth = 9;
          break;
        case 'October':
          selectedMonth = 10;
          break;
        case 'November':
          selectedMonth = 11;
          break;
        case 'December':
          selectedMonth = 12;
          break;
      }

      DateTime now = DateTime.now();
      int selectedYear = DateTime
          .now()
          .year;
      DateTime monthStart = DateTime(selectedYear, selectedMonth, 1);
      DateTime monthEnd = DateTime(selectedYear, selectedMonth + 1, 0);
      String startDate =
          '${monthStart.year}-${_formatNumber(
          monthStart.month)}-${_formatNumber(monthStart.day)}';
      String endDate =
          '${monthEnd.year}-${_formatNumber(monthEnd.month)}-${_formatNumber(
          monthEnd.day)}';
      searchOrders(startDate, endDate);
    }
  }

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.only(left: 15),
            child: DropdownButton<String>(
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: GoogleFonts
                      .openSans()
                      .fontFamily),
              icon: Icon(
                Icons.arrow_drop_down,
                size: 30,
                color: Colors.white,
              ),
              value: selectedOption,
              onChanged: (String? newValue) {
                setState(() {
                  if (newValue == AppLocalizations.of(context)!.custom) {
                    _showDateSearchDialog(context);
                  } else {
                    selectedOption = newValue;
                    _searchData();
                  }
                });
              },
              dropdownColor: Colors.blue,
              items: <String>[
                AppLocalizations.of(context)!.custom,
                'January',
                'February',
                'March',
                'April',
                'May',
                'June',
                'July',
                'August',
                'September',
                'October',
                'November',
                'December',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final customers = orders[index];

                  return listItem(context: context, customers: customers);
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Background color of the container
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)), // Rounded corner radius
                border: Border.all(
                  color: Colors.black12,
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
              height: 160,
              padding: EdgeInsets.all(16),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.calculatedD,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: GoogleFonts
                            .openSans()
                            .fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.totalA,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts
                                .openSans()
                                .fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.money),
                        Text(
                          '\$${totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            backgroundColor: Colors.lightGreenAccent,
                            fontFamily: GoogleFonts
                                .openSans()
                                .fontFamily,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.totalC,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts
                                .openSans()
                                .fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.person),
                        Text(
                          '\#$totalOrders.00',
                          style: TextStyle(
                            fontSize: 16,
                            backgroundColor: Colors.lightGreenAccent,
                            fontFamily: GoogleFonts
                                .openSans()
                                .fontFamily,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.totalO,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: GoogleFonts
                                .openSans()
                                .fontFamily,
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
                            fontFamily: GoogleFonts
                                .openSans()
                                .fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DatabaseReference customersRef = FirebaseDatabase.instance.ref() ;
  List<Map<dynamic, dynamic>> customerList = [];
  int totalMeasurements = 0;

  @override
  void initState() {
    super.initState();
    _searchData();
    fetchCustomers();
  }

  void fetchCustomers() {
    customersRef.child(widget.customerKey).child('measurements').onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          totalMeasurements = data.length;
        });
      }
    });
  }


  Widget listItem({required BuildContext context, required Map customers}) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white70, // Background color of the container
          borderRadius: BorderRadius.circular(8), // Rounded corner radius

          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 3),
              blurRadius: 2,
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
                  color: Colors.black,
                ),
                Gap(10),
                Text(
                  '${AppLocalizations.of(context)!
                      .customerId} ${customers["customerID"]}',
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
                  color: Colors.black,
                ),
                Gap(10),
                Text(
                  '${AppLocalizations.of(context)!
                      .customerName} ${customers["customerName"]}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Gap(5),
            Row(
              children: [
                Icon(
                  Icons.people_outline,
                  size: 18,
                  color: Colors.black,
                ),
                Gap(10),
                Text(
                  '${AppLocalizations.of(context)!
                      .quantity} ${customers["aa"]}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.numbers,
                  size: 18,
                  color: Colors.black,
                ),
                SizedBox(width: 10),
                Text(
                  '${AppLocalizations.of(context)!
                      .customerPhone}${customers["customerPhone"]}',
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
                  color: Colors.black,
                ),
                Gap(10),
                Text(
                  '${AppLocalizations.of(context)!
                      .customerAmount}  ${customers["totalAmount"]}',
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
                          '${AppLocalizations.of(context)!
                              .orderDate}  ${customers["customerOrder"]}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 170,
                      child: Text(
                        '${AppLocalizations.of(context)!
                            .deliveryDate}  ${customers["customerDelivery"]}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ),

                  ]),
                ]),
            Text(
              'Total Measurements: $totalMeasurements',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}