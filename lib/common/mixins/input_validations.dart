class InputValidationsMixin {

  String validateEmail(String data) {
    if(!data.contains('@') && data.length < 6){
      return 'Invalid Email Format';
    }
    return '';
  }

  String validatePassword(String data) {
    if(!RegExp('[A-Z][a-z]0-9*_@\$%#!%^-+', caseSensitive: true).hasMatch(data)){
      return 'Invalid password format';
    }
    return '';
  }

  bool isValidPasswordFormat(String data) {
    if(!RegExp('[A-Z][a-z]0-9*_@\$%#!%^-+', caseSensitive: true).hasMatch(data)){
      return true;
    }
    return false;
  }

}