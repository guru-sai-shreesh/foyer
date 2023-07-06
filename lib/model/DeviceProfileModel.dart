import 'dart:convert';

import 'package:flutter/material.dart';

class DeviceProfileModel {
  final Color themeColor;
  final double textSize;
  final String name;
  final String dateInput;
  final String gender;
  final String email;
  final String phone;
  final double latitude;
  final double longitude;

  DeviceProfileModel(
      {required this.name,
      required this.dateInput,
      required this.gender,
      required this.email,
      required this.phone,
      required this.themeColor,
      required this.textSize,
      required this.latitude,
      required this.longitude});

  // Convert the model to JSON
  String toJson() {
    final Map<String, dynamic> data = {
      'themeColor': themeColor.value,
      'textSize': textSize,
      'name': name,
      'gender': gender,
      'email': email,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
    };
    return jsonEncode(data);
  }

  // Create a model from JSON
  factory DeviceProfileModel.fromJson(String json) {
    final Map<String, dynamic> data = jsonDecode(json);
    return DeviceProfileModel(
      themeColor: Color(data['themeColor']),
      textSize: data['textSize'],
      email: data['email'].toString(),
      dateInput: data['dateInput'],
      name: data['name'].toString(),
      gender: data['gender'].toString(),
      phone: data['phone'].toString(),
      latitude: data['latitude'],
      longitude: data['longitude'],
    );
  }
}
