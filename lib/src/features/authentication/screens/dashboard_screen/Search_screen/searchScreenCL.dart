import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

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
          // Extract the 'timestamp' values from each item in the list
          DateTime? aTimestamp =
              a['timestamp'] != null ? DateTime.tryParse(a['timestamp']) : null;
          DateTime? bTimestamp =
              b['timestamp'] != null ? DateTime.tryParse(b['timestamp']) : null;

          // Check if both 'timestamp' values are not null
          if (aTimestamp != null && bTimestamp != null) {
            // Compare the 'timestamp' values in descending order (bTimestamp to aTimestamp)
            return bTimestamp.compareTo(aTimestamp);
          }

          // If any 'timestamp' value is null, maintain the original order
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
        automaticallyImplyLeading: true,
        backgroundColor: Colors.blue,
        title: CupertinoSearchTextField(
          itemColor: Colors.blue,
          backgroundColor: Colors.white,
          itemSize: 30,
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
                        borderRadius:
                            BorderRadius.circular(15), // Rounded corner radius
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
                                '${AppLocalizations.of(context)!.customerId} ${customerList[index]["customerID"]}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Gap(10),
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
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Gap(10),
                          Row(
                            children: [
                              Icon(
                                Icons.call,
                                size: 18,
                                color: Colors.amberAccent,
                              ),
                              Gap(10),
                              Text(
                                '${AppLocalizations.of(context)!.customerPhone} ${customerList[index]["customerPhone"]}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Gap(40),
                              IconButton(
                                onPressed: () async {
                                  String uri =
                                      'tel:${customerList[index]["customerPhone"]}';

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
                          Gap(10),
                          Row(
                            children: [
                              Icon(
                                Icons.monetization_on,
                                size: 18,
                                color: Colors.amberAccent,
                              ),
                              Gap(10),
                              Text(
                                '${AppLocalizations.of(context)!.customerAmount}  ${customerList[index]["customerAmount"]}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Gap(10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Wrap(children: [
                                  SizedBox(
                                      width: 170,
                                      child: Text(
                                        '${AppLocalizations.of(context)!.orderDate}  ${customerList[index]["customerOrder"]}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      )),
                                  SizedBox(
                                    width: 170,
                                    child: Text(
                                      '${AppLocalizations.of(context)!.deliveryDate}  ${customerList[index]["customerDelivery"]}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ]),
                              ]),
                          const Divider(
                            color: Colors.amberAccent,
                            thickness: 1.0,
                            height: 20.0,
                          ),
                          Wrap(
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  '${AppLocalizations.of(context)!.shoulder}  ${customerList[index]["customerChest"]}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Text(
                                  '${AppLocalizations.of(context)!.chest}  ${customerList[index]["customerFront"]}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Text(
                                  '${AppLocalizations.of(context)!.skirt}  ${customerList[index]["customerNeck"]}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          Gap(10),
                          Wrap(
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  '${AppLocalizations.of(context)!.sleeve}  ${customerList[index]["customerHip"]}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Text(
                                  '${AppLocalizations.of(context)!.length} ${customerList[index]["customerInseam"]}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Text(
                                  '${AppLocalizations.of(context)!.collar}  ${customerList[index]["customerPants"]}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          Gap(10),
                          Wrap(
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  '${AppLocalizations.of(context)!.button}  ${customerList[index]["customerShoulder"]}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Text(
                                  '${AppLocalizations.of(context)!.hip}  ${customerList[index]["customerSleeve"]}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Text(
                                  '${AppLocalizations.of(context)!.inseam}  ${customerList[index]["customerThigh"]}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          Gap(10),
                          Wrap(
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  '${AppLocalizations.of(context)!.knee}  ${customerList[index]["customerKnee"]}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Text(
                                  '${AppLocalizations.of(context)!.thigh} ${customerList[index]["customerWaist"]}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Text(
                                  '${AppLocalizations.of(context)!.waist}  ${customerList[index]["customerLength"]}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          Gap(10),
                          Wrap(
                            children: [
                              SizedBox(
                                width: 120,
                                child: Text(
                                  '${AppLocalizations.of(context)!.other1}  ${customerList[index]["customerOther1"]}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Text(
                                  '${AppLocalizations.of(context)!.other2}  ${customerList[index]["customerOther2"]}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Text(
                                  '${AppLocalizations.of(context)!.other3}  ${customerList[index]["customerOther3"]}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          Gap(10),
                          Container(
                            padding: EdgeInsets.all(5),
                            height: 100,
                            decoration: BoxDecoration(
                              // Background color of the container
                              color: Colors
                                  .blue, // Background color of the container
                              borderRadius: BorderRadius.circular(
                                  8), // Rounded corner radius
                              border: Border.all(
                                color: Colors.amberAccent,
                                width: 1,
                              ), // Border properties
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ], // Box shadow properties
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                '${AppLocalizations.of(context)!.note}  ${customerList[index]["customerNote"]}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ), // Your child widgets go here
                          ),
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
