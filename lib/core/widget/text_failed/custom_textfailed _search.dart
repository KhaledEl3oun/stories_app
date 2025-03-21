import 'package:flutter/material.dart';

class CustomTextFieldSearch extends StatefulWidget {
  const CustomTextFieldSearch({
    Key? key,
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
    this.textWithIcon,
  }) : super(key: key);

  final bool isPassword;
  final bool isSelectable;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final Icon? prefixIcon;
  final String? errorText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? textWithIcon;

  @override
  State<CustomTextFieldSearch> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFieldSearch> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context)
            .scaffoldBackgroundColor ==
            Color(0xff191201)
            ? Color(0xff2b1e08)
            : Colors.white,
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword ? _obscureText : widget.obscureText,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          errorText: widget.errorText == null || widget.errorText!.isEmpty
              ? null
              : widget.errorText,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey,fontFamily: "cairo"),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 0.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 0.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 0.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          alignLabelWithHint: true,
        ),
        textAlign: TextAlign.right,
        // Display the text and icon inside the TextField
        buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
          return widget.textWithIcon != null ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              widget.textWithIcon!,
              const SizedBox(width: 8.0),
              Text(
                widget.hintText ?? '',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ) : null;
        },
      ),
    );
  }
}
