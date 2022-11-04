import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/data/core/db_constants.dart';
import 'package:trybe_one_mobile/presentation/widgets/auth/auth_page_header.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/regular_button.dart';

dynamic size;

class UserAgreement extends StatelessWidget {

  const UserAgreement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.dimen_25,
            horizontal: Sizes.dimen_16,
          ),
          child: ListView(
            children: [
              const AuthPageHeaderText(
                title: TextLiterals.userAgreement,
                description: TextLiterals.dataPrivacy,
              ),
              const Text(
                TextLiterals.categoryA,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Sizes.dimen_16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: Sizes.dimen_10),
              Container(
                padding: const EdgeInsets.all(Sizes.dimen_5),
                decoration: const BoxDecoration(
                  color: Color(0XFFF5F5F5),
                  borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10)),
                ),
                constraints: BoxConstraints(
                  minHeight: size.height * 0.35
                ),
                child: const Text(
                  TextLiterals.loremText,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Sizes.dimen_13,
                      fontWeight: FontWeight.w400,
                    ),
                ),
              ),
              const SizedBox(height: Sizes.dimen_20),
              const Text(
                TextLiterals.categoryB,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Sizes.dimen_16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: Sizes.dimen_20),
              Container(
                padding: const EdgeInsets.all(Sizes.dimen_5),
                decoration: const BoxDecoration(
                  color: Color(0XFFF5F5F5),
                  borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10)),
                ),
                constraints: BoxConstraints(
                    minHeight: size.height * 0.35
                ),
                child: const Text(
                    TextLiterals.loremText,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Sizes.dimen_13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: Sizes.dimen_70),
              AuthenticationButton(
                isEnabled: true,
                title: TextLiterals.agreeAndContinue,
                onClicked: () {
                  var box = Hive.box(DBConstants.userBoxName);
                  box.put(DBConstants.onBoardingStep, 0);

                  print('onboarding step after user agreement btn clkd:\t ${DBConstants.onBoardingStep}');

                  Navigator.pushNamedAndRemoveUntil(
                      context, RouteLiterals.lifeUpdateRoute, (route) => false);
                }
              )
            ],
          )
        ),
      ),
    );
  }

}