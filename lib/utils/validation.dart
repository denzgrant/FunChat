String validatePassword(String value) {
  Pattern pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = new RegExp(pattern);
  print(value);
  if (value.isEmpty || value.length < 6) {
    return 'Please enter password';
  } else {
    if (!regex.hasMatch(value))
      return 'Enter valid password';
    else
      return null;
  }
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  print(value);
  if (value.isEmpty) {
    return 'Please enter email';
  } else {
    if (!regex.hasMatch(value))
      return 'Enter valid email';
    else
      return null;
  }
}
