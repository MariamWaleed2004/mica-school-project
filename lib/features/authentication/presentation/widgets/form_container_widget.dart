import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final bool? isEmailField;
  final bool? isNameField;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final TextInputType? inputType;
  final bool? isConfirmPasswordField;
  final TextEditingController? passwordController;
  final TextEditingController? confirmPasswordController;
  final Function(String)? onChanged;
  

  final bool isError;

  const FormContainerWidget({
    this.controller,
    this.fieldKey,
    this.isPasswordField,
    this.isEmailField,
    this.isNameField,
    this.onSaved,
    this.validator,
    this.hintText,
    this.inputType,
    this.isConfirmPasswordField,
    this.passwordController,
    this.confirmPasswordController,
    this.onChanged,
    required this.isError,
  });

  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool _obscureText = true;
  bool _passwordIsValid = false;
  bool _emailIsValid = false;
  bool _nameIsValid = false;
  bool _isValid = false;
  bool _hasTyped = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextFormField(
        controller: widget.controller,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
   
        keyboardType: widget.inputType,
        onChanged: widget.onChanged,

        decoration: InputDecoration(
          filled: false,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey),
          
         // errorText: widget.isError ? widget.errorMessage : null,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: widget.isPasswordField == true || widget.isConfirmPasswordField == true
                ? Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: _obscureText == false ? Colors.black : Colors.grey,
                  )
                : Text(''),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(0)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.isError ? Colors.red : Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:widget.isError ? Colors.red : Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),
    );
  }
}
