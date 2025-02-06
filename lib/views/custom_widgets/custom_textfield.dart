// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:seller_app/utils/app_colors.dart';
//
// class CustomTextFormField extends StatefulWidget {
//   final String? label;
//   final String hintText;
//   final IconData icon;
//   final TextInputType keyboardType;
//   final bool isPassword;
//   final bool isPhone; // Add this property to identify phone field
//   final String? Function(String?) validator;
//   final TextEditingController? controller;
//
//   const CustomTextFormField({
//     this.label,
//     required this.hintText,
//     required this.icon,
//     this.keyboardType = TextInputType.text,
//     this.isPassword = false,
//     this.isPhone = false, // Defaults to false
//     required this.validator, this.controller,
//   });
//
//   @override
//   _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
// }
//
// class _CustomTextFormFieldState extends State<CustomTextFormField> {
//   bool _isPasswordVisible = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextFormField(
//
//         keyboardType: widget.keyboardType,
//         obscureText: widget.isPassword && !_isPasswordVisible,
//         validator: widget.validator,
//         inputFormatters: [
//           if (widget.isPhone) LengthLimitingTextInputFormatter(10), // Limit to 10 characters for phone
//           if (widget.isPassword) LengthLimitingTextInputFormatter(8), // Limit to 8 characters for password
//         ],
//         decoration: InputDecoration(
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppColors.borderColor),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           filled: true,
//           fillColor: const Color(0xFFDFE3E3),
//           labelText: widget.label,
//           hintText: widget.hintText,
//           prefixIcon: Icon(widget.icon),
//           suffixIcon: widget.isPassword
//               ? IconButton(
//             icon: Icon(
//               _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
//               color: Colors.grey,
//             ),
//             onPressed: () {
//               setState(() {
//                 _isPasswordVisible = !_isPasswordVisible;
//               });
//             },
//           )
//               : null,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//     );
//   }
// }


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
  final TextEditingController? controller; // Added controller property

  const CustomTextFormField({
    this.label,
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.isPhone = false,
    required this.validator,
    this.controller, // Optional controller
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isPasswordVisible = false;
  late TextEditingController _controller; // Internal controller

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose(); // Dispose only if it's internally created
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _controller, // Use the controller
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword && !_isPasswordVisible,
        validator: widget.validator,
        inputFormatters: [
          if (widget.isPhone) LengthLimitingTextInputFormatter(10),
          if (widget.isPassword) LengthLimitingTextInputFormatter(8),
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
