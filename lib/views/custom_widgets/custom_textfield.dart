

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isPhone;
  final String? Function(String?) validator;
  final TextEditingController? controller;

  const CustomTextFormField({super.key,
    this.label,
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isPhone = false,
    required this.validator,
    this.controller,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isPasswordVisible = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword && !_isPasswordVisible,
        validator: widget.validator,
        inputFormatters: [
          if (widget.isPhone) LengthLimitingTextInputFormatter(10),
          if (widget.isPassword) LengthLimitingTextInputFormatter(8),
        ],
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: const Color(0xFFEFF6F6),
          labelText: widget.label,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF096056),
              ),
              borderRadius: BorderRadius.all(Radius.circular(14))),
          hintText: widget.hintText,hintStyle: const TextStyle(color: Color(0xFF096056)),
          prefixIcon: Icon(widget.icon,color: const Color(0xFF096056),),
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: const Color(0xFF096056),
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
