
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isPhone; // Add this property to identify phone field
  final Function(String?) onSaved;
  final String? Function(String?) validator;

  const CustomTextFormField({
    this.label,
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isPhone = false, // Defaults to false
    required this.onSaved,
    required this.validator,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword && !_isPasswordVisible,
        onSaved: widget.onSaved,
        validator: widget.validator,
        inputFormatters: [
          if (widget.isPhone) LengthLimitingTextInputFormatter(10), // Limit to 10 characters for phone
          if (widget.isPassword) LengthLimitingTextInputFormatter(8), // Limit to 8 characters for password
        ],
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: const Color(0xFFDFE3E3),
          labelText: widget.label,
          hintText: widget.hintText,
          prefixIcon: Icon(widget.icon),
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
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
