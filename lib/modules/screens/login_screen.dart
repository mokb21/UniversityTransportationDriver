import 'package:flutter/material.dart';
import 'package:university_transportation_driver/constants/routing_constants.dart';
import 'package:university_transportation_driver/modules/models/login_model.dart';
import 'package:university_transportation_driver/utils/preferences/shared_preferences_helper.dart';
import 'package:university_transportation_driver/utils/services/login/login_service.dart';
import 'package:university_transportation_driver/utils/services/login/login_service_web.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final LoginService _loginService = new LoginServiceWeb();
  LoginModel _model = new LoginModel();

  Future<void> _loginPressed() async {
    _formKey.currentState.save();
    FocusScope.of(context).unfocus();

    var loggedInModel = await _loginService.loginPostAsync(_model);
    if (loggedInModel != null && loggedInModel.token.status == 'Success') {
      await SharedPreferencesHelper.setIsLoggedIn(true);
      await SharedPreferencesHelper.setApiToken(loggedInModel.token.token);
      await SharedPreferencesHelper.setCurrentUser(loggedInModel);

      Navigator.pushReplacementNamed(context, RoutingConstants.HomeScreenRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 150,
                    // child: Image.asset('asset/images/flutter-logo.png'),
                    child: Text('Hello'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'User Name',
                  ),
                  onSaved: (String value) {
                    setState(() {
                      _model.userName = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (String value) {
                    setState(() {
                      _model.password = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  // onPressed: () {
                  // },
                  onPressed: _loginPressed,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
