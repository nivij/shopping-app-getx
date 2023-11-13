import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gocart/app/respository/authentication_respositary/exception/signup_email_password_failure.dart';
import 'package:gocart/app/screens/authentication/login/login_screen.dart';
import 'package:gocart/app/screens/bottom_navigation/base.dart';

import '../../routes/app_pages.dart';
import 'exception/login_exception.dart';

class AuthenticationRespository extends GetxController {
  static AuthenticationRespository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    try {
      firebaseUser = Rx<User?>(_auth.currentUser);
      firebaseUser.bindStream(_auth.userChanges());
      ever(firebaseUser, (callback) => _setInitialScreen(firebaseUser.value));
    } catch (e, stacktrace) {
      print("Error in onReady: $e");
      print(stacktrace);
    }
  }

  _setInitialScreen(User? user) {
    try {
      if (user == null) {
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.offAllNamed(Routes.BASE);
      }
    } catch (e, stacktrace) {
      print("Error in _setInitialScreen: $e");
      print(stacktrace);
    }
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => base()) : Get.to(() => login());
    } on FirebaseAuthException catch (e) {
      final ex = SignupWithEmailAndPasswordFailure.code(e.code);
      print("FIRBASE AUTH EXCEPTION - ${ex.message}");
      throw ex;
    } catch (_) {
      final ex = SignupWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = LoginWithEmailAndPasswordFailure.code(e.code);
      print("FIRBASE AUTH EXCEPTION - ${ex.message}");
      throw ex;
    } catch (_) {
      final ex = LoginWithEmailAndPasswordFailure();
      print('EXCEPTION - ${ex.message}');
      throw ex;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      _setInitialScreen(_auth.currentUser);
      // Get.offAllNamed(Routes.LOGIN);
      print("Logout successful");
    } catch (e) {
      print("Error during logout: $e");
    }
  }
}
