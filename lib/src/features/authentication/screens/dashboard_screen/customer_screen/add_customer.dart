import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';
import 'package:newapp/src/constants/text_string.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MeasurementForm extends StatefulWidget {
  @override
  _MeasurementFormState createState() => _MeasurementFormState();
}

class _MeasurementFormState extends State<MeasurementForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Define the selectedNumber field


  //------------------customers------------//

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _firstPayController = TextEditingController();
  TextEditingController _totalAmountController = TextEditingController();
  TextEditingController _clothAmountController = TextEditingController();

  //------------------order--------------------------//

  TextEditingController _orderController = TextEditingController();
  TextEditingController _deliveryController = TextEditingController();
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
  TextEditingController _quantityController = TextEditingController();


  final RegExp numberRegex = RegExp(r'^[0-9]+$');

  late DatabaseReference dbref;

  int currentCustomerNumber = 0;


  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child("customer");

    SharedPreferences.getInstance().then((prefs) {
      int storedCustomerNumber = prefs.getInt('customerID') ?? 0;
      setState(() {
        currentCustomerNumber = storedCustomerNumber;
      });
    });

    dbref.onChildAdded.listen((event) {
      String? customerId = event.snapshot.key;
      // Use the customer ID as needed
      print("New customer ID: $customerId");
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _clothAmountController.dispose();
    _orderController.dispose();
    _deliveryController.dispose();
    _shoulderController.dispose();
    _chestController.dispose();
    _waistController.dispose();
    _hipController.dispose();
    _inseamController.dispose();
    _neckController.dispose();
    _sleeveController.dispose();
    _frontController.dispose();
    _thighController.dispose();
    _kneeController.dispose();
    _pantslController.dispose();
    _lengthController.dispose();
    _noteController.dispose();
    _other1Controller.dispose();
    _other2Controller.dispose();
    _other3Controller.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      double shoulder = double.parse(_shoulderController.text);
      double chest = double.parse(_chestController.text);
      double waist = double.parse(_waistController.text);
      double hip = double.parse(_hipController.text);
      double inseam = double.parse(_inseamController.text);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      int storedCustomerNumber = prefs.getInt('customerID') ?? 0;

      currentCustomerNumber =
          storedCustomerNumber +1; // Increment the stored customer number
      prefs.setInt('customerID',
          currentCustomerNumber); // Store the updated customer number

      Map<String, String> customer = {
        "customerName": _nameController.text,
        "customerPhone": _phoneController.text,
        "clothAmount": _clothAmountController.text,
        "firstAmount": _firstPayController.text,
        "totalAmount": _totalAmountController.text,
        "customerOrder": _orderController.text,
        "customerDelivery": _deliveryController.text,
        "customerChest": _chestController.text,
        "customerWaist": _waistController.text,
        "customerShoulder": _shoulderController.text,
        "customerHip": _hipController.text,
        "customerInseam": _inseamController.text,
        "customerNeck": _neckController.text,
        "customerSleeve": _sleeveController.text,
        "customerFront": _frontController.text,
        "customerThigh": _thighController.text,
        "customerKnee": _kneeController.text,
        "customerPants": _pantslController.text,
        "customerLength": _lengthController.text,
        "customerNote": _noteController.text,
        "customerOther1": _other1Controller.text,
        "customerOther2": _other2Controller.text,
        "customerOther3": _other3Controller.text,
        "totalQuantity": _quantityController.text,
      };

      String customerPhone = _phoneController.text;

      dbref
          .orderByChild("customerPhone")
          .equalTo(customerPhone)
          .once()
          .then((DatabaseEvent event) {
        DataSnapshot snapshot = event.snapshot;
        if (snapshot.value != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                "Data already exists",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.red,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          );
        } else {
          String customerId = 'T${currentCustomerNumber.toString().padLeft(
              4, "0")}';
          customer["customerID"] = customerId;

          dbref.child(customerId).set(customer).then((value) {
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
                  "Error occurred while saving data",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
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
              "Error occurred while querying database",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.red,
                backgroundColor: Colors.white,
              ),
            ),
          ),
        );
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Measurement Form"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Rest of the form fields
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        child: Icon(Icons.save),
      ),
    );
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
                /////////////////////////////////////header//////////////////////////////////////////////////////

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
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    controller: _clothAmountController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          numberRegex), // Only allows input that matches the regular expression
                    ],
                    keyboardType: TextInputType.phone,
                    maxLength: 15,
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
                      labelText: AppLocalizations.of(context)!.cloth,
                      labelStyle: TextStyle(fontSize: 15),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                Wrap(
                  children: [
                    SizedBox(
                      width: 120,
                      child: TextFormField(
                        controller: _firstPayController,
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
                          labelText: AppLocalizations.of(context)!.firstPay,
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        controller: _quantityController,
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
                          labelText: AppLocalizations.of(context)!.quantity,
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Gap(5),

                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 120,
                      child: TextFormField(
                        controller: _totalAmountController,
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
                          labelText: AppLocalizations.of(context)!.totalPay,
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),

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
                            color: Colors.black,
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
                            color: Colors.black,
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
                Container(
                  color: Colors.blue,
                  height: 2,),
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
                ///////////////////////////////////////////////foter/////////////////////////////////////////////////////////////
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
                Gap(15),
                Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.only(bottom: 0),
                  width: double.infinity,
                  //--------------------------------------save btn---------------------------------------//
                  child: ElevatedButton(
                    onPressed:
                        _submitForm, // Call _submitForm when the button is pressed
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side:
                            BorderSide(color: Colors.white), // Add white border
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