import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/ui/change_password.dart';
import 'package:testing/ui/login/login.dart';
import 'package:testing/utils/color/app_colors.dart';

import '../../main.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Settings();
  }
}

class _Settings extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsList(
        sections: [
          SettingsSection(
            // titlePadding: EdgeInsets.all(20),
            title: const Text('Profile Settings'),
            tiles: [
              SettingsTile(
                title: const Text('Change Password'),
                leading: const Icon(Icons.password_rounded),
                onPressed: (BuildContext context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePassword()),
                  );
                },
              ),
              SettingsTile(
                title: const Text('Logout'),
                leading: const Icon(Icons.logout),
                onPressed: (BuildContext context) {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                              title: const Text('Logout'),
                              content: const Text('Would you like to log out?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel',
                                      style: TextStyle(
                                          color: AppColors.greenPrimary)),
                                ),
                                TextButton(
                                    onPressed: () => logout(),
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(
                                          color: AppColors.greenPrimary),
                                    ))
                              ]));
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', '');
    Navigator.pop(context, 'OK');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
        (route) => false);
  }
}
