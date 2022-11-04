import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/data/core/db_constants.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/login.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/regular_button.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/text_button.dart';
import '../../../widgets/onboarding/onboarding_page_header_text.dart';


class OnboardingPageFive extends StatefulWidget {
  const OnboardingPageFive({Key? key}) : super(key: key);

  @override
  _OnboardingPageFiveState createState() => _OnboardingPageFiveState();
}

class _OnboardingPageFiveState extends State<OnboardingPageFive> {

  late Box box;

  @override
  void initState() {
    box = Hive.box(DBConstants.userBoxName);
    super.initState();
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
                  title: TextLiterals.onboardingPageFiveTitle,
                  description: TextLiterals.onboardingPageFiveDescription
              ),
              const SizedBox(height: Sizes.dimen_20),
              Image.asset('assets/images/onboarding-5.png'),
              const SizedBox(height: Sizes.dimen_20),
              AuthenticationButton(
                isEnabled: true,
                onClicked: (){
                  box.put(DBConstants.hasViewedIntroScreens, true);
                  Navigator.pushAndRemoveUntil(context,
                      CupertinoPageRoute(builder: (_) => const Login()), (
                          Route<dynamic> route) => false);
                },
                title: TextLiterals.getStarted,
              ),
            ],
          ),
        ),
      ),
    );
  }

}