import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:newapp/src/features/authentication/screens/welcome/welcome_screen.dart';
import '../../features/authentication/screens/dashboard_screen/dashboard_screen.dart';
import 'exceptions/signup_email_password_failure.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());

    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => Welcome())
        : Get.offAll(() => const dashboard());
  }
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      firebaseUser.value !=null?
      Get.offAll(() => const dashboard())
          : Get.to(() => Welcome());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);

      print('FIREBASE AUTH EXCEPTION${ex.message}');

      throw ex;
    }catch(_){
      const ex= SignUpWithEmailAndPasswordFailure();
      print("Exception-${ex.message}");
      throw ex;
    }
  }
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
    } catch (_) {
      // Handle other exceptions
    }
  }

  Future<void> logout() async => await _auth.signOut();
}
