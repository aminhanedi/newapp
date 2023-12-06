import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import '../../../repository/authentecation_repository/authentecation_repository.dart';


class SignUpController extends GetxController{
static SignUpController get instance => Get.find();

//text-field controller to get data from text-field
final email= TextEditingController();
final password= TextEditingController();
final fullName= TextEditingController();
final phoneNo= TextEditingController();
  //call this function from the controller it will do the rest
void registerUser (String email, String password){
  AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);

}
}