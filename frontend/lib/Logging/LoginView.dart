import 'package:adpv_frontend/Logging/utils.dart';
import 'package:flutter/material.dart';

const Color loginPagePrimaryColor = Color.fromRGBO(176, 57, 186, 1);
ColorScheme loginPageTheme =
    ThemeData().colorScheme.copyWith(primary: loginPagePrimaryColor);

const backgroundDecor = BoxDecoration(color: Colors.white);


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  FormType _formType = FormType.signin;
  late TabController _tabController;

  final TextEditingController _emailLoginController = TextEditingController();
  final TextEditingController _passwordLoginController = TextEditingController();
  final TextEditingController _emailCreateController = TextEditingController();
  final TextEditingController _passwordCreateController =
      TextEditingController();

  ButtonState _loginButtonState = ButtonState.disabled;
  ButtonState _createButtonState = ButtonState.disabled;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _formType = FormType.values[_tabController.index];
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void enableSubmitButton(ButtonState buttonState) {
    setState(() {
      if (_formType == FormType.signin) {
        _loginButtonState = buttonState;
      } else if (_formType == FormType.signup) {
        _createButtonState = buttonState;
      }
    });
  }

  void _listenForLoginInput() {
    if (_emailLoginController.text.isNotEmpty &&
        _passwordLoginController.text.isNotEmpty &&
        checkEmailRegex(_emailLoginController.text)) {
      enableSubmitButton(ButtonState.enabled);
    } else {
      enableSubmitButton(ButtonState.disabled);
    }
  }

  void _listenForCreateInput() {
    if (_emailCreateController.text.isNotEmpty &&
        _passwordCreateController.text.isNotEmpty &&
        checkEmailRegex(_emailCreateController.text) &&
        checkPasswordRegex(_passwordCreateController.text)) {
      enableSubmitButton(ButtonState.enabled);
    } else {
      enableSubmitButton(ButtonState.disabled);
    }
  }

  _LoginViewState() {
    _emailLoginController.addListener(_listenForLoginInput);
    _passwordLoginController.addListener(_listenForLoginInput);
    _emailCreateController.addListener(_listenForCreateInput);
    _passwordCreateController.addListener(_listenForCreateInput);
  }

  void onSubmitButton() {
    AuthenticateForm form = AuthenticateForm(
        _emailLoginController.text,
        _passwordLoginController.text,
        _formType);
  }

  Container _buildAppBar() => Container(
        height: 200,
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: const BoxDecoration(color: Colors.transparent),
        child: const Text('AIR POLLUTION APP',
            style: TextStyle(
                fontFamily: 'SofiaSans', fontSize: 55, color: Colors.white)),
      );

  TabBar _buildTabBar() => TabBar(
    indicatorColor: loginPagePrimaryColor,
    indicatorWeight: 5,
    controller: _tabController,
    tabs: const [
      Tab(
        child: Text(
          'Sign in',
          style: TextStyle(fontFamily: 'Ubuntu Condensed', fontSize: 20),
        ),
      ),
      Tab(
        child: Text(
          'Sign up',
          style: TextStyle(fontFamily: 'Ubuntu Condensed', fontSize: 20),
        ),
      ),
    ],
  );

  Expanded _buildExpandedTabs() => Expanded(
      flex: 1,
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildInputFormPanel('WELCOME AGAIN', 'LOG IN', _loginButtonState,
              _emailLoginController, _passwordLoginController, FormType.signin),
          _buildInputFormPanel('HI NEW USER', 'CREATE', _createButtonState,
              _emailCreateController, _passwordCreateController, FormType.signup),
        ],
      ));

  Container _buildInputFormPanel(
      String welcomeText,
      String buttonText,
      ButtonState buttonState,
      TextEditingController emailController,
      TextEditingController passwordController,
      FormType type) =>
      Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: ListView(
            children: <Widget>[
              _buildWelcomeBanner(welcomeText),
              _buildEmailInput(emailController),
              _buildPasswordInput(passwordController),
              type == FormType.signup
                  ? _buildPasswordSupportText()
                  : const SizedBox.shrink(),
              _buildSubmitButton(buttonText, buttonState),
            ],
          ));

  Container _buildWelcomeBanner(String text) => Container(
      height: 60,
      decoration: backgroundDecor,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 0),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 25,
            fontFamily: 'Ubuntu Condensed',
            color: loginPagePrimaryColor,
            letterSpacing: 4),
      ));

  Container _buildEmailInput(TextEditingController controller) => Container(
      decoration: backgroundDecor,
      alignment: Alignment.center,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.1 - 10,
          right: MediaQuery.of(context).size.width * 0.1 - 10,
          top: 40,
          bottom: 25),
      child: Theme(
        data: Theme.of(context).copyWith(colorScheme: loginPageTheme),
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 2.5, color: loginPagePrimaryColor)),
            labelText: 'Email',
            labelStyle: TextStyle(
              fontSize: 22,
            ),
            suffixIcon: Icon(Icons.mail),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide(width: 2)),
          ),
          autofocus: true,
        ),
      ));

  Container _buildPasswordInput(TextEditingController controller) => Container(
      decoration: backgroundDecor,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.1 - 10,
          right: MediaQuery.of(context).size.width * 0.1 - 10,
          top: 20,
          bottom: 25),
      child: Theme(
        data: Theme.of(context).copyWith(colorScheme: loginPageTheme),
        child: TextField(
          controller: controller,
          obscureText: true,
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 2.5, color: loginPagePrimaryColor)),
            labelText: 'Password',
            labelStyle: TextStyle(
              fontSize: 22,
            ),
            suffixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide(width: 2)),
          ),
          autofocus: true,
        ),
      ));

  Container _buildPasswordSupportText() => Container(
      decoration: backgroundDecor,
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
      alignment: Alignment.center,
      child: Text(
        'Your password needs to contain: at least one digit, at least one upper case and lower case letter',
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'Ubuntu Condensed',
          color: checkPasswordRegex(_passwordCreateController.text)
              ? Colors.green
              : Colors.red,
        ),
      ));

  Container _buildSubmitButton(String text, ButtonState state) => Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      height: 90,
      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.2, 20,
          MediaQuery.of(context).size.width * 0.2, 30),
      child: Container(
        decoration: BoxDecoration(
          gradient: state == ButtonState.enabled
              ? const LinearGradient(colors: [
                  Color.fromRGBO(71, 118, 230, 1),
                  Color.fromRGBO(142, 84, 233, 1)
                ])
              : const LinearGradient(colors: [
                  Color.fromRGBO(71, 118, 230, 0.2),
                  Color.fromRGBO(142, 84, 233, 0.2)
                ]),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ElevatedButton(
          onPressed: (state == ButtonState.disabled) ? null : onSubmitButton,
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: Text(
            text,
            style: const TextStyle(
                fontFamily: 'Ubuntu Condensed',
                fontSize: 25,
                color: Colors.white),
          ),
        ),
      ));

  @override
  Widget build(BuildContext context) => Scaffold(
      body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                    Color.fromRGBO(21, 184, 194, 1),
                    Color.fromRGBO(14, 14, 82, 0.9)
                  ])),
              child: ListView(children: [
                _buildAppBar(),
                Container(
                  width: 300,
                  height: 550,
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    top: 20,
                    right: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Column(children: <Widget>[
                        _buildTabBar(),
                        _buildExpandedTabs()
                      ]),
                    ),
                  ),
                )
              ]))));
}
