import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../provider/login_provider.dart';
import '../utils/color/app_colors.dart';
import '../utils/common/common_widgets.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChangePassword();
  }
}

class _ChangePassword extends State<ChangePassword> {
  @override
  FocusNode? _focusNode;
  TextEditingController? _oldPasswordController;
  TextEditingController? _passwordController;
  late TextEditingController _confirmPasswordCtrl;
  final bool _registering = false;
  var _isLoading = false;

  @override
  void initState() {
    _focusNode = FocusNode();
    _passwordController = TextEditingController(text: '');
    _oldPasswordController = TextEditingController(text: '');
    _confirmPasswordCtrl = TextEditingController(text: '');
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
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: TextField(
                      autocorrect: false,
                      autofillHints:
                          _registering ? null : [AutofillHints.password],
                      controller: _oldPasswordController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        labelText: 'Old Password',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () => _oldPasswordController?.clear(),
                        ),
                      ),
                      focusNode: _focusNode,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
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
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
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
                              text: 'Change Password',
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
    if (_oldPasswordController?.text.isEmpty == true) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly enter Old Password.",
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

      body['old_password'] = _oldPasswordController?.text ?? '';
      body['new_password'] = _passwordController?.text ?? '';
      body['confirm_password'] = _confirmPasswordCtrl.text;
      var result = await loginProvider.changePassword(body, context: context);
      setState(() => _isLoading = false);
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: result?.message ?? '',
        ),
      );
      if (result?.status == true) {
        Navigator.pop(context);
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
}
