import 'package:flutter/material.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/presentation/journeys/themes/app_colors.dart';

class TrybeOneInputField extends StatefulWidget {

  final TextEditingController controller;
  final String labelTitle;
  final String placeHolderText;
  final dynamic validator;

  const TrybeOneInputField({
    Key? key,
    required this.controller,
    required this.labelTitle,
    required this.placeHolderText,
    this.validator,
  }) : super(key: key);

  @override
  _TrybeOneInputFieldState createState() => _TrybeOneInputFieldState();
}

class _TrybeOneInputFieldState extends State<TrybeOneInputField> {

  @override
  Widget build(BuildContext context) {

    return Container(
      constraints: const BoxConstraints(
        minHeight: Sizes.dimen_35,
      ),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        keyboardType: TextInputType.text,
        style: const TextStyle(
          fontSize: Sizes.dimen_16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: widget.placeHolderText,
          contentPadding: const EdgeInsets.symmetric(vertical: Sizes.dimen_10, horizontal: Sizes.dimen_22),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_6)),
            borderSide: BorderSide(
              color: TrybeColors.gray,
              width: Sizes.dimen_1
            )
          ),
          hintStyle: const TextStyle(
            fontSize: Sizes.dimen_14,
            fontWeight: FontWeight.w400,
            color: TrybeColors.hintTextColor
          ),
        ),
      ),
    );

  }

}