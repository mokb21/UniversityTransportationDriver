import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:university_transportation_driver/constants/api_path.dart';
import 'package:university_transportation_driver/modules/models/login_model_web.dart';
import 'package:university_transportation_driver/modules/models/login_model.dart';
import 'package:university_transportation_driver/utils/services/login/login_service.dart';

class LoginServiceWeb extends LoginService {
  @override
  Future<LoginModelWeb> loginPostAsync(LoginModel model) async {
    try {
      var body = json.encode(model);

      final http.Response response = await http.post(
        Uri.http(ApiPath.DomainPath, '/api/Accounts/Login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final Map parsed = json.decode(response.body);

        return LoginModelWeb.fromJson(parsed);
      }
      return null;

    } on Exception catch (_) {
      throw Exception('Oops Somthing went wrong');
    }
  }
}
