import 'package:Aanya/common_vars.dart';
import 'package:Aanya/database/auth_controller.dart';
import 'package:Aanya/database/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final commonVars = Provider.of<CommonVariables>(context);
    AuthApi authApi = AuthApi(SupabaseService.supabaseClient);
    return PopupMenuButton<String>(
      icon: Image.asset(
        'assets/images/user.png',
        height: 35 * fem,
      ), // User Profile Icon
      onSelected: (value) async {
        switch (value) {
          case 'profile':
            // Navigate to profile page
            commonVars.updatePageName('profile');
            break;
          case 'logout':
            // Perform logout action
            await authApi.logout();
            Navigator.popAndPushNamed(context,"/login_reg");
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'profile',
          child: ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: Text(
              'Go to Profile',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: 'logout',
          child: ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            title: Text(
              "Logout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
