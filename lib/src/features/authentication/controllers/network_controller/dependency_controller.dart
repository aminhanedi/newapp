import 'package:get/get.dart';
import 'package:newapp/src/features/authentication/controllers/network_controller/nework_controller.dart';

class DependencyInjection{
  static void init(){
    Get.put<NetworkController>(NetworkController(),permanent: true);
  }

}