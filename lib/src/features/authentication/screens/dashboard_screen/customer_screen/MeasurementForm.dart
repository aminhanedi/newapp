import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';

class TMeasurementForm extends StatefulWidget {
  @override
  _MeasurementFormState createState() => _MeasurementFormState();
}

class _MeasurementFormState extends State<TMeasurementForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //------------------customers------------//

  TextEditingController _customeridController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  //------------------order--------------------------//

  final RegExp numberRegex = RegExp(r'^[0-9]+$');

  CollectionReference<Map<String, dynamic>> collectionRef =
  FirebaseFirestore.instance.collection('customers');



  @override
  void initState() {
    super.initState();
    collectionRef = FirebaseFirestore.instance.collection('User');

    collectionRef.snapshots().listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      for (var docChange in snapshot.docChanges) {
        if (docChange.type == DocumentChangeType.added) {
          String? customerId = docChange.doc.id;
          // Use the customer ID as needed
          print("New customer ID: $customerId");
        }
      }
    });
  }

  @override
  void dispose() {
    _customeridController.dispose();
    _nameController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      String customerName = _nameController.text;
      String customerID = _customeridController.text;
      String customerPhone = _phoneController.text;

      Map<String, dynamic> customer = {
        "customerID": customerID,
        "customerName": customerName,
        "customerPhone": customerPhone,
      };

      collectionRef
          .doc(customerID)
          .set(customer)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              "Data saved successfully",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.green,
                backgroundColor: Colors.white,
              ),
            ),
          ),
        );
      })
          .catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              "Error occurred while saving data",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                backgroundColor: Colors.white,
              ),
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.insertPage,
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        //-----------------------------------form widget----------------------------//
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,

                ),
                /////////////////////////////////////header//////////////////////////////////////////////////////
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    controller: _customeridController,
                    maxLength: 20,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.requiredField;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.customerId,
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                Gap(5),
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    controller: _nameController,
                    maxLength: 20,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.requiredField;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.customerName,
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    maxLength: 15,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.requiredField;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.customerPhone,
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),

                Gap(20),
                /////////////////////////////////////////////////////main /////////////////////////////////////////////

                ///////////////////////////////////////////////foter/////////////////////////////////////////////////////////////

                Gap(15),
                Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.only(bottom: 0),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _submitForm();

                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.save,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
