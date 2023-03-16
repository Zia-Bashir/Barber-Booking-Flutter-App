import 'dart:convert';

import 'package:get/get.dart';
import 'package:the_barber/src/common/entities/entities.dart';
import 'package:the_barber/src/common/services/storage.dart';
import 'package:the_barber/src/common/utils/utils.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  final _isLogin = false.obs;
  String token = '';
  final _profile = UserLoginResponseEntity().obs;

  bool get isLogin => _isLogin.value;
  UserLoginResponseEntity get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    token = StorageServices.to.getString(STORAGE_USER_TOKEN_KEY);
    var profileOffline = StorageServices.to.getString(STORAGE_USER_PROFILE_KEY);
    if (profileOffline.isNotEmpty) {
      _isLogin.value = true;
      _profile(UserLoginResponseEntity.fromJson(jsonDecode(profileOffline)));
    }
  }

  //* ---- Store Access Token ----
  Future<void> setToken(String value) async {
    await StorageServices.to.setString(STORAGE_USER_TOKEN_KEY, value);
    token = value;
  }

  Future<String> getToken() async {
    if (token.isEmpty) return "";
    return StorageServices.to.getString(STORAGE_USER_TOKEN_KEY);
  }

  // profile
  Future<String> getProfile() async {
    if (token.isEmpty) return "";
    return StorageServices.to.getString(STORAGE_USER_PROFILE_KEY);
  }

  //* ---- Store User Profile and Token ----
  Future<void> saveProfile(UserLoginResponseEntity profile) async {
    _isLogin.value = true;
    StorageServices.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
    setToken(profile.accessToken!);
  }

  //* ---- Remove User Profile and Token ----
  Future<void> onLogout() async {
    // if (_isLogin.value) await UserAPI.logout();
    await StorageServices.to.remove(STORAGE_USER_TOKEN_KEY);
    await StorageServices.to.remove(STORAGE_USER_PROFILE_KEY);
    _isLogin.value = false;
    token = '';
  }
}
