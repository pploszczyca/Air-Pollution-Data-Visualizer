enum ButtonState { enabled, disabled }

enum FormType { signin, signup }

bool checkPasswordRegex(String text) {
  const String pattern = r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{1,}$';
  final RegExp regex = RegExp(pattern);
  return regex.hasMatch(text);
}

bool checkEmailRegex(String text) {
  const String pattern =
      r'^(?=.{1,64}@)[A-Za-z0-9_-]+(.[A-Za-z0-9_-]+)*@[^-][A-Za-z0-9-]+(.[A-Za-z0-9-]+)*(.[A-Za-z]{2,})$';
  final RegExp regex = RegExp(pattern);
  return regex.hasMatch(text);
}

class AuthenticateForm {
  String email;
  String password;
  FormType formType;

  AuthenticateForm(this.email, this.password, this.formType);
}
