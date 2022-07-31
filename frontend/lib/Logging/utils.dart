
enum ButtonState { enabled, disabled }

enum FormType { signin, signup }

bool checkPasswordRegex(String text) {
  const String pattern = r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{1,}$';
  final RegExp regex = RegExp(pattern);
  return executeRegex(regex, text);
}

bool checkEmailRegex(String text) {
  const String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final RegExp regex = RegExp(pattern);
  return executeRegex(regex, text);
}

bool executeRegex(RegExp regex, String text) {
  if (regex.hasMatch(text)) {
    return true;
  } else {
    return false;
  }
}

class AuthenticateForm{
  String email;
  String password;
  FormType formType;

  AuthenticateForm(
      this.email,
      this.password,
      this.formType
      );
}
