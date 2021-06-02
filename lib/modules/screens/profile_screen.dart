import 'package:flutter/material.dart';
import 'package:university_transportation_driver/constants/routing_constants.dart';
import 'package:university_transportation_driver/modules/models/login_model_web.dart';
import 'package:university_transportation_driver/utils/preferences/shared_preferences_helper.dart';
import 'package:university_transportation_driver/widgets/loader.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  LoginModelWeb _loginModel = LoginModelWeb(
    user: User(
      id: '',
      userName: '',
      email: '',
      phone: '',
    ),
  );

  bool _isLoading = false;

  initWidgetProperties() async {
    // setState(() {
    //   _isLoading = true;
    // });

    var loginModel = await SharedPreferencesHelper.getCurrentUser();

    setState(() {
      _loginModel = loginModel;
      // _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initWidgetProperties();
  }

  void _logout() async {
    var isCleard = await SharedPreferencesHelper.clearAllPreferences();
    if (isCleard) {
      Navigator.pushReplacementNamed(
          context, RoutingConstants.LoginScreenRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Card(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 5.0,
                  right: 5.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.0),
                    Text(
                      _loginModel.user.userName,
                      style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.blue,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(_loginModel.user.email),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(_loginModel.user.phone),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(
                        Icons.info_outline,
                        color: Colors.blue,
                        size: 25.0,
                      ),
                      title: Text('About'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: Colors.blue,
                        size: 25.0,
                      ),
                      title: Text('Logout'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: _logout,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        _isLoading ? Loader() : Stack(),
      ],
    );
  }
}
