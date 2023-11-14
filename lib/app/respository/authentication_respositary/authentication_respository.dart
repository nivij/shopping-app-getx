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
  var verificationId = ''.obs;

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

  Future<void> phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'the provided phone number is not valid');
        } else {
          Get.snackbar('Error', 'Something went wrong. try again');
        }
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
  var credentials=  await _auth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: this.verificationId.value, smsCode: otp));

  return credentials.user !=null ? true : false;
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => base())
          : Get.to(() => login());
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
