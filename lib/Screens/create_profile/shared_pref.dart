import 'package:shared_preferences/shared_preferences.dart';

/* 
don't forget to add shared_preferences to pubspec.yaml before following along
*/
void upDateSharedPreferences(String token, int id) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString('token', token);
  _prefs.setInt('id', id);
}
