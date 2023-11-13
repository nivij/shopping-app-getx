class LoginWithEmailAndPasswordFailure{
  final String message;
  LoginWithEmailAndPasswordFailure([this.message ="Am unknown error occured."]);

  factory LoginWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'weak-password':return LoginWithEmailAndPasswordFailure('Please enter a stronger password');
      case 'Invaild -email':return LoginWithEmailAndPasswordFailure('Email is not vaild or badly formatted');
      case 'email-already-in-use':return LoginWithEmailAndPasswordFailure('An account already exists for that email');
      case 'operation-not-allowed':return LoginWithEmailAndPasswordFailure('Operation is not allowed. Please contact support');
      case 'user-disabled':return LoginWithEmailAndPasswordFailure('This user has been disabled .Please Contact support for help');
      default: return LoginWithEmailAndPasswordFailure();
    }
  }

}