import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app-localization.dart';
import 'package:newapp/src/constants/text_string.dart';

class MeasurementForm extends StatefulWidget {
  @override
  _MeasurementFormState createState() => _MeasurementFormState();
}

class _MeasurementFormState extends State<MeasurementForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _customeridController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
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
    // TODO: implement initState
    super.initState();
    dbref= FirebaseDatabase.instance.ref().child("customer");

  }



  @override
  void dispose() {
    _customeridController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _amountController.dispose();
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



  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form fields are valid, perform desired actions
      String name = _nameController.text;
      double shoulder = double.parse(_shoulderController.text);
      double chest = double.parse(_chestController.text);
      double waist = double.parse(_waistController.text);
      double hip = double.parse(_hipController.text);
      double inseam = double.parse(_inseamController.text);

      // Process the data or navigate to the next screen
      // ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          thome,
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
                  child: Container(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        strokeAlign:
                            BorderSide.strokeAlignOutside, // Border color
                        width: 1.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(9.9), // Border radius
                    ),
                    child: Text(AppLocalizations.of(context)!.customer,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 25, color: Colors.black54),
                    ),
                  ),
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
                      }if(tcustomerId==_customeridController){
                        return "data is already in database";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText:AppLocalizations.of(context)!.customerId,
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
                      labelText:AppLocalizations.of(context)!.customerName,
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
                    decoration:  InputDecoration(
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
                    controller: _amountController,
                    keyboardType: TextInputType.phone,
                    maxLength: 15,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.requiredField;
                      }
                      if(value! == "a-z,A-z,-"){
                        return tvalide;
                      }
                      return null;
                    },
                    decoration:  InputDecoration(
                      labelText:AppLocalizations.of(context)!.customerAmount,
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
                        decoration:  InputDecoration(
                          filled: true,
                          prefixIcon: Icon(Icons.calendar_today,
                          color:Colors.blue,),
                          labelText: AppLocalizations.of(context)!.orderDate,
                          labelStyle: TextStyle(fontSize: 15),
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        onTap: (){

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
                          prefixIcon: Icon(Icons.calendar_today,color:  Colors.blue,),
                          labelText: AppLocalizations.of(context)!.deliveryDate,
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        onTap: (){
                          _selectDateDelivery(context);
                        },
                      ),
                    ),
                  ],
                ),
                Gap(20),
                /////////////////////////////////////////////////////main /////////////////////////////////////////////

                Container(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                      strokeAlign:
                          BorderSide.strokeAlignOutside, // Border color
                      width: 1.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(9.9), // Border radius
                  ),
                  child: Text(
                      AppLocalizations.of(context)!.customerMeasurement,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54),
                  ),
                ),
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
                                maxLength: 4,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.requiredField;
                                  }

                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText:AppLocalizations.of(context)!.shoulder,
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
                                maxLength: 4,
                                  controller: _hipController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.requiredField;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                    labelText:AppLocalizations.of(context)!.chest,
                                    border: OutlineInputBorder()),

                            ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                controller: _shoulderController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.requiredField;
                                  }

                                  return null;
                                },
                                maxLength: 4,
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                  labelText: AppLocalizations.of(context)!.skirt,
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
                                 controller: _inseamController,
                                maxLength: 4,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.requiredField;
                                  }

                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                    labelText: AppLocalizations.of(context)!.sleeve,
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                controller: _chestController,
                                maxLength: 4,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.requiredField;
                                  }
                                  if (double.tryParse(value) == null) {
                                    return tvalide;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                  labelText: AppLocalizations.of(context)!.length,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(width:10 ,),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                controller: _neckController,
                                maxLength: 4,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.requiredField;
                                  }


                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText:AppLocalizations.of(context)!.collar,
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
                                maxLength: 4,
                                controller: _sleeveController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.requiredField;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration:InputDecoration(
                                    labelText: AppLocalizations.of(context)!.button,
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                controller: _frontController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.requiredField;
                                  }
                                  return null;
                                },
                                maxLength: 4,
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                  labelText: AppLocalizations.of(context)!.hip,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(width:10 ,),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                controller: _thighController,
                                maxLength: 4,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.requiredField;
                                  }

                                },
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                  labelText: AppLocalizations.of(context)!.inseam,
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
                                maxLength: 4,
                                 controller: _kneeController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.requiredField;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                    labelText:AppLocalizations.of(context)!.knee,
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                controller: _pantslController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.requiredField;
                                  }

                                  return null;
                                },
                                maxLength: 4,
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                  labelText: AppLocalizations.of(context)!.thigh,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                 controller: _lengthController,
                                maxLength: 6,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!.requiredField;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                  labelText: AppLocalizations.of(context)!.waist,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(width:10 ,),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                maxLength: 4,
                                controller: _other1Controller,
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                    labelText:AppLocalizations.of(context)!.other1,
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),

                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                controller: _other2Controller,
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                  labelText: AppLocalizations.of(context)!.other2,
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(width:10 ,),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                controller: _other3Controller,
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                decoration:  InputDecoration(
                                  labelText: AppLocalizations.of(context)!.other3,
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
                  margin:   EdgeInsets.only(left: 15,right: 15,top: 15),


                  color: Colors.white38,
                  width: double.infinity,
                  child: TextFormField(
                    maxLines: 4,

                     controller: _noteController,

                    decoration:  InputDecoration(
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
                      border: OutlineInputBorder()

                    ),

                  ),
                ),
                Gap(15),
                Container(
                    margin: EdgeInsets.all(15),
                  padding: EdgeInsets.only(bottom:0),
                    width: double.infinity,
                    child:ElevatedButton(
                      onPressed: () {
                        _submitForm();
                        Map<String, String> customer = {
                          // Your customer data here
                          "customerID":_customeridController.text,
                          "customerName":_nameController.text,
                          "customerPhone":_phoneController.text,
                          "customerAmount":_amountController.text,
                          "customerOrder":_orderController.text,
                          "customerDelivery":_deliveryController.text,
                          "customerChest":_chestController.text,
                          "customerWaist":_waistController.text,
                          "customerShoulder":_shoulderController.text,
                          "customerHip":_hipController.text,
                          "customerInseam":_inseamController.text,
                          "customerNeck":_neckController.text,
                          "customerSleeve":_sleeveController.text,
                          "customerFront":_frontController.text,
                          "customerThigh":_thighController.text,
                          "customerKnee":_kneeController.text,
                          "customerPants":_pantslController.text,
                          "customerLength":_lengthController.text,
                          "customerNote":_noteController.text,
                          "customerOther1":_other1Controller.text,
                          "customerOther2":_other2Controller.text,
                          "customerOther3":_other3Controller.text,
                        };

                        String customerID = _customeridController.text;


                        dbref
                            .orderByChild("customerID")
                            .equalTo(customerID)
                            .once()
                            .then((DatabaseEvent event) {
                          DataSnapshot snapshot = event.snapshot;
                          if (snapshot.value != null) {
                            // Data already exists, handle the duplicate case
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.white,
                                  content: Text("data already exist ",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color:Colors.red,backgroundColor: Colors.white,),),
                                ));
                          } else {
                            // Data does not exist, push the new data
                            dbref.push().set(customer);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.white,
                                  content: Text(" 'Data saved successfully';",textAlign: TextAlign.center,style: TextStyle(fontSize: 15,color:Colors.green,backgroundColor: Colors.white,),),
                                ));
                          }
                        })
                            .catchError((error) {
                          // Handle any err  ors that occur
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.white,
                                content: Text("Error happened : ",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,color:Colors.green,backgroundColor: Colors.white,),),
                              ));
                        });
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
                    ),),
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
      setState(() {
        _deliveryController.text = formattedDate;
      });
    }
  }

}

