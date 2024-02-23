
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../constants/text_string.dart';


class total_screen extends StatefulWidget {
  const total_screen({Key? key,required this.customerskey}):super(key: key);

  final String customerskey;





  @override
  State<total_screen> createState() => _upddate_recordState();
}

class _upddate_recordState extends State<total_screen> {
  final RegExp numberRegex = RegExp(r'^[0-9]+$');
  int? _selectedNumber;



  int get selectedNumber =>
      _selectedNumber ?? 0; // Define the selectedNumber getter

  set selectedNumber(int value) {
    setState(() {
      _selectedNumber = value;
    });
  }

  TextEditingController _customeridController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _firstPayController = TextEditingController();
  TextEditingController _totalPayController = TextEditingController();
  TextEditingController _clothAmountController = TextEditingController();

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
      _clothAmountController.text = customers['customerAmount'] ?? '';
      _orderController.text = customers['customerOrder'] ?? '';
      _deliveryController.text = customers['customerDelivery'] ?? '';
      _chestController.text = customers['customerChest'] ?? '';
      _waistController.text = customers['customerWaist'] ?? '';
      _shoulderController.text = customers['customerShoulder'] ?? '';
      _hipController.text = customers['customerHip'] ?? '';
      _inseamController.text = customers['customerInseam'] ?? '';
      _neckController.text = customers['customerNeck'] ?? '';
      _sleeveController.text = customers['customerSleeve'] ?? '';
      _frontController.text = customers['customerFront'] ?? '';
      _thighController.text = customers['customerThigh'] ?? '';
      _kneeController.text = customers['customerKnee'] ?? '';
      _pantslController.text = customers['customerPants'] ?? '';
      _lengthController.text = customers['customerLength'] ?? '';
      _other1Controller.text = customers['customerOther1'] ?? '';
      _other2Controller.text = customers['customerOther2'] ?? '';
      _other3Controller.text = customers['customerOther3'] ?? '';
      _noteController.text = customers['customerNote'] ?? '';
      _firstPayController.text = customers['firstAmount'] ?? '';
      _totalPayController.text = customers['totalAmount'] ?? '';
      _clothAmountController.text = customers['clothAmount'] ?? '';
      String selectedNumber = customers['totalQuantity'] ?? '';
      _selectedNumber = int.tryParse(selectedNumber) ?? 0;


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

          child: SingleChildScrollView(
            child: Column(
              children:[


                /////////////////////////////////////header//////////////////////////////////////////////////////
                Container(height: 20,),

                /////////////////////////////////////header//////////////////////////////////////////////////////
                SizedBox(

                  width: double.infinity,
                  child: TextFormField(
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
                ),


                Gap(5),
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    readOnly: true,
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
                        labelText: AppLocalizations.of(context)!.firstPay,
                        labelStyle: TextStyle(fontSize: 15),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  SizedBox(
                    width:100,
                    child: DropdownButtonFormField<int>(
                      value: _selectedNumber,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedNumber = value!;
                        });
                      },

                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.quantity,
                        labelStyle: TextStyle(fontSize: 18),
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
                  SizedBox(width: 10,),
                  SizedBox(
                    width:120,
                    child: TextFormField(
                      controller: _totalPayController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            numberRegex), // Only allows input that matches the regular expression
                      ],
                      keyboardType: TextInputType.phone,
                      maxLength: 7,
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
                ],),

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
