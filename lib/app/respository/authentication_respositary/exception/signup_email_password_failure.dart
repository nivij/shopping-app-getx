class SignupWithEmailAndPasswordFailure{
  final String message;
  SignupWithEmailAndPasswordFailure([this.message ="Am unknown error occured."]);

factory SignupWithEmailAndPasswordFailure.code(String code){
  switch(code){
    case 'weak-password':return SignupWithEmailAndPasswordFailure('Please enter a stronger password');
    case 'Invaild -email':return SignupWithEmailAndPasswordFailure('Email is not vaild or badly formatted');
    case 'email-already-in-use':return SignupWithEmailAndPasswordFailure('An account already exists for that email');
    case 'operation-not-allowed':return SignupWithEmailAndPasswordFailure('Operation is not allowed. Please contact support');
    case 'user-disabled':return SignupWithEmailAndPasswordFailure('This user has been disabled .Please Contact support for help');
    default: return SignupWithEmailAndPasswordFailure();
  }
}

}