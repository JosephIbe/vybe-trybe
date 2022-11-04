import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/data/core/db_constants.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/regular_button.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/text_button.dart';
import '../../../widgets/onboarding/onboarding_page_header_text.dart';

class OnboardingPageTwo extends StatefulWidget {

  const OnboardingPageTwo({Key? key}) : super(key: key);

  @override
  State<OnboardingPageTwo> createState() => _OnboardingPageTwoState();
}

class _OnboardingPageTwoState extends State<OnboardingPageTwo> {

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
            // vertical: Sizes.dimen_20
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const OnboardingPageHeaderText(
                  title: TextLiterals.onboardingPageTwoTitle,
                  description: TextLiterals.onboardingPageTwoDescription
              ),
              const SizedBox(height: Sizes.dimen_20),
              Image.asset('assets/images/onboarding-2.png'),
              const SizedBox(height: Sizes.dimen_20),
              Column(
                children: [
                  AuthenticationButton(
                      isEnabled: true,
                      onClicked: ()=> Navigator.pushNamed(context, RouteLiterals.onboardingThree),
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