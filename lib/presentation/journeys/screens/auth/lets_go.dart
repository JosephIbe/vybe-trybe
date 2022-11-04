import 'package:flutter/material.dart';
import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/regular_button.dart';

class OnboardingComplete extends StatelessWidget {

  const OnboardingComplete({Key? key}) : super(key: key);

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
                    vertical: Sizes.dimen_20
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.6,
                        ),
                        child: Column(
                            children: [
                              const Text(
                                  TextLiterals.vibeWithTheTrybe,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Sizes.dimen_16,
                                      fontWeight: FontWeight.w500
                                  )
                              ),
                              Image.asset('assets/images/rocket.png'),
                              const SizedBox(height: Sizes.dimen_30),
                              const Text(
                                  TextLiterals.weAreExcited,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Sizes.dimen_16,
                                      fontWeight: FontWeight.w500
                                  )
                              ),
                            ]
                        ),
                      ),
                      AuthenticationButton(
                        isEnabled: true,
                        onClicked: ()=>
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteLiterals.dashboardRoute,
                              (route) => false
                            ),
                        title: TextLiterals.letsGo,
                      ),
                    ]
                )
            )
        )
    );
  }

}