import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testing/utils/color/app_colors.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../provider/login_provider.dart';
import '../../utils/common/common_widgets.dart';

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
  var _isLoading = false;
  late TextEditingController _passwordCtrl;
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
    _passwordCtrl = TextEditingController();
    _confirmPasswordCtrl = TextEditingController();
  }
  void _register() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _registering = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register',style: TextStyle(
          color: Colors.white
        ),),
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
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: TextField(
                  autocorrect: false,
                  autofillHints: _registering ? null : [AutofillHints.password],
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
              TextButton(
                onPressed: _registering ? null : _register,
                child: const Text('Register'),
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
                    text: 'Create Ticket',
                    onTap: () {
                      debugPrint('prinint: login');
                      _onTapBtn(loginProvider);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onTapBtn(LoginProvider loginProvider) async {
    setState(() => _isLoading = true);
    if (_passwordCtrl.text.isEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly enter Serial Number.",
        ),
      );
    } else if (_confirmPasswordCtrl.text.isEmpty) {
      showTopSnackBar(
        Overlay.of(context),
        const CustomSnackBar.error(
          message: "Kindly enter Note.",
        ),
      );
    }
    Map<String, String> body = Map();
    body['product_id'] = dropdownValue;
    body['password'] = _passwordCtrl.text;
    body['confirm_password'] = _confirmPasswordCtrl.text;
    var result = await loginProvider.createTicket(body, context: context);
    setState(() => _isLoading = false);
  }
}
