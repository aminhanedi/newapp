import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newapp/src/constants/text_string.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/customer_screen/update_record.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';


class customer_list_scerrn extends StatefulWidget {
  const customer_list_scerrn({super.key});

  @override
  State<customer_list_scerrn> createState() => _customer_list_scerrnState();
}

class _customer_list_scerrnState extends State<customer_list_scerrn> {
  Widget listItem({required Map customers}) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,  // Background color of the container
          borderRadius: BorderRadius.circular(15),  // Rounded corner radius
          border: Border.all(
            color: Colors.amberAccent,
            width:2,
          ),  // Border properties
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],  // Box shadow properties
        ),
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Icon(Icons.important_devices,size: 18,color: Colors.amberAccent,),
                Gap(10),
                Text(
                  '${AppLocalizations.of(context)!.customerId} ${customers["customerID"]}',
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
                Icon(Icons.person,size: 18,color: Colors.amberAccent,),
                Gap(10),
                Text(
                    '${AppLocalizations.of(context)!.customerName} ${customers["customerName"]}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Gap(10),
            Row(
              children: [
                Icon(Icons.call,size: 18,color: Colors.amberAccent,),
                Gap(10),
                Text(
                  '${AppLocalizations.of(context)!.customerPhone} ${customers["customerPhone"]}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Gap(10),
            Row(
              children: [
                Icon(Icons.monetization_on,size: 18,color: Colors.amberAccent,),
                Gap(10),
                Text(
                  '${AppLocalizations.of(context)!.customerAmount}  ${customers["customerAmount"]}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
                          '${AppLocalizations.of(context)!.orderDate}  ${customers["customerOrder"]}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        )),
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
            Divider(
              color: Colors.amberAccent,
              thickness: 1.0,
              height: 20.0,
            ),
            Wrap(
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    '${AppLocalizations.of(context)!.shoulder}  ${customers["customerChest"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    '${AppLocalizations.of(context)!.chest}  ${customers["customerFront"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    '${AppLocalizations.of(context)!.skirt}  ${customers["customerNeck"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
                    '${AppLocalizations.of(context)!.sleeve}  ${customers["customerHip"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    '${AppLocalizations.of(context)!.length} ${customers["customerInseam"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    '${AppLocalizations.of(context)!.collar}  ${customers["customerPants"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
                    '${AppLocalizations.of(context)!.button}  ${customers["customerShoulder"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    '${AppLocalizations.of(context)!.hip}  ${customers["customerSleeve"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    '${AppLocalizations.of(context)!.inseam}  ${customers["customerThigh"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
                    '${AppLocalizations.of(context)!.knee}  ${customers["customerKnee"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    '${AppLocalizations.of(context)!.thigh} ${customers["customerWaist"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    '${AppLocalizations.of(context)!.waist}  ${customers["customerLength"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
                    '${AppLocalizations.of(context)!.other1}  ${customers["customerOther1"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    '${AppLocalizations.of(context)!.other2}  ${customers["customerOther2"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: Text(
                    '${AppLocalizations.of(context)!.other3}  ${customers["customerOther3"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
                color: Colors.blue, // Background color of the container
                borderRadius: BorderRadius.circular(8), // Rounded corner radius
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
                  '${AppLocalizations.of(context)!.note}  ${customers["customerNote"]}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ), // Your child widgets go here
            ),
            Gap(10),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  GestureDetector(
                    onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (_)=> upddate_record(customerskey:customers["key"])));
                    },
                    child: Icon(
                      Icons.edit,
                      color:Colors.amberAccent,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(AppLocalizations.of(context)!.conformationD),
                            content: Text(AppLocalizations.of(context)!.areD),
                            actions: <Widget>[
                              TextButton(
                                child: Text(AppLocalizations.of(context)!.no),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the alert dialog
                                },
                              ),
                              TextButton(
                                child: Text(AppLocalizations.of(context)!.yes),
                                onPressed: () {
                                  reference.child(customers["key"]).remove();
                                  Navigator.of(context).pop(); // Close the alert dialog
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
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }

  Query dbref = FirebaseDatabase.instance.ref().child("customer");
  DatabaseReference reference=FirebaseDatabase.instance.ref().child("customer");

  TextEditingController _searchController = TextEditingController();
  List<Map<dynamic, dynamic>> customerList = [];
  void filterCustomers(String searchTerm) {
    setState(() {
      if (searchTerm.isEmpty) {
        customerList = []; // Show an empty list if the search term is empty
      } else {
        customerList = customerList.where((customer) {
          String customerID = customer['customerName'] ?? '';
          String email = customer['customerID'] ?? '';
          return customerID.toLowerCase().contains(searchTerm.toLowerCase()) ||
              email.toLowerCase().contains(searchTerm.toLowerCase());
        }).toList();
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: (value) {
            filterCustomers(value);
          },
          decoration: InputDecoration(

            border: OutlineInputBorder(),
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: Container(
          child:StreamBuilder(
            stream: dbref.onValue, // Replace 'dbref' with your Firebase database reference
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show loader while data is loading
                return  Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context)!.loading,style: TextStyle(color: Colors.green),),
                      Gap(15),
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }


              if (snapshot.hasError) {
                // Handle error state
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              if (!snapshot.hasData) {
                // Handle empty data state
                return Center(
                  child: Text(AppLocalizations.of(context)!.noData),
                );
              }

              // Data is available
              Map customers = snapshot.data.snapshot.value as Map;
              customers["key"] = snapshot.data.snapshot.key;

              return FirebaseAnimatedList(
                query: dbref,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map customers = snapshot.value as Map;
                  customers["key"]=snapshot.key;// Use the 'customers' map here to build your list items
                  return listItem(customers: customers);
                },
              );
            },
          )
      ),
    );
  }
}
