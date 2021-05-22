import 'package:university_transportation_driver/modules/models/login_model.dart';
import 'package:university_transportation_driver/modules/models/login_model_web.dart';

abstract class LoginService {
  Future<LoginModelWeb> loginPostAsync(LoginModel model);
}
