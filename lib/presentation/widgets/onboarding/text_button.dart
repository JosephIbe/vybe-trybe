import 'package:flutter/material.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';

class AppTextButton extends StatelessWidget {

  final VoidCallback onClicked;
  final String title;

  const AppTextButton({
    required this.onClicked,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: Container(
        width: double.infinity,
        height: Sizes.dimen_50,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: Sizes.dimen_14
            ),
          ),
        ),
      ),
    );
  }

}