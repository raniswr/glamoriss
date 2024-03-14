import 'dart:convert';

import 'package:glamori/app/data/model/model_user.dart';
import 'package:glamori/app/data/storage_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageMethod {
  static Future<bool> saveUserToLocal(ModelUser user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(StorageName.userKey, json.encode(user.toJson()));
  }

  static Future<bool> saveLokasi(String lokasi) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(StorageName.userKeyLoc, lokasi);
  }

  static Future<void> removeUserFromLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(StorageName.userKey);
  }
}
