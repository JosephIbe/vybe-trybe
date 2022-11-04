import 'package:flutter/material.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';

class AuthPageHeaderText extends StatelessWidget {

  final String title;
  final String description;

  const AuthPageHeaderText({Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: Sizes.dimen_25,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: Sizes.dimen_10,),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFAEAEAE),
            fontSize: Sizes.dimen_16,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: Sizes.dimen_30,),
      ],
    );
  }

}