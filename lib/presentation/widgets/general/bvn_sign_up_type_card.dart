import 'package:flutter/material.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/presentation/journeys/themes/app_colors.dart';

class BVNSignUpTypeCard extends StatelessWidget {

  final String title;
  final String description;
  final VoidCallback onTapped;

  const BVNSignUpTypeCard({
    required this.title,
    required this.description,
    required this.onTapped,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        width: double.infinity,
        height: Sizes.dimen_105,
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.dimen_20,
          vertical: Sizes.dimen_18,
        ),
        decoration: BoxDecoration(
          color: TrybeColors.primaryRed.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: Sizes.dimen_18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: Sizes.dimen_10),
            Text(
              description,
              style: const TextStyle(
                color: Colors.black,
                fontSize: Sizes.dimen_14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        )
      ),
    );
  }

}