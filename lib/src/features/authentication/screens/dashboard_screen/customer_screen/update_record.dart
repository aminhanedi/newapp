
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import '../../../../../constants/text_string.dart';


class upddate_record extends StatefulWidget {
  const upddate_record({Key? key,required this.customerskey}):super(key: key);

  final String customerskey;





  @override
  State<upddate_record> createState() => _upddate_recordState();
}

class _upddate_recordState extends State<upddate_record> {
  final RegExp numberRegex = RegExp(r'^[0-9]+$');






  TextEditingController _customeridController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _firstPayController = TextEditingController();
  TextEditingController _totalPayController = TextEditingController();
  TextEditingController _orderController = TextEditingController();
  TextEditingController _deliveryController = TextEditingController();

  late DatabaseReference dbref;

  @override
  void initState() {
    super.initState();
    dbref = FirebaseDatabase.instance.ref().child("customer");
    geCustomerData();
  }

  void geCustomerData() async {
    DataSnapshot snapshot = await dbref.child(widget.customerskey).get();
    if (snapshot.value != null) {
      Map customers = snapshot.value as Map;
      _customeridController.text = customers["customerID"] ?? '';
      _nameController.text = customers["customerName"] ?? '';
      _phoneController.text = customers["customerPhone"] ?? '';
      _orderController.text = customers['customerOrder'] ?? '';
      _deliveryController.text = customers['customerDelivery'] ?? '';
      _firstPayController.text = customers['firstAmount'] ?? '';
      _totalPayController.text = customers['totalAmount'] ?? '';





    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.updateScreen,
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(

        padding: EdgeInsets.all(10.0),
        //-----------------------------------form widget----------------------------//
        child: Form(

          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(height: 20,),
            Column(
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
                Text(AppLocalizations.of(context)!.updateTheCustomer,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700,color: Colors.blueGrey),),
                SizedBox(height: 30),
                TextFormField(
                  readOnly: true,
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
                SizedBox(height: 5),
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
                    labelText: AppLocalizations.of(context)!.customerName,
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 5),
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
                    labelText: AppLocalizations.of(context)!.customerPhone,
                    labelStyle: TextStyle(fontSize: 15),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstPayController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(numberRegex),
                        ],
                        keyboardType: TextInputType.phone,
                        maxLength:9,
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
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _totalPayController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(numberRegex),
                        ],
                        keyboardType: TextInputType.phone,
                        maxLength: 9,
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
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
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
                    SizedBox(width: 10),
                    Expanded(
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
              ],
            ),
                Gap(20),
                Container(
                  color: Colors.blue,
                  height: 2,),
                Gap(20),
              
                ///////////////////////////////////////////////foter/////////////////////////////////////////////////////////////

                Gap(15),
                Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.only(bottom:0),
                  width: double.infinity,
                  child:ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController newAmountController = TextEditingController();
                          double currentTotalAmount = double.parse(_totalPayController.text);
                          double newTotalAmount = currentTotalAmount;
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                title: Text( AppLocalizations.of(context)!.updateA,),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(' ${AppLocalizations.of(context)!.currentA} $currentTotalAmount'),
                                    SizedBox(height: 10),
                                    TextField(
                                      controller: newAmountController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: AppLocalizations.of(context)!.newA,
                                      ),
                                      onChanged: (value) {
                                        double newAmount = double.tryParse(value) ?? 0;
                                        setState(() {
                                          newTotalAmount = currentTotalAmount + newAmount;
                                        });
                                      },
                                    ),
                                    SizedBox(height: 10),
                                    Text( ' ${AppLocalizations.of(context)!.updatedA} $newTotalAmount'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); // Close the dialog
                                    },
                                    child: Text(AppLocalizations.of(context)!.cancel,),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      String newAmount = newAmountController.text;
                                      Map<String, String> customer = {
                                        "customerName": _nameController.text,
                                        "customerPhone": _phoneController.text,
                                        "firstAmount": _firstPayController.text,
                                        "totalAmount": newTotalAmount.toString(),
                                        "customerOrder": _orderController.text,
                                        "customerDelivery": _deliveryController.text,

                                      };

                                      dbref.child(widget.customerskey).update(customer).then((value) {
                                        Navigator.pop(context); // Close the dialog
                                        Navigator.pop(context); // Go back to the customer list
                                      }).catchError((error) {
                                        // Handle any potential errors that occur during the update process
                                        print("Error updating customer: $error");
                                        // You can show an error message to the user or handle the error as needed
                                      });
                                    },
                                    child: Text(AppLocalizations.of(context)!.update,),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Update',
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
