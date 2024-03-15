import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';

import 'UpdateMeasurementScreen.dart';


class MeasurementViewScreen extends StatefulWidget {
  final String customerKey;

  const MeasurementViewScreen({required this.customerKey});

  @override
  _MeasurementViewScreenState createState() => _MeasurementViewScreenState();
}

class _MeasurementViewScreenState extends State<MeasurementViewScreen> {
  final measurementRef = FirebaseDatabase.instance.reference();
  List<Map<String, dynamic>> measurements = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,

      appBar: AppBar(
        title: Text("Measurements"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: measurements.length,
          itemBuilder: (context, index) {
            if (index >= measurements.length) {
              return null; // Return null if index is out of range
            }
            return listItem(
              context,
              measurement: measurements[index],
              index: index,
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadMeasurements();
  }

  void loadMeasurements() {
    measurementRef
        .child("customer")
        .child(widget.customerKey)
        .child("measurements")
        .onValue
        .listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          measurements.clear();
          Map<dynamic, dynamic> data =
          event.snapshot.value as Map<dynamic, dynamic>;
          data.forEach((key, value) {
            measurements.add({
              "measurementKey": key,
              ...value,
            });
          });
        });
      }
    });
  }

  void _deleteMeasurement(int index) {
    String measurementId = measurements[index]["measurementKey"];

    setState(() {
      measurements.removeAt(index);
    });

    measurementRef
        .child("customer")
        .child(widget.customerKey)
        .child("measurements")
        .child(measurementId)
        .remove()
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Measurement deleted successfully.'),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete measurement.'),
        ),
      );
    });
  }

  Widget listItem(BuildContext context,
      {required Map<String, dynamic> measurement, required int index}) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              offset: Offset(0, 0),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${AppLocalizations.of(context)!.measurements} ${index + 1}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 15),

            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 18,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text(
                  '${AppLocalizations.of(context)!.customerName}  ${measurement["Name"]}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
           Gap(10),

            Row(
              children: [
                Icon(
                  Icons.monetization_on,
                  size: 18,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text(
                  '${AppLocalizations.of(context)!.cloth}  ${measurement["clothAmount"]}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Gap(10),
            Container(height:3,color: Colors.blue,),
            Gap(10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.shoulder}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${measurement["customerChest"]}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.chest}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${measurement["customerFront"]}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.skirt}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${measurement["customerNeck"]}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.sleeve}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${measurement["customerHip"]}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.length}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${measurement["customerInseam"]}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.collar}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${measurement["customerPants"]}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.button}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${measurement["customerShoulder"]}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.hip}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${measurement["customerSleeve"]}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocalizations.of(context)!.waist}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        '${measurement["customerWaist"]}',
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(20),
            Container(
              padding: EdgeInsets.all(5),
              height: 80,
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
              child: SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Text(
                    '${AppLocalizations.of(context)!.note}  ${measurement["customerNote"]}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.delete,color: Colors.red,),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Delete Measurement'),
                          content: Text('Are you sure you want to delete this measurement?'),
                          actions: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Delete'),
                              onPressed: () {
                                _deleteMeasurement(index);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                SizedBox(width: 20,),
                IconButton(
                  icon: Icon(Icons.edit,color: Colors.blue,),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateRecordScreen(
                          customerKey: widget.customerKey,
                          measurementKey: measurement["measurementKey"],
                          measurement: measurement,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],

        ),
      ),
    );
  }}