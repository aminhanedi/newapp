import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';


class REPORT extends StatefulWidget {
  const REPORT({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<REPORT> {
  TextEditingController searchController = TextEditingController();

  DatabaseReference customersRef =
      FirebaseDatabase.instance.ref().child('customer');

  List<Map<dynamic, dynamic>> customerList = [];

  void filterCustomers(String searchTerm) {
    setState(() {
      if (searchTerm.isEmpty) {
        customerList.clear();
        fetchCustomers(); // Reload the data when search term is empty
      } else {
        customerList = customerList.where((customer) {
          String customerName = customer['customerName'] ?? '';
          String customerID = customer['customerID'] ?? '';
          String customerPhone = customer['customerPhone'] ?? '';
          return customerName
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()) ||
              customerPhone.toLowerCase().contains(searchTerm.toLowerCase()) ||
              customerID.toLowerCase().contains(searchTerm.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  @override
  void dispose() {
    searchController.dispose(); // Dispose the TextEditingController
    super.dispose();
  }

  void fetchCustomers() async {
    try {
      DatabaseEvent event = await customersRef.once();
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> values =
        event.snapshot.value as Map<dynamic, dynamic>;

        List<Map<dynamic, dynamic>> tempList = [];

        values.forEach((key, item) {
          tempList.add(item);
        });

        tempList.sort((a, b) {
          DateTime? aTimestamp = a['timestamp'] != null ? DateTime.tryParse(a['timestamp']) : null;
          DateTime? bTimestamp = b['timestamp'] != null ? DateTime.tryParse(b['timestamp']) : null;
          if (aTimestamp != null && bTimestamp != null) {
            return bTimestamp.compareTo(aTimestamp);
          }
          return 0;
        });

        setState(() {
          customerList = tempList;
        });
      }
    } catch (error) {
      print("Error fetching customers: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CupertinoSearchTextField(
          itemColor: Colors.blue,
          backgroundColor: Colors.white,
          itemSize: 25,
          borderRadius: BorderRadius.circular(10),
          style: TextStyle(),
          controller: searchController,
          onChanged: filterCustomers,
        ),
      ),
      body: Container(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: customerList.length,
                itemBuilder: (context, index) {
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
                                '${AppLocalizations.of(context)!.customerId} ${customerList[index]["customerID"]} ',
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
                                '${AppLocalizations.of(context)!.customerName} ${customerList[index]["customerName"]}',
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
                              '${AppLocalizations.of(context)!. quantity} ${customerList[index]["totalQuantity"]}',
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
                                '${AppLocalizations.of(context)!.customerPhone}${customerList[index]["customerPhone"]}',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Gap(40),
                              IconButton(
                                onPressed: () async {
                                  String uri = 'tel:${customerList[index]["customerPhone"]}';

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
                                '${AppLocalizations.of(context)!.customerAmount}  ${customerList[index]["totalAmount"]}',
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
                                        '${AppLocalizations.of(context)!.orderDate}  ${customerList[index]["customerOrder"]}',
                                        style: TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.w400),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 170,
                                    child: Text(
                                      '${AppLocalizations.of(context)!.deliveryDate}  ${customerList[index]["customerDelivery"]}',
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
