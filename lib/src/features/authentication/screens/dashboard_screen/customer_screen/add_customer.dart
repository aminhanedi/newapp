import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/customer_screen/AddMeasurementScreen.dart';
import 'package:newapp/src/features/authentication/screens/dashboard_screen/Search_screen/customer_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../signup/signup.dart';
import 'customer_view.dart';


class MeasurementForm extends StatefulWidget {
  @override
  _MeasurementFormState createState() => _MeasurementFormState();
}

class _MeasurementFormState extends State<MeasurementForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //------------------customer controllers------------//

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _firstPayController = TextEditingController();
  TextEditingController _totalAmountController = TextEditingController();
  TextEditingController _clothAmountController = TextEditingController();
  TextEditingController _orderController = TextEditingController();
  TextEditingController _deliveryController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();


  final RegExp numberRegex = RegExp(r'^[0-9]+$');

  late DatabaseReference dbref;

  int currentCustomerNumber = 0;




  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child("customer");

    SharedPreferences.getInstance().then((prefs) {
      int storedCustomerNumber = prefs.getInt('customerNumber') ?? 0;
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

    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;


      SharedPreferences prefs = await SharedPreferences.getInstance();
      int storedCustomerNumber = prefs.getInt('customersNumber') ?? 0;

      currentCustomerNumber =
          storedCustomerNumber +1; // Increment the stored customer number
      prefs.setInt('customersNumber',
          currentCustomerNumber); // Store the updated customer number

      Map<String, String> customer = {
        "customerName": _nameController.text,
        "customerPhone": _phoneController.text,
        "clothAmount": _clothAmountController.text,
        "firstAmount": _firstPayController.text,
        "totalAmount": _totalAmountController.text,
        "customerOrder": _orderController.text,
        "customerDelivery": _deliveryController.text,
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
              6, "0")}';
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
            Get.to(() =>  SearchScreen(customerKey: '',));
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          //-----------------------------------form widget----------------------------//
           child: Container(
              margin: EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 4,
                              child: Lottie.asset('assets/images/tailoring.json',
                                  height: 200)),
                        ],
                      ),
                      Text(AppLocalizations.of(context)!.enterTheCustomer,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700,color: Colors.blueGrey),),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _nameController,
                        maxLength: 20,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.requiredField;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.drive_file_rename_outline,color: Colors.blue,size: 25,),
                          labelText: AppLocalizations.of(context)!.customerName,
                          labelStyle: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]!,width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
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
                          prefixIcon: Icon(Icons.person_add,color: Colors.blue,size: 25,),
                          labelText: AppLocalizations.of(context)!.customerPhone,
                          labelStyle: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        ),
                      ),
                      SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(

                              controller: _firstPayController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(numberRegex),
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
                                  labelStyle: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[400]!),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 16, horizontal: 16),

                              ),

                            ),
                          ),

                          SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _totalAmountController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(numberRegex),
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
                                labelStyle: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[400]!),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                                contentPadding:
                                EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
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
                                border: OutlineInputBorder(),
                              ),
                              readOnly: true,
                              onTap: () {
                                _selectDateOrder(context);
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: _deliveryController,
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
                      SizedBox(height:30),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _submitForm();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.blue, // Set the text color
                            padding: EdgeInsets.symmetric(vertical: 15), // Adjust the button's padding
                            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700), // Set the text style
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Set the button's border radius
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.save,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                title: Text(AppLocalizations.of(context)!.invalidDate),
                content: Text(AppLocalizations.of(context)!.invalidDateA,
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(AppLocalizations.of(context)!.ok,),
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