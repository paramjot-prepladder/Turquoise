import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/ui/home_tab/tab.dart';
import 'package:testing/ui/register/register.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../provider/login_provider.dart';
import '../../utils/color/app_colors.dart';
import '../../utils/common/common_widgets.dart';
import '../../utils/common/text_field.dart';
import '../home/home.dart';
import '../menu/menu.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _email;
  String? _firstName;
  FocusNode? _focusNode;
  String? _lastName;
  bool _registering = false;
  late TextEditingController _emailCtrl;
  late TextEditingController _pwdCtrl;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _emailCtrl = TextEditingController();
    _pwdCtrl = TextEditingController();
  }

  void _register() async {
    FocusScope.of(context).unfocus();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Register()),
    );
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
            title: const Text('Login'),
            backgroundColor: AppColors.greenPrimary,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 80, left: 24, right: 24),
              child: Column(
                children: [
                  TextField(
                    autocorrect: false,
                    autofillHints: _registering ? null : [AutofillHints.email],
                    autofocus: true,
                    controller: _emailCtrl,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      labelText: 'Email',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => _emailCtrl.clear(),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onEditingComplete: () {
                      _focusNode?.requestFocus();
                    },
                    readOnly: _registering,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: TextField(
                      autocorrect: false,
                      autofillHints:
                          _registering ? null : [AutofillHints.password],
                      controller: _pwdCtrl,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () => _pwdCtrl.clear(),
                        ),
                      ),
                      focusNode: _focusNode,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      onEditingComplete: _register,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  TextButton(
                    onPressed: _registering ? null : _register,
                    child: const Text('Register'),
                  ),
                  /*ElevatedButton.icon(
                    onPressed: _isLoading ? null : _onSubmit,
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16.0)),
                    icon: _isLoading
                        ? Container(
                            width: 24,
                            height: 24,
                            padding: const EdgeInsets.all(2.0),
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Icon(Icons.feedback),
                    label: const Text('SUBMIT'),
                  ),*/
                  Consumer<LoginProvider>(
                    builder: (context, loginProvider, _) {
                      return _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.pinkText,
                              ),
                            )
                          : button(
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
            ),
          ),
        ));
  }


  onTapBtn(LoginProvider loginProvider) async {
    setState(() => _isLoading = true);
    if (_emailCtrl.text.isEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly enter email.",
        ),
      );
    } else if (!isEmail(_emailCtrl.text)) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly enter valid email.",
        ),
      );
    } else if (_pwdCtrl.text.isEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly enter password.",
        ),
      );
    }

    var result = await loginProvider.loginApi(
        email: _emailCtrl.text, pwd: _pwdCtrl.text, context: context);
    setState(() => _isLoading = false);
    if (result?.status == true) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'token', '${result?.data.tokenType} ${result?.data.token}');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TabHome()),
      );
    } else {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: result?.message != null ? result!.message : 'Error',
        ),
      );
      if (kDebugMode) {
        print(result!.message);
      }
    }
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}
