import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/ui/login/login.dart';
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
  String? _countryCode;
  String? _firstName;
  FocusNode? _focusNode;
  String? _lastName;
  TextEditingController? _passwordController;
  bool _registering = false;
  TextEditingController? _usernameController;
  TextEditingController? _phoneController;
  TextEditingController? _nameController;
  var _isLoading = false;
  late TextEditingController _confirmPasswordCtrl;
  var _passwordVisible = false;
  var _passwordVisibleConfirm = false;

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
    _phoneController = TextEditingController(text: '');
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
        child: SafeArea(
            child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.whiteText,
            elevation: 0,
            toolbarHeight: 120,
            flexibleSpace: Column(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.greenPrimary,
                          size: 20,
                        ))),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text('Welcome to',
                      style: TextStyle(
                          color: AppColors.greenPrimary,
                          fontWeight: FontWeight.w400,
                          fontSize: 16)),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text('TurQuoise',
                      style: TextStyle(
                          color: AppColors.greenPrimary,
                          fontWeight: FontWeight.w700,
                          fontSize: 20)),
                ),
              ],
            ),
          ),
          backgroundColor: AppColors.whiteText,
          body: Container(
            height: double.infinity,
           /* decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.bottomRight,
                fit: BoxFit.scaleDown,
                image: AssetImage("assets/images/bulb_blue.png"),
              ),
            ),*/
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(top: 80, left: 24, right: 24),
                child: Column(
                  children: [
                    TextField(
                      autocorrect: false,
                      autofillHints:
                          _registering ? null : [AutofillHints.email],
                      autofocus: true,
                      controller: _nameController,
                      decoration: const InputDecoration(
                          // border: const OutlineInputBorder(
                          //   borderRadius: BorderRadius.all(
                          //     Radius.circular(8),
                          //   ),
                          // ),
                          hintText: 'Name',
                          prefixIcon: Icon(Icons.person),
                          prefixIconColor: AppColors.greenPrimary),
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
                        decoration: const InputDecoration(
                            // border: OutlineInputBorder(
                            // borderRadius: BorderRadius.all(
                            //   Radius.circular(8),
                            // ),
                            // ),
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.alternate_email),
                            prefixIconColor: AppColors.greenPrimary),
                        keyboardType: TextInputType.emailAddress,
                        onEditingComplete: () {
                          _focusNode?.requestFocus();
                        },
                        readOnly: _registering,
                        textCapitalization: TextCapitalization.none,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: CountryCodePicker(
                            initialSelection: "BH",
                            onChanged: (value) => {
                              _countryCode = value.dialCode
                              // debugPrint("code_value " + value!.dialCode!)
                            },
                            onInit: (value) => {
                              _countryCode = value?.dialCode
                              // debugPrint("code_value " + value!.dialCode!)
                            },
                          ),
                        ),
                        Expanded(
                            child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: TextField(
                            autocorrect: false,
                            controller: _phoneController,
                            decoration: const InputDecoration(
                                // border: const OutlineInputBorder(
                                //   borderRadius: BorderRadius.all(
                                //     Radius.circular(8),
                                //   ),
                                // ),
                                hintText: 'Phone Number',
                                prefixIcon: Icon(Icons.phone),
                                prefixIconColor: AppColors.greenPrimary),
                            keyboardType: TextInputType.phone,
                            textCapitalization: TextCapitalization.none,
                            textInputAction: TextInputAction.done,
                          ),
                        ))
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        autocorrect: false,
                        autofillHints:
                            _registering ? null : [AutofillHints.password],
                        controller: _passwordController,
                        decoration: InputDecoration(
                            // border: const OutlineInputBorder(
                            //   borderRadius: BorderRadius.all(
                            //     Radius.circular(8),
                            //   ),
                            // ),
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
                            prefixIcon: Icon(Icons.password),
                            prefixIconColor: AppColors.greenPrimary),
                        focusNode: _focusNode,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: !_passwordVisible,
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
                            // border: OutlineInputBorder(
                            // borderRadius: BorderRadius.all(
                            //   Radius.circular(8),
                            // ),
                            // ),
                            hintText: 'Confirm Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisibleConfirm
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () => setState(() {
                                _passwordVisibleConfirm =
                                    !_passwordVisibleConfirm;
                              }),
                            ),
                            prefixIcon: Icon(Icons.key),
                            prefixIconColor: AppColors.greenPrimary),
                        // focusNode: _focusNode,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: !_passwordVisibleConfirm,
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
                            : buttonRounded(
                                text: 'Sign Up',
                                top: 20,
                                onTap: () {
                                  _onTapBtn(loginProvider);
                                },
                              );
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text("Login"))
                  ],
                ),
              ),
            ),
          ),
        )));
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
    } else if (_countryCode?.isEmpty == true) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly select Country Code.",
        ),
      );
      return;
    } else if (_phoneController?.text.isEmpty == true) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly enter Phone number.",
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
      body['mobile'] = _phoneController?.text ?? '';
      body['mobile_prefix'] = _countryCode ?? '';
      body['email'] = _usernameController?.text ?? '';
      body['password'] = _passwordController?.text ?? '';
      body['confirm_password'] = _confirmPasswordCtrl.text;
      var result = await loginProvider.registerUser(body, context: context);
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
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const TabHome()),
            (route) => false);
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
