import 'package:flutter/material.dart';
import 'package:sportition_client/page/common/alert_component.dart';
import 'package:sportition_client/page/login/component/login_background.dart';
import 'package:sportition_client/page/login/component/login_box.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _loginBoxOffset = 310.0;
  String alertMessage = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _loginBoxOffset = 0.0;
        });
      });
    });
  }

  void setErrorMessage(String message) {
    setState(() {
      alertMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              /* Background */
              const Expanded(
                child: LoginBackground(),
              ),

              /* Login Box */
              LoginBox(
                  loginBoxOffset: _loginBoxOffset,
                  setErrorMessage: setErrorMessage),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AlertComponent(message: alertMessage),
          ),
        ],
      ),
    );
  }
}
