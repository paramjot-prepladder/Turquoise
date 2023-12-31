import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/ui/home_tab/tab.dart';
import 'package:testing/ui/register/register.dart';
import 'package:testing/utils/common/common_widgets.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../provider/login_provider.dart';
import '../../utils/color/app_colors.dart';

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
  late TextEditingController _frgCtrl;
  late TextEditingController _pwdCtrl;
  var _isLoading = false;
  var _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _emailCtrl = TextEditingController();
    _frgCtrl = TextEditingController();
    _pwdCtrl = TextEditingController();
  }

  void _register() async {
    FocusScope.of(context).unfocus();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Register()),
    );
  }

  void _forgotPassword(LoginProvider loginProvider) async {
    var result =
        await loginProvider.forgotPassword(_frgCtrl.text, context: context);
    if (result?.status == true) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: result?.message ?? '',
        ),
      );
    }
  }

  void _register1() async {}

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
        child: SafeArea(
            child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.bottomRight,
                fit: BoxFit.scaleDown,
                image: AssetImage("assets/images/bulb_blue.png"),
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 80, left: 24, right: 24),
                child: Column(
                  children: [
                    Image.asset("assets/icon/launcher_icon.png"),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: TextField(
                        autocorrect: false,
                        autofillHints:
                            _registering ? null : [AutofillHints.email],
                        autofocus: true,
                        controller: _emailCtrl,
                        decoration: const InputDecoration(
                          // border: const OutlineInputBorder(
                          //   borderRadius: BorderRadius.all(
                          //     Radius.circular(8),
                          //   ),
                          // ),
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.person),
                          prefixIconColor: AppColors.greenPrimary,
                          // suffixIcon: IconButton(
                          //   icon: const Icon(Icons.cancel),
                          //   onPressed: () => _emailCtrl.clear(),
                          // ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onEditingComplete: () {
                          _focusNode?.requestFocus();
                        },
                        readOnly: _registering,
                        textCapitalization: TextCapitalization.none,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        autocorrect: false,
                        autofillHints:
                            _registering ? null : [AutofillHints.password],
                        controller: _pwdCtrl,
                        decoration: InputDecoration(
                          // border: const OutlineInputBorder(
                          //   borderRadius: BorderRadius.all(
                          //     Radius.circular(8),
                          //   ),
                          // ),
                          prefixIcon: const Icon(Icons.lock),
                          prefixIconColor: AppColors.greenPrimary,
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () => setState(() {
                              _passwordVisible = !_passwordVisible;
                            }),
                          ),
                        ),
                        focusNode: _focusNode,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: !_passwordVisible,
                        onEditingComplete: _register,
                        textCapitalization: TextCapitalization.none,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    Consumer<LoginProvider>(
                        builder: (context, loginProvider, _) {
                      return Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text('Forgot Password?'),
                                      content: TextField(
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        controller: _frgCtrl,
                                        decoration: const InputDecoration(
                                            hintText: "Kindly enter email"),
                                      ),
                                      actions: <Widget>[
                                        buttonRounded(
                                          text: "Send",
                                          onTap: () {
                                            if (_frgCtrl.text.isEmpty) {
                                              showTopSnackBar(
                                                Overlay.of(context),
                                                const CustomSnackBar.error(
                                                  message:
                                                      "Kindly enter email.",
                                                ),
                                              );
                                              return;
                                            } else if (!isEmail(
                                                _frgCtrl.text)) {
                                              showTopSnackBar(
                                                Overlay.of(context),
                                                const CustomSnackBar.error(
                                                  message:
                                                      "Kindly enter valid email.",
                                                ),
                                              );
                                              return;
                                            }
                                            _forgotPassword(loginProvider);
                                          },
                                        ),
                                      ],
                                    ));
                          },
                          child: const Text('Forgot Password?'),
                        ),
                      );
                    }),
                    Consumer<LoginProvider>(
                      builder: (context, loginProvider, _) {
                        return _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.pinkText,
                                ),
                              )
                            : Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    onTapBtn(loginProvider);
                                  },
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            vertical: 15)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColors.greenPrimary),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            side: const BorderSide(
                                                color:
                                                    AppColors.greenPrimary))),
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.whiteText),
                                  ),
                                ),
                              );
                      },
                    ),
                    TextButton(onPressed: _register1, child: const Text("OR")),
                    TextButton(
                      onPressed: _register,
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )));
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
      return;
    } else if (!isEmail(_emailCtrl.text)) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly enter valid email.",
        ),
      );
      return;
    } else if (_pwdCtrl.text.isEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly enter password.",
        ),
      );
      return;
    }

    var result = await loginProvider.loginApi(
        email: _emailCtrl.text, pwd: _pwdCtrl.text, context: context);
    setState(() => _isLoading = false);
    if (result?.status == true) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: result?.message ?? '',
        ),
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'token', '${result?.data.tokenType} ${result?.data.token}');
      Navigator.pop(context);
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
