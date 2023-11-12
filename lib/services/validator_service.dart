
class FormValidator {

  //
  static String? validateName(String ?value) {
    if(value!.isEmpty){
      return 'Name is required';
    }
    return null;
  }

  //For email address form validation
  static String? validatePhone(String ?value) {
    if(value!.isEmpty){
      return 'Field is required';
    }
    else if(value.length!=10){
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? validateEmail(String ?value) {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
    if(value.isEmpty){
      return 'Field is required';
    }
    if(!emailValid){
      return 'Enter a valid email';
    }
    return null;
  }



  //For email address form validation
  static String? validatePassword(String ?value) {
    if (value!.isEmpty || value.trim().isEmpty){
      return 'Field is required';
    }
    else if(value.length < 6) {
      return 'Password must be atleast 6 characters long';
    }
    return null;
  }

  //
  static String? confirmPassword(String ?password,String ?confirmPassword) {
    if(confirmPassword!.isEmpty){
      return 'Field is required';
    }
    else if(password!=confirmPassword) {
      return 'Passwords must match';
    }
    return null;
  }

}
