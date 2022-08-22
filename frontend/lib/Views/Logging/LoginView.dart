import 'package:adpv_frontend/App.dart';
import 'package:adpv_frontend/Views/Logging/utils.dart';
import 'package:flutter/material.dart';

import '../../Repository/EndpointRepository/EndpointGateway.dart';
import '../../Repository/UserRepository/AuthGateway.dart';
import '../../Repository/UserRepository/UserGateway.dart';

const Color loginPagePrimaryColor = Color.fromRGBO(176, 57, 186, 1);
ColorScheme loginPageTheme =
    ThemeData().colorScheme.copyWith(primary: loginPagePrimaryColor);

const backgroundDecor = BoxDecoration(color: Colors.white);

const roundedBox = BorderRadius.only(
  topLeft: Radius.circular(0),
  topRight: Radius.circular(0),
  bottomLeft: Radius.circular(10),
  bottomRight: Radius.circular(10),
);

const inputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(6),
  ),
  borderSide: BorderSide(width: 2),
);

const focusedInputBorder = OutlineInputBorder(
  borderSide: BorderSide(width: 2.5, color: loginPagePrimaryColor),
);

class LoginView extends StatefulWidget {
  final UserGateway userGateway;

  const LoginView({required this.userGateway, Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  AuthFormType _formType = AuthFormType.signin;
  late TabController _tabController;

  final TextEditingController _emailLoginController = TextEditingController();
  final TextEditingController _passwordLoginController =
      TextEditingController();
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
        _formType = AuthFormType.values[_tabController.index];
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _LoginViewState() {
    _emailLoginController.addListener(_listenForLoginInput);
    _passwordLoginController.addListener(_listenForLoginInput);
    _emailCreateController.addListener(_listenForCreateInput);
    _passwordCreateController.addListener(_listenForCreateInput);
  }

  void _listenForLoginInput() {
    if (_emailLoginController.text.isNotEmpty &&
        _passwordLoginController.text.isNotEmpty) {
      _enableSubmitButton(ButtonState.enabled);
    } else {
      _enableSubmitButton(ButtonState.disabled);
    }
  }

  void _listenForCreateInput() {
    if (checkEmailRegex(_emailCreateController.text) &&
        checkPasswordRegex(_passwordCreateController.text)) {
      _enableSubmitButton(ButtonState.enabled);
    } else {
      _enableSubmitButton(ButtonState.disabled);
    }
  }

  void _enableSubmitButton(ButtonState buttonState) {
    setState(() {
      _formType == AuthFormType.signin
          ? _loginButtonState = buttonState
          : _createButtonState = buttonState;
    });
  }

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
                  ]),
            ),
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
                    body: Builder(
                      builder: (buildContext) => Column(children: <Widget>[
                        _buildTabBar(),
                        _buildExpandedTabs(buildContext)
                      ]),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      );

  Container _buildAppBar() => Container(
        height: 200,
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: const BoxDecoration(color: Colors.transparent),
        child: const Text(
          'AIR POLLUTION APP',
          style: TextStyle(
              fontFamily: 'SofiaSans', fontSize: 55, color: Colors.white),
        ),
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

  Expanded _buildExpandedTabs(BuildContext context) => Expanded(
        flex: 1,
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildInputFormPanel(
                'WELCOME AGAIN',
                'LOG IN',
                _loginButtonState,
                _emailLoginController,
                _passwordLoginController,
                AuthFormType.signin,
                context),
            _buildInputFormPanel(
                'HI NEW USER',
                'CREATE',
                _createButtonState,
                _emailCreateController,
                _passwordCreateController,
                AuthFormType.signup,
                context),
          ],
        ),
      );

  Container _buildInputFormPanel(
          String welcomeText,
          String buttonText,
          ButtonState buttonState,
          TextEditingController emailController,
          TextEditingController passwordController,
          AuthFormType type,
          BuildContext context) =>
      Container(
        decoration: const BoxDecoration(borderRadius: roundedBox),
        child: ListView(
          children: <Widget>[
            _buildWelcomeBanner(welcomeText),
            _buildEmailInput(emailController),
            _buildPasswordInput(passwordController),
            type == AuthFormType.signup
                ? _buildPasswordSupportText()
                : const SizedBox.shrink(),
            _buildSubmitButton(buttonText, buttonState, context),
          ],
        ),
      );

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
        ),
      );

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
              focusedBorder: focusedInputBorder,
              labelText: 'Email',
              labelStyle: TextStyle(
                fontSize: 22,
              ),
              suffixIcon: Icon(Icons.mail),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
                borderSide: BorderSide(width: 2),
              ),
            ),
            autofocus: true,
          ),
        ),
      );

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
              focusedBorder: focusedInputBorder,
              labelText: 'Password',
              labelStyle: TextStyle(
                fontSize: 22,
              ),
              suffixIcon: Icon(Icons.lock),
              border: inputBorder,
            ),
            autofocus: true,
          ),
        ),
      );

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
        ),
      );

  Container _buildSubmitButton(
          String text, ButtonState state, BuildContext context) =>
      Container(
        decoration:
            const BoxDecoration(color: Colors.white, borderRadius: roundedBox),
        height: 90,
        padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.2,
            20, MediaQuery.of(context).size.width * 0.2, 30),
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
            onPressed: () => (state == ButtonState.disabled)
                ? null
                : _onSubmitButton(context),
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                  fontFamily: 'Ubuntu Condensed',
                  fontSize: 25,
                  color: Colors.white),
            ),
          ),
        ),
      );

  void _onSubmitButton(context) async {
    AuthenticateForm form;
    if (_formType == AuthFormType.signin) {
      form = AuthenticateForm(_emailLoginController.text,
          _passwordLoginController.text, AuthFormType.signin);
    } else {
      form = AuthenticateForm(_emailCreateController.text,
          _passwordLoginController.text, AuthFormType.signup);
    }
    final AuthResponse response =
        await widget.userGateway.authenticateUser(form);
    if (!response.success) {
      final String message = response.errorMessage ?? 'LOGIN ERROR';
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.red,
                fontFamily: 'Sofia sans',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          elevation: 1,
          duration: const Duration(seconds: 15),
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
        ),
      );
    } else {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => App(
            endpointGateway: EndpointGateway(widget.userGateway),
            userGateway: widget.userGateway,
          ),
        ),
      );
    }
  }
}
