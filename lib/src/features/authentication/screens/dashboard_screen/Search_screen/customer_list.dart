import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/customer_screen/customer_view.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/customer_screen/update_record.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';
import 'package:url_launcher/url_launcher.dart';

import '../customer_screen/AddMeasurementScreen.dart';
import '../customer_screen/MeasurementViewScreen.dart';

class customer_list_scerrn extends StatefulWidget {
  const customer_list_scerrn({super.key});

  @override
  State<customer_list_scerrn> createState() => _customer_list_scerrnState();
}

class _customer_list_scerrnState extends State<customer_list_scerrn> {
  Query dbref = FirebaseDatabase.instance.ref().child("customer");
  DatabaseReference reference =
  FirebaseDatabase.instance.ref().child("customer");

  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredCustomers = [];
  List<Map<dynamic, dynamic>> customerList = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(filterCustomers);
  }

  void filterCustomers() {
    String searchTerm = searchController.text.toLowerCase();

    setState(() {
      filteredCustomers.clear(); // Clear the list before filtering

      filteredCustomers = customerList.where((customer) {
        String customerId = customer['customerID'].toLowerCase();
        String customerName = customer['customerName'].toLowerCase();
        String customerPhone = customer['customerPhone'].toLowerCase();
        return customerId.contains(searchTerm) ||
            customerName.contains(searchTerm) ||
            customerPhone.contains(searchTerm);
      }).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search',
          ),
          onChanged: (value) {
            filterCustomers();
          },
        ),
        actions: [IconButton(onPressed: (){
          Get.to(()=>SearchScreen(customerKey: '',));
        }, icon: Icon(Icons.search))],
      ),
      body: Container(
        child: StreamBuilder(
          stream: dbref.onValue,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.loading,
                      style: TextStyle(color: Colors.green),
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

            if (!snapshot.hasData) {
              return Center(
                child: Text(AppLocalizations.of(context)!.noData),
              );
            }

            Map customers = snapshot.data.snapshot.value as Map;
            customers["key"] = snapshot.data.snapshot.key;

            return FirebaseAnimatedList(
              query: dbref,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map customers = snapshot.value as Map;
                customers["key"] = snapshot.key;
                return listItem(customers: customers);
              },
            );
          },
        ),
      ),
    );
  }






Widget listItem({required Map customers}) {
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
        top: 10,
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
                                customerKey: customers["key"],
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
                                    customerKey: customers["key"],
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
                                          customerskey: customers["key"])));
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
                                      reference
                                          .child(customers["key"])
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
}}