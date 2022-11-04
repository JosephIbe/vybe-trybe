import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/data/core/db_constants.dart';
import 'package:trybe_one_mobile/presentation/widgets/general/bvn_sign_up_type_card.dart';

late Box box;

class BVNSignUpType extends StatelessWidget {

  const BVNSignUpType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    box = Hive.box(DBConstants.userBoxName);

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_22, vertical: Sizes.dimen_76),
          child: Column(
            children: [
              const Text(
                TextLiterals.howToStart,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Sizes.dimen_25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: Sizes.dimen_84,),
              BVNSignUpTypeCard(
                title: TextLiterals.withBVN,
                description: TextLiterals.withBVNDescription,
                onTapped: (){
                  box.put(DBConstants.hasBVN, true);
                  box.put(DBConstants.onBoardingStep, 1);
                  print('onboarding step after selecting bvn sign-up type :\t ${DBConstants.onBoardingStep}');
                  Navigator.pushNamed(context, RouteLiterals.kycBasicDetailsRoute);
                },
              ),
              const SizedBox(height: Sizes.dimen_30,),
              BVNSignUpTypeCard(
                title: TextLiterals.withoutBVN,
                description: TextLiterals.withoutBVNDescription,
                onTapped: (){
                  box.put(DBConstants.hasBVN, false);
                  box.put(DBConstants.onBoardingStep, 1);
                  print('onboarding step after selecting bvn sign-up type :\t ${DBConstants.onBoardingStep}');
                  Navigator.pushNamed(context, RouteLiterals.kycBasicDetailsRoute);
                },
              ),
            ],
          ),
        )
      ),
    );
  }

}