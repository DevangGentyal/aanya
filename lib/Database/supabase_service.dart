import 'package:Aanya/common_vars.dart';
import 'package:Aanya/database/storage_service.dart';
import 'package:Aanya/utils/storage_constants.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const String appURL = "https://zfikjgmnxxltrkboxfuk.supabase.co";
const String apiKey = dotenv.env['SUPABASE_API_KEY'];

class SupabaseService extends GetxService {
  final CommonVariables commonVars = CommonVariables();
  
  @override
  void onInit() async {
    await Supabase.initialize(url: appURL, anonKey: apiKey);
    listenAuthChange();
    super.onInit();
  }

  // SupabaseInstance
  static final SupabaseClient supabaseClient = Supabase.instance.client;

  // Listen auth events
   void listenAuthChange() async {
    SupabaseService.supabaseClient.auth.onAuthStateChange.listen((data) async {
      if (data.event == AuthChangeEvent.signedIn) {
        await StorageService.box.write(StorageConstants.authKey, data.session);
      } else if (data.event == AuthChangeEvent.signedOut) {
        await StorageService.box.remove(StorageConstants.authKey);
      } else if (data.event == AuthChangeEvent.tokenRefreshed) {
        await StorageService.box.remove(StorageConstants.authKey);
      }
    });
  }
}
