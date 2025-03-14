import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.keyboardType,
    this.isPassword = false,
    this.obscureText = false,
    this.isSelectable = false,
    this.onChanged,
    this.prefixIcon,
    this.errorText,
    this.controller,
    this.suffixIcon,
    this.readOnly = false,
    this.minLines = 1, // Minimum lines
    this.maxLines = 5, // Maximum lines
    this.height = 50.0, // Default height for the TextField,
    this.validator ,
    this.onTap
  });
   final void Function()? onTap;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool isSelectable;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final void Function(String)? onChanged;
  final Icon? prefixIcon;
  final String? errorText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final int minLines;
  final int maxLines;
  final double height; // New height property
  final bool readOnly;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      autovalidateMode:  AutovalidateMode.onUserInteraction,
      validator: widget.validator,
     readOnly: widget.readOnly,
     controller: widget.controller,
     keyboardType: widget.keyboardType,
     obscureText: widget.isPassword ? _obscureText : widget.obscureText,
     onChanged: widget.onChanged,
     maxLines: widget.isPassword ? 1 : widget.maxLines,
     minLines: widget.isPassword ? 1 : widget.minLines,
     decoration: InputDecoration(
       filled: true,
       fillColor: Theme.of(context).inputDecorationTheme.fillColor ,
       prefixIcon: widget.isPassword
           ? IconButton(
         icon: Icon(
           _obscureText ? Icons.visibility_off : Icons.visibility,
         ),
         onPressed: () {
           setState(() {
             _obscureText = !_obscureText;
           });
         },
       )
           : widget.prefixIcon,
       suffixIcon: widget.suffixIcon,
       errorText: widget.errorText == null || widget.errorText!.isEmpty
           ? null
           : widget.errorText,
       hintText: widget.hintText,
       hintStyle: Theme.of(context).textTheme.bodyLarge,
       border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(20.0),
       ),
       enabledBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(20.0),
         borderSide: const BorderSide(
           color: Colors.grey,
           width: 1.5,
         ),
       ),
       focusedBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(20.0),
         borderSide: const BorderSide(
           color: Colors.orangeAccent,
           width: 1.5,
         ),
       ),
       errorBorder:  OutlineInputBorder(
         borderRadius: BorderRadius.circular(20.0),
         borderSide: const BorderSide(
           color: Colors.orangeAccent,
           width: 1.5,
         ),
       ),
       contentPadding: const EdgeInsets.symmetric(
           vertical: 10.0, horizontal: 20.0), // Adjust padding to center the text
       errorMaxLines: 3, // Add this to handle error text height
     ),
     textAlign: TextAlign.right, // Align text and hint text to the right
          );
  }
}
