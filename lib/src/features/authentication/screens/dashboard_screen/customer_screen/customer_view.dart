import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'AddMeasurementScreen.dart';
import 'MeasurementViewScreen.dart';
import 'update_record.dart';

class SearchScreen extends StatefulWidget {
  final String customerKey;

  SearchScreen({required this.customerKey});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  DatabaseReference customersRef =
  FirebaseDatabase.instance.ref().child('customer');



  List<Map<dynamic, dynamic>> customerList = [];

  void filterCustomers(String searchTerm) {
    setState(() {
      if (searchTerm.isEmpty) {
        customerList.clear();
        fetchCustomers(); // Reload the data when the search term is empty
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

  void fetchCustomers() {
    customersRef.child(widget.customerKey).onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          customerList.clear();
          Map<dynamic, dynamic> data =
          event.snapshot.value as Map<dynamic, dynamic>;
          data.forEach((key, value) {
            customerList.add({
              "customerRef": key,
              ...value,
            });
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
            ),
            StreamBuilder(
              stream: customersRef.onValue,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.loading,
                          style: TextStyle(color: Colors.green ,fontSize: 20),
                        ),
                        Gap(15),
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot==Null) {
                  return Center(
                    child: Text(AppLocalizations.of(context)!.noData),
                  );
                }



                return  Expanded(
                  child: ListView.builder(
                    itemCount: customerList.length,
                    itemBuilder: (context, index) {
                      return listItem(
                        context: context,
                        customers: customerList[index],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget listItem({required BuildContext context, required Map customers}) {
  DatabaseReference customersRef = FirebaseDatabase.instance.ref().child('customer');



  return SingleChildScrollView(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the container
        borderRadius: BorderRadius.circular(8), // Rounded corner radius

        boxShadow: [
          BoxShadow(
            color: Colors.blue,
            offset: Offset(2, 2),
            blurRadius: 5,
          ),
        ], // Box shadow properties
      ),
      margin: EdgeInsets.only(
        bottom: 10,
        left: 10,
        right: 10,
        top: 0,
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.co_present_outlined,
                    size: 25,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10),
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
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 25,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${AppLocalizations.of(context)!
                        .customerName} ${customers["customerName"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.numbers,
                    size: 25,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10),
                  Text(
                    '${AppLocalizations.of(context)!
                        .customerPhone}${customers["customerPhone"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () async {
                      String uri = 'tel:${customers["customerPhone"]}';

                      if (await canLaunch(uri)) {
                        await launch(uri);
                      } else {
                        throw 'Could not launch $uri';
                      }
                    },
                    icon: Icon(
                      Icons.call,
                      color: Colors.lightGreenAccent,
                      size: 30,
                      shadows: [BoxShadow(offset: Offset(0, 5))],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.monetization_on, color: Colors.blue, size: 25,),
                  Gap(10),
                  Expanded(
                    child: Text(
                      '${AppLocalizations.of(context)!
                          .firstPay}  ${customers["firstAmount"]}',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Icon(Icons.monetization_on, color: Colors.blue, size: 25),
                  Gap(10),
                  Expanded(
                    child: Text(
                      '${AppLocalizations.of(context)!
                          .totalAmount}  ${customers["totalAmount"]}',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.date_range, color: Colors.blue, size: 25,),
                  Gap(10),
                  Expanded(
                    child: Text(
                      '${AppLocalizations.of(context)!
                          .orderDate}  ${customers["customerOrder"]}',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.date_range, color: Colors.blue, size: 25,),
                  Gap(10),
                  Expanded(
                    child: Text(
                      '${AppLocalizations.of(context)!
                          .deliveryDate}  ${customers["customerDelivery"]}',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ],
          ),

          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(left: 15, right: 15),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 1),
                  blurRadius: 1,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle tap event...
                  },
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AddMeasurementScreen(
                                customerKey: customers["customerRef"],
                              ),
                        ),
                      );
                    },
                    icon: Icon(Icons.person_add_alt),
                    label: Text("ADD"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: SizedBox(
                    child: GestureDetector(
                      onTap: () {
                        // Handle tap event...
                      },
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  MeasurementViewScreen(
                                    customerKey: customers["customerRef"],
                                  ),
                            ),
                          );
                        },
                        icon: Icon(Icons.people),
                        label: Text("See"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Gap(10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      upddate_record(
                                          customerskey: customers["customerRef"])));
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(AppLocalizations.of(context)!
                                    .conformationD),
                                content:
                                Text(AppLocalizations.of(context)!.areD),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                        AppLocalizations.of(context)!.no),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Close the alert dialog
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                        AppLocalizations.of(context)!.yes),
                                    onPressed: () {
                                      customersRef
                                          .child(customers["customerRef"])
                                          .remove();
                                      Navigator.of(context)
                                          .pop(); // Close the alert dialog
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}















