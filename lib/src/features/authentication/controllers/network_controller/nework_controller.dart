
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class NetworkController extends GetxController{
  final Connectivity _connectivity=Connectivity();
  @override
  void onInit(){
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
  void _updateConnectionStatus(ConnectivityResult connectivityResult){
    if (connectivityResult==ConnectivityResult.none){
      Get.rawSnackbar(
        messageText: Text("PLEASE CONNECT TO THE INTERNET",style:TextStyle(
          color: Colors.white,
          fontSize: 14
        )),
        isDismissible: false,
        duration:Duration(days: 1),
        backgroundColor:Colors.red,
        icon: Icon(Icons.wifi_off,color:Colors.white,size: 34,),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED,
      );
    }else{
      if(Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
      }
    }
  }
}