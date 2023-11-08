import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gocart/app/respository/authentication_respositary/exception/signup_email_password_failure.dart';
import 'package:gocart/app/screens/bottom_navigation/base.dart';

import '../../screens/authentication/login/login_screen.dart';

class AuthenticationRespository extends GetxController{
  static AuthenticationRespository get instance => Get.find();

  final _auth=FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

@override
  void onReady() {
    // TODO: implement onReady
    firebaseUser =Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, (callback) => _setInitialScreen);

  }
  _setInitialScreen(User? user){
  user ==null ? Get.offAll(() => login()) : Get.offAll(base());
  }

  Future<String?> createUserWithEmailAndPassword(String email,String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value !=null ?Get.offAll(()=>base()) : Get.to(()=> login());
    } on FirebaseAuthException catch (e) {
      final ex = SignupWithEmailAndPasswordFailure.code(e.code);
      return ex.message;
    }catch(_){
      final ex = SignupWithEmailAndPasswordFailure();
      return ex.message;
    }
  }


  Future<void> loginWithEmailAndPassword(String email,String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {

    }catch(_){}
  }
  Future<void> logout() async=> await _auth.signOut();
}