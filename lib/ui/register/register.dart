import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/utils/color/app_colors.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../provider/login_provider.dart';
import '../../utils/common/common_widgets.dart';
import '../home_tab/tab.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Register();
  }
}

class _Register extends State<Register> {
  String? _email;
  String? _firstName;
  FocusNode? _focusNode;
  String? _lastName;
  TextEditingController? _passwordController;
  bool _registering = false;
  TextEditingController? _usernameController;
  TextEditingController? _nameController;
  var _isLoading = false;
  late TextEditingController _confirmPasswordCtrl;

  @override
  void initState() {
    super.initState();

    // _firstName = faker.person.firstName();
    // _lastName = faker.person.lastName();
    // _email =
    //     '${_firstName!.toLowerCase()}.${_lastName!.toLowerCase()}@${faker.internet.domainName()}';
    _focusNode = FocusNode();
    _passwordController = TextEditingController(text: '');
    _usernameController = TextEditingController(
      text: _email,
    );
    _nameController = TextEditingController(text: '');
    _confirmPasswordCtrl = TextEditingController(text: '');
  }

  void _register() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _registering = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Register',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.greenPrimary,
          ),
          backgroundColor: AppColors.whiteText,
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 80, left: 24, right: 24),
              child: Column(
                children: [
                  TextField(
                    autocorrect: false,
                    autofillHints: _registering ? null : [AutofillHints.email],
                    autofocus: true,
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      labelText: 'Name',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => _nameController?.clear(),
                      ),
                    ),
                    keyboardType: TextInputType.name,
                    onEditingComplete: () {
                      _focusNode?.requestFocus();
                    },
                    readOnly: _registering,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: TextField(
                      autocorrect: false,
                      autofillHints:
                          _registering ? null : [AutofillHints.email],
                      autofocus: true,
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        labelText: 'Email',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () => _usernameController?.clear(),
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
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: TextField(
                      autocorrect: false,
                      autofillHints:
                          _registering ? null : [AutofillHints.password],
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () => _passwordController?.clear(),
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
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: TextField(
                      autocorrect: false,
                      autofillHints:
                          _registering ? null : [AutofillHints.password],
                      controller: _confirmPasswordCtrl,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        labelText: 'Confirm Password',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () => _confirmPasswordCtrl.clear(),
                        ),
                      ),
                      // focusNode: _focusNode,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      onEditingComplete: _register,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  Consumer<LoginProvider>(
                    builder: (context, loginProvider, _) {
                      return _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.pinkText,
                              ),
                            )
                          : button(
                              text: 'Register',
                              onTap: () {
                                _onTapBtn(loginProvider);
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

  Future<void> _onTapBtn(LoginProvider loginProvider) async {
    if (_nameController?.text.isEmpty == true) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly enter Name.",
        ),
      );
      return;
    } else if (_usernameController?.text.isEmpty == true) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly enter Email.",
        ),
      );
      return;
    } else if (!isEmail(_usernameController?.text ?? '')) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly enter valid Email.",
        ),
      );
      return;
    } else if (_passwordController?.text.isEmpty == true) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly enter Password.",
        ),
      );
      return;
    } else if (_confirmPasswordCtrl.text.isEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly enter Confirm Password.",
        ),
      );
      return;
    }

    if (_passwordController?.text == _confirmPasswordCtrl.text) {
      setState(() => _isLoading = true);
      Map<String, String> body = Map();
      body['name'] = _nameController?.text ?? '';
      body['email'] = _usernameController?.text ?? '';
      body['password'] = _passwordController?.text ?? '';
      body['confirm_password'] = _confirmPasswordCtrl.text;
      var result = await loginProvider.registerUser(body, context: context);
      setState(() => _isLoading = false);

      if (result?.status == true) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'token', '${result?.data.tokenType} ${result?.data.token}');
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const TabHome()), (route) => false);

      } else {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: result?.message != null ? result!.message : 'Error',
          ),
        );
      }
    } else {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "The password doesn't match.",
        ),
      );
    }
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}
