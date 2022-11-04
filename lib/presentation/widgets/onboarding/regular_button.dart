import 'package:flutter/material.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/presentation/journeys/themes/app_colors.dart';

class AuthenticationButton extends StatelessWidget {

  final VoidCallback onClicked;
  final String title;
  final bool isEnabled;

  const AuthenticationButton({
    required this.onClicked,
    required this.title,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked,
      child: SizedBox(
        width: double.infinity,
        height: Sizes.dimen_50,
        child: ElevatedButton(
          onPressed: isEnabled ? onClicked : null,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: Sizes.dimen_18
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: TrybeColors.primaryRed,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_7))
            )
          )
        ),
      )
    );
  }

}