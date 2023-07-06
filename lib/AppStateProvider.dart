import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/DeviceProfileModel.dart';

final appStateProvider = ChangeNotifierProvider((ref) => AppState());
final selectedThemeColorProvider = StateProvider<Color>((ref) => Colors.blue);
final enteredNameProvider = StateProvider<String>((ref) => "");
final enteredDOBProvider = StateProvider<String>((ref) => "");
final enteredGenderProvider = StateProvider<String>((ref) => "");
final enteredEmailProvider = StateProvider<String>((ref) => "");
final enteredPhoneProvider = StateProvider<String>((ref) => "");
final selectedTextSizeProvider = StateProvider<double>((ref) => 14.0);

class AppState extends ChangeNotifier {
  ThemeData appTheme = ThemeData.light();
  SharedPreferences? _prefs;

  Future<void> initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> createProfile(
      String locationKey, DeviceProfileModel profile) async {
    if (_prefs == null) {
      await initializePreferences();
    }
    final profileJson = profile.toJson();
    await _prefs!.setString(locationKey, profileJson);
    notifyListeners();
    print("object");
  }

  Future<DeviceProfileModel?> getProfile(String locationKey) async {
    if (_prefs == null) {
      await initializePreferences();
    }
    final profileJson = _prefs!.getString(locationKey);
    if (profileJson == null) {
      print("hello");
      return null;
    }
    print("hello1");
    return DeviceProfileModel.fromJson(profileJson);
  }
}
