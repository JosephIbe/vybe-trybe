import 'package:flutter/material.dart';
import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/regular_button.dart';
import '../../../widgets/onboarding/onboarding_page_header_text.dart';

class OnboardingPageOne extends StatelessWidget {

  const OnboardingPageOne({Key? key}) : super(key: key);

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
            // vertical: Sizes.dimen_20
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const OnboardingPageHeaderText(
                title: TextLiterals.onboardingPageOneTitle,
                description: TextLiterals.onboardingPageOneDescription
              ),
              const SizedBox(height: Sizes.dimen_20),
              Image.asset('assets/images/onboarding-1.png'),
              const SizedBox(height: Sizes.dimen_20),
              AuthenticationButton(
                isEnabled: true,
                onClicked: ()=> Navigator.pushNamed(context, RouteLiterals.onboardingTwo),
                title: TextLiterals.continueText
              )
            ],
          ),
        ),
      ),
    );
  }

}