import 'package:flutter/material.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/presentation/journeys/themes/app_colors.dart';

var size;

class LifeUpdateType extends StatelessWidget {

  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const LifeUpdateType({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width,
        height: Sizes.dimen_80,
        decoration: BoxDecoration(
          color: TrybeColors.primaryRed.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
        ),
        padding: const EdgeInsets.all(Sizes.dimen_15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: Sizes.dimen_40,
              height: Sizes.dimen_40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: TrybeColors.primaryRed.withOpacity(0.2),
              ),
              child: Center(
                child: Image.asset(imagePath),
              ),
            ),
            const SizedBox(width: Sizes.dimen_10),
            Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.dimen_16,
                    color: Colors.black
                )
            )
          ],
        ),
      ),
    );
  }

}