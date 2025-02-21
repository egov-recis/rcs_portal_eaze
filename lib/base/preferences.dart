import 'package:rcs_portal_eaze/common/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Future<String> getUdid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Strings.udid) ?? "";
  }

  Future<void> saveUdid(String? data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Strings.udid, data ?? "");
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Strings.token) ?? "";
  }

  Future<void> saveToken(String? data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Strings.token, data ?? "");
  }
}
