// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:newapp/src/features/authentication/screens/dashboard_screen/Search_screen/customer_view.dart';
// import 'package:newapp/src/features/authentication/screens/dashboard_screen/customer_screen/update_record.dart';
// import 'package:flutter_gen/gen_l10n/app-localization.dart';
// import 'package:url_launcher/url_launcher.dart';
//
//
//
// class Tcustomer_list_scerrn extends StatefulWidget {
//   const Tcustomer_list_scerrn({super.key});
//
//   @override
//   State<Tcustomer_list_scerrn> createState() => _customer_list_scerrnState();
// }
//
// class _customer_list_scerrnState extends State<Tcustomer_list_scerrn> {
//   // Widget listItem({required Map<String, dynamic> customers, required List<Widget> measurementWidgets}) {
//   //
//
//   CollectionReference<Map<String, dynamic>> customersRef =
//   FirebaseFirestore.instance.collection('customers');
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               Get.to(() => SearchScreen());
//             },
//             child: Icon(
//               Icons.search,
//               size: 35,
//             ),
//           )
//         ],
//       ),
//       body: Container(
//         child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//           stream: customersRef.snapshots(),
//           builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       AppLocalizations.of(context)!.loading,
//                       style: TextStyle(color: Colors.green),
//                     ),
//                     SizedBox(height: 15),
//                     CircularProgressIndicator(),
//                   ],
//                 ),
//               );
//             }
//
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error}'),
//               );
//             }
//
//             if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//               return Center(
//                 child: Text(AppLocalizations.of(context)!.noData),
//               );
//             }
//
//             return ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (BuildContext context, int index) {
//                 QueryDocumentSnapshot<Map<String, dynamic>> customerDoc = snapshot.data!.docs[index];
//                 String customerId = customerDoc.id;
//
//                 return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
//                   future: customerDoc.reference.collection('measurement').get(),
//                   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> measurementSnapshot) {
//                     if (measurementSnapshot.connectionState == ConnectionState.waiting) {
//                       return CircularProgressIndicator();
//                     }
//
//                     if (measurementSnapshot.hasError) {
//                       return Text('Error: ${measurementSnapshot.error.toString()}');
//                     }
//
//                     if (measurementSnapshot.data == null) {
//                       return Text('No measurement data available');
//                     }
//
//                     List<QueryDocumentSnapshot<Map<String, dynamic>>> measurementDocs = measurementSnapshot.data!.docs;
//
//                     // Extract the measurement data from each document
//                     List<Map<String, dynamic>> measurements = measurementDocs
//                         .map((measurementDoc) => measurementDoc.data())
//                         .toList();
//
//                     if (measurements.isEmpty) {
//                       return Text('No measurement data available');
//                     }
//
//                     return listItem(
//                       context: context,
//                       customerID: customerId,
//                       measurementWidgets: measurements.map((measurementData) {
//                         return buildMeasurementWidget(
//                           measurementData: measurementData,
//                           context: context,
//                           customers: customerDoc.data(),
//                         );
//                       }).toList(),
//                       customers: customerDoc.data(),
//                     );
//                   },
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//
//
//   Widget listItem({
//     required BuildContext context,
//     required String customerID,
//     required List<Widget> measurementWidgets,
//     required Map<String, dynamic>? customers, // Make customers nullable
//   }) {
//     // Check if customers is null before accessing its properties
//     final customerId = customers?["customerID"] ?? "";
//     final customerName = customers?["customerName"] ?? "";
//     final customerPhone = customers?["customerPhone"] ?? "";
//     final customerAmount = customers?["customerAmount"] ?? "";
//
//     return Container(
//       margin: EdgeInsets.only(bottom: 10),
//       padding: EdgeInsets.all(10),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.important_devices,
//                 size: 18,
//                 color: Colors.amberAccent,
//               ),
//               Gap(10),
//               Text(
//                 '${AppLocalizations.of(context)!.customerId} $customerId',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ],
//           ),
//           Gap(5),
//           Row(
//             children: [
//               Icon(
//                 Icons.person,
//                 size: 18,
//                 color: Colors.amberAccent,
//               ),
//               Gap(10),
//               Text(
//                 '${AppLocalizations.of(context)!.customerName} $customerName',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//               ),
//             ],
//           ),
//           Gap(5),
//           Row(
//             children: [
//               Icon(
//                 Icons.numbers,
//                 size: 18,
//                 color: Colors.amberAccent,
//               ),
//               SizedBox(width: 10),
//               Text(
//                 '${AppLocalizations.of(context)!.customerPhone} $customerPhone',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//               ),
//               Gap(40),
//               IconButton(
//                 onPressed: () async {
//                   String uri = 'tel:$customerPhone';
//
//                   if (await canLaunch(uri)) {
//                     await launch(uri);
//                   } else {
//                     throw 'Could not launch $uri';
//                   }
//                 },
//                 icon: Icon(Icons.call,
//                     color: Colors.lightGreenAccent,
//                     size: 30,
//                     shadows: [BoxShadow(offset: Offset(0, 5))]),
//               ),
//             ],
//           ),
//           Gap(5),
//           Row(
//             children: [
//               Icon(
//                 Icons.monetization_on,
//                 size: 18,
//                 color: Colors.amberAccent,
//               ),
//               Gap(10),
//               Text(
//                 '${AppLocalizations.of(context)!.customerAmount}  $customerAmount',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//               ),
//             ],
//           ),
//           Gap(5),
//
//           ...measurementWidgets,
//         ],
//       ),
//     );
//   }
//
//   Widget buildMeasurementWidget({
//     required Map<String, dynamic> measurementData,
//     required BuildContext context,
//     required Map<String, dynamic> customers,
//   }) {
//     return SingleChildScrollView(
//       child:GestureDetector(
//         onTap: () {
//           if (measurementData != null) { // Check if measurementData is not null
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => MeasurementScreen(measurementData: measurementData),
//               ),
//             );
//           }
//         },
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//
//           Text("See More Details"),
//             Icon(Icons.arrow_forward),
//           ],
//         ),
//       )
//     );
//   }}