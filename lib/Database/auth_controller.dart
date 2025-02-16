import 'dart:developer';
import 'package:Aanya/database/supabase_service.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:Aanya/database/user_management.dart';

class AuthController extends GetxController {
  late AuthApi authApi;
  RxBool loginLoading = false.obs;
  RxBool signupLoading = false.obs;

  @override
  void onInit() {
    authApi = AuthApi(SupabaseService.supabaseClient);
    super.onInit();
  }

  // Login method
  Future<String> login(String email, String password) async {
    loginLoading.value = true;
    try {
      final AuthResponse response = await authApi.login(email, password);
      loginLoading.value = false;
      log("The login Response is ${response.user?.toJson()}");
      return 'success';
    } catch (error) {
      loginLoading.value = false;
      log("Error during Login: $error");
      return 'falied';
    }
  }

  // signup method
  Future<String> signup(
      String name, String email, String password, String phone) async {
    signupLoading.value = true;
    try {
      final AuthResponse response =
          await authApi.signup(name, email, password, phone);
      signupLoading.value = false;
      log("The signup Response is ${response.user?.toJson()}");
      return 'success';
    } catch (error) {
      signupLoading.value = false;
      log("Error during signup: $error");
      return 'falied';
    }
  }
}

class AuthApi {
  final SupabaseClient supabaseClient;
  AuthApi(this.supabaseClient);

  Future<AuthResponse> login(String email, String password) async {
    final AuthResponse response = await supabaseClient.auth
        .signInWithPassword(email: email, password: password);
    return response;
  }

  // signup method
  Future<AuthResponse> signup(
      String name, String email, String password, String? phone) async {
    final Map<String, dynamic> userData = {
      "username": name,
      "Phone": phone,
    };
    final AuthResponse response = await supabaseClient.auth
        .signUp(email: email, password: password, data: userData);

    return response;
  }

  // logout
  Future<void> logout() async {
    if (supabaseClient.auth.currentUser != null) {
      await supabaseClient.auth.signOut();
      Get.delete<UserManagement>(); // Dispose of UserManagement service
      print("Logout Sucessfull");
    }
  }
}
