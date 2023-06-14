import 'package:flutter/material.dart';
import 'package:imataapp/config/color.dart';

TextFormField CustomTextFormField(String hint, Function(String) fun, bool hide,
        TextEditingController textEditingController) =>
    TextFormField(
      onChanged: fun,
      obscureText: hide,
      controller: textEditingController,
      decoration: InputDecoration(
          disabledBorder: InputBorder.none,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20.0),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800]),
          hintText: hint,
          fillColor: lightyGreen),
    );
