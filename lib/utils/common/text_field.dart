import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../color/app_colors.dart';

class CommonTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String)? onTextChange;
  final Function()? onObscureChange;
  final int? maxLength;
  final bool? obscureText;
  final TextInputType textInputType;
  final bool autofocus;
  final String placeholder;
  final bool inputBorderHide;
  final String? errorText;
  final Color? errorColor;
  const CommonTextField(
      {Key? key,
      required this.controller,
      this.focusNode,
      this.onTextChange,
      this.maxLength,
      this.inputBorderHide = false,
      this.obscureText,
      this.textInputType = TextInputType.emailAddress,
      this.autofocus = false,
      this.onObscureChange,
      this.placeholder = "",
      this.errorColor,
      this.errorText})
      : super(key: key);

  @override
  _CommonTextFieldState createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25, top: 0, right: 25),
      child: TextField(
        onTap: () {
          setState(() {});
        },
        controller: widget.controller,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        onChanged: (_) =>
            widget.onTextChange != null ? widget.onTextChange!(_) : null,
        cursorColor: Colors.black
        ,
        maxLength: widget.maxLength,
        dragStartBehavior: DragStartBehavior.down,
        textInputAction: TextInputAction.next,
        keyboardType: widget.textInputType,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        obscureText: widget.obscureText ?? false,
        decoration: InputDecoration(
          counterText: '',
          hintText: widget.placeholder,
          labelText: widget.placeholder,
          isDense: true,
          errorText: widget.errorText,
          errorMaxLines: 3,
          errorStyle: const TextStyle(
            color: AppColors.liteBlack,
            fontFamily: 'Mukta_Malar',
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          labelStyle: TextStyle(
              color: AppColors.gradiantColor2,
              fontSize: widget.focusNode != null
                  ? (!widget.focusNode!.hasPrimaryFocus &&
                          widget.controller.text.isEmpty
                      ? 20
                      : 24)
                  : 20),
          hintStyle: const TextStyle(color: Colors.black, fontSize: 18),
          suffixIconConstraints: const BoxConstraints(
            minHeight: 20,
          ),
          suffixIcon: widget.obscureText != null
              ? InkWell(
                  onTap: () => widget.onObscureChange!(),
                  child: widget.obscureText == true
                      ? Image.asset(
                          'asset/visibleOff.png',
                          height: 20,
                          width: 20,
                          color: AppColors.iconGrey,
                        )
                      : Image.asset(
                          'asset/visible.png',
                          height: 20,
                          width: 20,
                          color: AppColors.iconGrey,
                        ))
              : null,
          enabledBorder: widget.inputBorderHide
              ? InputBorder.none
              : const UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.liteBlack, width: 2)),
          focusedBorder: widget.inputBorderHide
              ? InputBorder.none
              : const UnderlineInputBorder(
                  borderSide: BorderSide(color:AppColors.liteBlack, width: 2),
                ),
        ),
      ),
    );
  }
}
