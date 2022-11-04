import 'package:flutter/material.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/presentation/journeys/themes/app_colors.dart';

class KYCHeaderText extends StatelessWidget {

  final bool showStepCount;
  final String stepTitle;
  final String title;
  final String description;

  const KYCHeaderText({
    required this.showStepCount,
    required this.stepTitle,
    required this.title,
    required this.description,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: Sizes.dimen_100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          showStepCount
            ? Text(
                stepTitle,
                style: const TextStyle(
                  color: TrybeColors.primaryRed,
                  fontSize: Sizes.dimen_14,
                  fontWeight: FontWeight.w500
                )
              )
            : Container(),
          const SizedBox(height: Sizes.dimen_5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: Sizes.dimen_25,
              fontWeight: FontWeight.w500
            )
          ),
          const SizedBox(height: Sizes.dimen_5),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: TrybeColors.lightGray2,
              fontSize: Sizes.dimen_16,
              fontWeight: FontWeight.w400
            )
          ),
        ]
      ),
    );
  }

}