class TExceptions implements Exception{
  final String message;
  const TExceptions([this.message='An unknown exception occured']);

  factory TExceptions.fromCode(String code){
    switch(code){
      case 'email-already-in-use':
        return TExceptions('Email already exists.');
      case 'Invaild-email':
        return TExceptions('Email is not valid or badly formatted');
      case 'weak-password':
        return TExceptions('Please enter a stronger password');
      case 'user-disabled':
        return TExceptions('This user has been disabled .Please contact support for help');
      case 'user-not-found':
        return TExceptions('Invaild Details,Please create an account');
      case 'wrong-password':
        return TExceptions('Incorrect password, please try again');
      case 'too-many-requests':
        return TExceptions('Too many request ,Service Temporarily blocked');
      case 'invaild-argument':
        return TExceptions('An invalid arguments was provided to an Authentication method');
      case 'invaild-password':
        return TExceptions('Tncorrect password, please try again');
      case 'invaild-phone-number':
        return TExceptions('the provided Phone number is invaild');
      case 'operation-not-allowed':
        return TExceptions('The provided sign-in provided Firebase session cookie is expired');
        default:
          return TExceptions();
    }
  }
}