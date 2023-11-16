import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/login_provider.dart';
import '../../utils/color/app_colors.dart';
import '../../utils/common/common_widgets.dart';
import '../../utils/common/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailCtrl;
  late TextEditingController _pwdCtrl;

  @override
  void initState() {
    super.initState();
    _emailCtrl = TextEditingController();
    _pwdCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _pwdCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        child: Scaffold(
          backgroundColor: AppColors.whiteText,
          appBar: AppBar(
            title: Text('Login Demo'),
            backgroundColor: AppColors.greylight,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonTextField(
                placeholder: 'Email',
                controller: _emailCtrl,
              ),
              CommonTextField(
                placeholder: 'Password',
                controller: _pwdCtrl,
              ),
              sizedBox(context: context, hei: 0.03),
              Consumer<LoginProvider>(
                builder: (context, loginProvider, _) {
                  return button(
                    text: 'Login',
                    onTap: () {
                      debugPrint('prinint: login');
                      onTapBtn(loginProvider);
                    },
                  );
                },
              )
            ],
          ),
        ));
  }

  void onTapBtn(LoginProvider loginProvider) async {

    loginProvider.loginApi(
        email: _emailCtrl.text, pwd: _pwdCtrl.text, context: context);
  }
}
