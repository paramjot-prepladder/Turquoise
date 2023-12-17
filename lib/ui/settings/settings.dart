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
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                  color: AppColors.greyLite,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.greyLite)),
              child: ListTile(
                leading: const Icon(Icons.person, color: AppColors.liteBlack),
                trailing: const Icon(Icons.arrow_right_rounded),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePassword()),
                  );
                },
                title: const Text(
                  "Change Password",
                  style: TextStyle(color: AppColors.textBlack, fontSize: 18),
                ),
              )),
          Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                  color: AppColors.greyLite,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.greyLite)),
              child: ListTile(
                leading: const Icon(Icons.logout, color: AppColors.liteBlack),
                trailing: const Icon(Icons.arrow_right_rounded),
                onTap: () {
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
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ))
        ],
      ),
      /* SettingsList(
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
      ),*/
    );
  }

  void logout() async {
    Navigator.of(context, rootNavigator: true).pop();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', '');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
        (route) => false);
  }
}
