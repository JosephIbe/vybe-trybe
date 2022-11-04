import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/data/core/db_constants.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/regular_button.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/text_button.dart';
import '../../../widgets/onboarding/onboarding_page_header_text.dart';

class OnboardingPageThree extends StatefulWidget {

  const OnboardingPageThree({Key? key}) : super(key: key);

  @override
  State<OnboardingPageThree> createState() => _OnboardingPageThreeState();
}

class _OnboardingPageThreeState extends State<OnboardingPageThree> {

  late Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box(DBConstants.userBoxName);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.dimen_22,
            // vertical: Sizes.dimen_70
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const OnboardingPageHeaderText(
                  title: TextLiterals.onboardingPageThreeTitle,
                  description: TextLiterals.onboardingPageThreeDescription
              ),
              const SizedBox(height: Sizes.dimen_20),
              Image.asset('assets/images/onboarding-3.png'),
              const SizedBox(height: Sizes.dimen_20),
              Column(
                children: [
                  AuthenticationButton(
                      isEnabled: true,
                      onClicked: ()=> Navigator.pushNamed(context, RouteLiterals.onboardingFour),
                      title: TextLiterals.next
                  ),
                  AppTextButton(
                      onClicked: (){
                        box.put(DBConstants.hasViewedIntroScreens, true);
                        Navigator.pushNamed(context, RouteLiterals.loginRoute);
                      },
                      title: TextLiterals.skip
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}