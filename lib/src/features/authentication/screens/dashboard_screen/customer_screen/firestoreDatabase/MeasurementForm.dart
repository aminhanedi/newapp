import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';

import '../../../../../../constants/text_string.dart';

class TMeasurementForm extends StatefulWidget {
  @override
  _MeasurementFormState createState() => _MeasurementFormState();
}

class _MeasurementFormState extends State<TMeasurementForm> {
  int? _selectedNumber; // Define the selectedNumber field

  int get selectedNumber =>
      _selectedNumber ?? 1; // Define the selectedNumber getter

  set selectedNumber(int value) {
    setState(() {
      _selectedNumber = value;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //------------------customers------------//
  TextEditingController _customeridController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _orderController = TextEditingController();
  TextEditingController _deliveryController = TextEditingController();
  TextEditingController _firstPayController = TextEditingController();
  TextEditingController _lastPayController = TextEditingController();
  TextEditingController _totalPayController = TextEditingController();
  //-------------------mian controller-----------------------//
  TextEditingController _chestController = TextEditingController();
  TextEditingController _waistController = TextEditingController();
  TextEditingController _shoulderController = TextEditingController();
  TextEditingController _hipController = TextEditingController();
  TextEditingController _inseamController = TextEditingController();
  TextEditingController _neckController = TextEditingController();
  TextEditingController _sleeveController = TextEditingController();
  TextEditingController _frontController = TextEditingController();
  TextEditingController _thighController = TextEditingController();
  TextEditingController _kneeController = TextEditingController();
  TextEditingController _pantslController = TextEditingController();
  TextEditingController _lengthController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TextEditingController _other1Controller = TextEditingController();
  TextEditingController _other2Controller = TextEditingController();
  TextEditingController _other3Controller = TextEditingController();

  //------------------order--------------------------//

  final RegExp numberRegex = RegExp(r'^[0-9]+$');

  CollectionReference<Map<String, dynamic>> collectionRef =
      FirebaseFirestore.instance.collection('customers');

  @override
  void initState() {
    super.initState();
    collectionRef = FirebaseFirestore.instance.collection('customers');

    collectionRef
        .snapshots()
        .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
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
    _nameController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  int currentCustomerNumber = 0;
  void _submitForm() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      String customerName = _nameController.text;
      String customerPhone = _phoneController.text;
      String firstPay = _firstPayController.text;
      String lastPay = _lastPayController.text;
      String totalPay = _totalPayController.text;
      int? _selectedNumber;
      _selectedNumber = this.selectedNumber;

      String customerOrder = _orderController.text;
      String customerDelivery = _deliveryController.text;

      currentCustomerNumber++; // Increment the current customer number
      String customerID = 'TMS' + currentCustomerNumber.toString().padLeft(2, '0');

      CollectionReference customersCollection =
      FirebaseFirestore.instance.collection('customers');

      // Check if a customer with the same phone number already exists
      customersCollection
          .where('customerPhone', isEqualTo: customerPhone)
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.size > 0) {
          // Customer with the same phone number already exists
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                "Customer with the same phone number already exists",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          );
        } else {
          // Create a new customer document
          Map<String, dynamic> customer = {
            "customerID": customerID,
            "customerName": customerName,
            "customerPhone": customerPhone,
            "totalOrder": _selectedNumber.toString(),
            "firstPay": firstPay,
            "lastPay": lastPay,
            "TotalPay": totalPay,
            "customerOrder": customerOrder,
            "customerDelivery": customerDelivery,
          };

          DocumentReference customerDocRef = customersCollection.doc(customerID);

          // Create the customer document
          customerDocRef.set(customer).then((value) {
            // Create the measurement documents for each clothing order
            for (int i = 1; i <= _selectedNumber!; i++) {
              Map<String, dynamic> measurement = {
                "measurementID": 'Measurement $i',
                "customerChest": _chestController.text + ' $i',
                "customerWaist": _waistController.text + ' $i',
                "customerShoulder": _shoulderController.text + ' $i',
                "customerHip": _hipController.text + ' $i',
                "customerInseam": _inseamController.text + ' $i',
                "customerNeck": _neckController.text + ' $i',
                "customerSleeve": _sleeveController.text + ' $i',
                "customerFront": _frontController.text + ' $i',
                "customerThigh": _thighController.text + ' $i',
                "customerKnee": _kneeController.text + ' $i',
                "customerPants": _pantslController.text + ' $i',
                "customerLength": _lengthController.text + ' $i',
                "customerNote": _noteController.text + ' $i',
                "customerOther1": _other1Controller.text + ' $i',
                "customerOther2": _other2Controller.text + ' $i',
                "customerOther3": _other3Controller.text + ' $i',
                "customerID": customerID,
              };

              CollectionReference measurementCollection =
              customerDocRef.collection('measurement');
              DocumentReference measurementDocRef =
              measurementCollection.doc();

              // Create the measurement document within the "measurement" subcollection
              measurementDocRef.set(measurement).then((value) {
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
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.white,
                    content: Text(
                      "Error occurred while saving measurement data",
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
          }).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
              backgroundColor: Colors.white,
              content: Text(
              "Error occurred while saving customer data",
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
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              "Error occurred while checking customer data",
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
                  width:100,
                  child: DropdownButtonFormField<int>(
                    value: selectedNumber,
                    onChanged: (int? value) {
                      setState(() {
                        selectedNumber = value!;
                      });
                    },

                    decoration: InputDecoration(
                      labelText: ' تعداد سفارش',
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                    items: List<int>.generate(100, (index) => index + 1)
                        .map((int number) {
                      return DropdownMenuItem<int>(
                        value: number,
                        child: Text(number.toString()),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height:10,),

               Wrap(children: [
                 SizedBox(
                   width: 120,
                   child: TextFormField(
                     controller: _firstPayController,
                     inputFormatters: [
                       FilteringTextInputFormatter.allow(
                           numberRegex), // Only allows input that matches the regular expression
                     ],
                     keyboardType: TextInputType.phone,
                     maxLength:4,
                     validator: (value) {
                       if (value!.isEmpty) {
                         return AppLocalizations.of(context)!.requiredField;
                       }
                       if (!numberRegex.hasMatch(value)) {
                         return AppLocalizations.of(context)!.formValidator;
                       }
                       return null;
                     },
                     decoration: InputDecoration(
                       labelText: AppLocalizations.of(context)!.customerAmount,
                       labelStyle: TextStyle(fontSize: 15),
                       border: OutlineInputBorder(),
                     ),
                   ),
                 ),
                 SizedBox(  width:120,
                   child: TextFormField(
                     controller: _lastPayController,
                     inputFormatters: [
                       FilteringTextInputFormatter.allow(
                           numberRegex), // Only allows input that matches the regular expression
                     ],
                     keyboardType: TextInputType.phone,
                     maxLength: 4,
                     validator: (value) {
                       if (value!.isEmpty) {
                         return AppLocalizations.of(context)!.requiredField;
                       }
                       if (!numberRegex.hasMatch(value)) {
                         return AppLocalizations.of(context)!.formValidator;
                       }
                       return null;
                     },
                     decoration: InputDecoration(
                       labelText: AppLocalizations.of(context)!.customerAmount,
                       labelStyle: TextStyle(fontSize: 15),
                       border: OutlineInputBorder(),
                     ),
                   ),
                 ),
                 SizedBox(
                   width:120,
                   child: TextFormField(
                     controller: _totalPayController,
                     inputFormatters: [
                       FilteringTextInputFormatter.allow(
                           numberRegex), // Only allows input that matches the regular expression
                     ],
                     keyboardType: TextInputType.phone,
                     maxLength: 5,
                     validator: (value) {
                       if (value!.isEmpty) {
                         return AppLocalizations.of(context)!.requiredField;
                       }
                       if (!numberRegex.hasMatch(value)) {
                         return AppLocalizations.of(context)!.formValidator;
                       }
                       return null;
                     },
                     decoration: InputDecoration(
                       labelText: AppLocalizations.of(context)!.customerAmount,
                       labelStyle: TextStyle(fontSize: 15),
                       border: OutlineInputBorder(),
                     ),
                   ),
                 ),
               ],),
                Gap(10),
                Wrap(
                  children: [
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        controller: _orderController,
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.requiredField;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.blue,
                          ),
                          labelText: AppLocalizations.of(context)!.orderDate,
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        onTap: () {
                          _selectDateOrder(context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 150,
                      child: TextFormField(
                        controller: _deliveryController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.requiredField;
                          }

                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Colors.blue,
                          ),
                          labelText: AppLocalizations.of(context)!.deliveryDate,
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        onTap: () {
                          _selectDateDelivery(context);
                        },
                      ),
                    ),
                  ],
                ),

                Gap(20),
                /////////////////////////////////////////////////////main /////////////////////////////////////////////

                Gap(20),
                Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Wrap(
                          children: [
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                controller: _waistController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      numberRegex), // Only allows input that matches the regular expression
                                ],
                                maxLength: 4,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .requiredField;
                                  }

                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText:
                                  AppLocalizations.of(context)!.shoulder,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      numberRegex), // Only allows input that matches the regular expression
                                ],
                                maxLength: 4,
                                controller: _hipController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .requiredField;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText:
                                    AppLocalizations.of(context)!.chest,
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      numberRegex), // Only allows input that matches the regular expression
                                ],
                                controller: _shoulderController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .requiredField;
                                  }
                                  if (!numberRegex.hasMatch(value)) {
                                    return AppLocalizations.of(context)!
                                        .formValidator;
                                  }
                                  return null;
                                },
                                maxLength: 4,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText:
                                  AppLocalizations.of(context)!.skirt,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      numberRegex), // Only allows input that matches the regular expression
                                ],
                                controller: _inseamController,
                                maxLength: 4,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .requiredField;
                                  }
                                  if (!numberRegex.hasMatch(value)) {
                                    return AppLocalizations.of(context)!
                                        .formValidator;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText:
                                    AppLocalizations.of(context)!.sleeve,
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      numberRegex), // Only allows input that matches the regular expression
                                ],
                                controller: _chestController,
                                maxLength: 4,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .requiredField;
                                  }
                                  if (double.tryParse(value) == null) {
                                    return tvalide;
                                  }
                                  if (!numberRegex.hasMatch(value)) {
                                    return AppLocalizations.of(context)!
                                        .formValidator;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText:
                                  AppLocalizations.of(context)!.length,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      numberRegex), // Only allows input that matches the regular expression
                                ],
                                controller: _neckController,
                                maxLength: 4,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .requiredField;
                                  }
                                  if (!numberRegex.hasMatch(value)) {
                                    return AppLocalizations.of(context)!
                                        .formValidator;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText:
                                  AppLocalizations.of(context)!.collar,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      numberRegex), // Only allows input that matches the regular expression
                                ],
                                maxLength: 4,
                                controller: _sleeveController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .requiredField;
                                  }
                                  if (!numberRegex.hasMatch(value)) {
                                    return AppLocalizations.of(context)!
                                        .formValidator;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText:
                                    AppLocalizations.of(context)!.button,
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      numberRegex), // Only allows input that matches the regular expression
                                ],
                                controller: _frontController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .requiredField;
                                  }
                                  if (!numberRegex.hasMatch(value)) {
                                    return AppLocalizations.of(context)!
                                        .formValidator;
                                  }
                                  return null;
                                },
                                maxLength: 4,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context)!.hip,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      numberRegex), // Only allows input that matches the regular expression
                                ],
                                controller: _thighController,
                                maxLength: 4,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .requiredField;
                                  }
                                  if (!numberRegex.hasMatch(value)) {
                                    return AppLocalizations.of(context)!
                                        .formValidator;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText:
                                  AppLocalizations.of(context)!.inseam,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      numberRegex), // Only allows input that matches the regular expression
                                ],
                                maxLength: 4,
                                controller: _kneeController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .requiredField;
                                  }
                                  if (!numberRegex.hasMatch(value)) {
                                    return AppLocalizations.of(context)!
                                        .formValidator;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText:
                                    AppLocalizations.of(context)!.knee,
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      numberRegex), // Only allows input that matches the regular expression
                                ],
                                controller: _pantslController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .requiredField;
                                  }
                                  if (!numberRegex.hasMatch(value)) {
                                    return AppLocalizations.of(context)!
                                        .formValidator;
                                  }
                                  return null;
                                },
                                maxLength: 4,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText:
                                  AppLocalizations.of(context)!.thigh,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      numberRegex), // Only allows input that matches the regular expression
                                ],
                                controller: _lengthController,
                                maxLength: 4,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .requiredField;
                                  }
                                  if (!numberRegex.hasMatch(value)) {
                                    return AppLocalizations.of(context)!
                                        .formValidator;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText:
                                  AppLocalizations.of(context)!.waist,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      numberRegex), // Only allows input that matches the regular expression
                                ],
                                maxLength: 4,
                                controller: _other1Controller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText:
                                    AppLocalizations.of(context)!.other1,
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      numberRegex), // Only allows input that matches the regular expression
                                ],
                                controller: _other2Controller,
                                maxLength: 4,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText:
                                  AppLocalizations.of(context)!.other2,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      numberRegex), // Only allows input that matches the regular expression
                                ],
                                controller: _other3Controller,
                                maxLength: 4,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText:
                                  AppLocalizations.of(context)!.other3,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                  color: Colors.white38,
                  width: double.infinity,
                  child: TextFormField(
                    maxLines: 4,
                    controller: _noteController,
                    decoration: InputDecoration(
                        label: Text(
                          AppLocalizations.of(context)!.note,
                          style:
                          TextStyle(fontSize: 18, color: Colors.blueAccent),
                        ),
                        prefixIcon: Icon(Icons.note_alt,
                            size: 50,
                            shadows: [
                              Shadow(color: Colors.green),
                              Shadow(offset: Offset(2, 5))
                            ],
                            color: Colors.yellow),
                        border: OutlineInputBorder()),
                  ),
                ),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.save,
                      style: TextStyle(fontSize: 20),
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
        _orderController.text = formattedDate;
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

      if (_orderController.text.isNotEmpty) {
        final orderDate = DateFormat('yyyy-MM-dd').parse(_orderController.text);

        if (picked.isAfter(orderDate)) {
          setState(() {
            _deliveryController.text = formattedDate;
          });
        } else {
          // Display an error message or perform any desired action
          // when the selected delivery date is not greater than the order date
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Invalid Date'),
                content: Text(
                    'The selected delivery date must be greater than the order date.'),
                actions: <Widget>[
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
      } else {
        setState(() {
          _deliveryController.text = formattedDate;
        });
      }
    }
  }
}
