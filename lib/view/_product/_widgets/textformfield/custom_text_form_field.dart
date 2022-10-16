import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.name,
    required this.labelText,
    this.prefix,
    this.passwordTextFormField = false,
    this.line,
    this.enableSuggestions,
    this.hintText,
    this.onChanged,
    this.inputFormatters = const [],
    this.maxLetter,
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final String? hintText;
  final Widget? prefix;
  final bool passwordTextFormField;
  final int? line;
  final bool? enableSuggestions;
  final List<TextInputFormatter> inputFormatters;
  final void Function(String text)? onChanged;
  final int? maxLetter;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isPasswordTextFormField;
  late bool isShowPassword;

  @override
  void initState() {
    _isPasswordTextFormField = widget.passwordTextFormField;
    isShowPassword = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      maxLines: widget.line ?? 1,
      obscureText: _isPasswordTextFormField ? !isShowPassword : false,
      enableSuggestions: widget.enableSuggestions ?? false,
      decoration: InputDecoration(
        counterText: widget.maxLetter == null ? null : '${widget.controller.text.length}/${widget.maxLetter}',
        labelText: widget.labelText,
        prefixIcon: widget.prefix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: widget.hintText ?? widget.labelText,
        suffixIcon: !_isPasswordTextFormField
            ? null
            : IconButton(
                onPressed: () {
                  isShowPassword = !isShowPassword;
                  setState(() {});
                },
                icon: Icon(isShowPassword ? Icons.remove_red_eye : Icons.visibility_off),
              ),
      ),
      inputFormatters: [
        ...widget.inputFormatters,
        LengthLimitingTextInputFormatter(widget
            .maxLetter), // Remi Rousselet --> https://stackoverflow.com/questions/49126449/how-to-limit-number-of-characters-in-textformfield
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter ${widget.labelText}';
        }
        return null;
      },
      onChanged: widget.onChanged,
    );
  }
}
