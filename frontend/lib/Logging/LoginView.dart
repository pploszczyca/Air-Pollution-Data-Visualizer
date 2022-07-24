import 'package:adpv_frontend/Common/Common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Common/TitledLineChart.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('AIR POLLUTION APP'),
          titleTextStyle: TextStyle(
              fontFamily: 'SofiaSans', fontSize: 55, color: Colors.white),
          titleSpacing: 100.0,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  Color.fromRGBO(21, 184, 194, 1),
                  Color.fromRGBO(14, 14, 82, 0.9)
                ])),
            child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    top: 120.0,
                    right: MediaQuery.of(context).size.width * 0.1,
                    bottom: 10.0),
                child: Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: ListView(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(
                                top: 0.0, left: 20.0, right: 20.0, bottom: 20.0),
                            child: const Text(
                              'WELCOME AGAIN',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Ubuntu Condensed',
                                  color: Color.fromRGBO(176, 57, 186, 1.0),
                                  letterSpacing: 4),
                            )),
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6.0)),
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(176, 57, 186, 1.0),
                                        width: 1.1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6.0)),
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromRGBO(176, 57, 186, 1.0),
                                        width: 1.1)),
                                label: Text('Username',
                                    textAlign: TextAlign.center),
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(176, 57, 186, 1.0))),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                                    borderSide: BorderSide(
                                        color:
                                        Color.fromRGBO(176, 57, 186, 1.0),
                                        width: 1.1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                                    borderSide: BorderSide(
                                        color:
                                        Color.fromRGBO(176, 57, 186, 1.0),
                                        width: 1.1)),
                                label: Text('Password',
                                    textAlign: TextAlign.center),
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(176, 57, 186, 1.0))),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                            child: ElevatedButton(
                              style:
                              ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20, fontFamily: 'Ubuntu Condensed'),
                                primary: Colors.purple,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),),
                              child: const Text('Login'),
                              onPressed: () {
                              },
                            )),
                        Row(
                          children: <Widget>[
                            TextButton(
                              child: const Text(
                                'Sign in',
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                //signup screen
                              },
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ],
                    )))));
  }
}
