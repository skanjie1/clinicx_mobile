import 'package:flutter/services.dart';
import 'package:clinicx_patient/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      required this.controller,
      this.errorText,
      this.labelText,
      this.fillColor,
      this.outlineColor,
      this.keyboardType = TextInputType.text,
      this.isPassword = false,
      this.defaultValue,
      this.prefixIcon,
      this.borderRadius = 8,
      this.showBorder = true,
      this.isEnabled = true,
      this.contentPadding,
      this.onChanged,
      this.validator,
      this.focusNode,
      this.textStyle,
      this.suffixIcon,
      required this.hintText,
      this.isObscure = false})
      : super(key: key);
  final TextEditingController controller;
  final String? errorText;
  final String hintText;
  final Color? fillColor;
  final Color? outlineColor;
  final String? labelText;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final Widget? prefixIcon;
  final String? defaultValue;
  final double borderRadius;
  final Function(String)? onChanged;
  final bool showBorder;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final bool isObscure;
  final bool isEnabled;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final Widget? suffixIcon;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.defaultValue ?? '';
    isObscure = widget.isObscure;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.isEnabled,
      focusNode: widget.focusNode,
      validator: widget.validator ??
          (val) {
            return null;
          },
      obscureText: isObscure && widget.isPassword!,
      onTapOutside: widget.focusNode != null
          ? null
          : (event) {
              FocusScope.of(context).unfocus();
            },
      inputFormatters: [
        if (widget.keyboardType == TextInputType.number ||
            widget.keyboardType == TextInputType.phone)
          FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: widget.onChanged,
      style: widget.textStyle ??
          TextStyle(color: widget.outlineColor ?? Colors.black, fontSize: 18),
      maxLength: null,
      keyboardType: widget.keyboardType,
      maxLines: isObscure ? 1 : null,
      scrollPadding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: InputDecoration(
        suffixIcon: widget.isPassword!
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(
                  isObscure ? Icons.visibility : Icons.visibility_off,
                  color: widget.outlineColor ?? Colors.black,
                ),
              )
            : widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        isDense: true,
        labelText: widget.labelText ?? widget.hintText,
        labelStyle: TextStyle(
          fontSize: 16,
          color:
              widget.outlineColor ?? const Color(0xFF1A1A1A).withOpacity(0.5),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          color:
              widget.outlineColor ?? const Color(0xFF1A1A1A).withOpacity(0.5),
        ),
        focusedBorder: !widget.showBorder
            ? transparentBorder
            : widget.outlineColor != null
                ? focusedBorder.copyWith(
                    borderSide: BorderSide(
                      color: widget.outlineColor!,
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  )
                : focusedBorder,
        border: !widget.showBorder
            ? transparentBorder
            : widget.outlineColor != null
                ? outlineBorder.copyWith(
                    borderSide: BorderSide(
                      color: widget.outlineColor!,
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  )
                : outlineBorder,
        errorBorder: !widget.showBorder ? transparentBorder : errorBorder,
        enabledBorder: !widget.showBorder
            ? transparentBorder
            : OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.outlineColor ??
                      const Color(0xFF1A1A1A).withOpacity(0.1),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
        fillColor: widget.fillColor ?? Colors.white,
        filled: widget.fillColor != null,
      ),
    );
  }
}
