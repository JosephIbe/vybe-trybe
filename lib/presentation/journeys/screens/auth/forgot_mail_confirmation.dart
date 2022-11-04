import 'package:flutter/material.dart';
import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/regular_button.dart';

class ForgotPasswordEmailConfirmation extends StatelessWidget {

  const ForgotPasswordEmailConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
              'Forgot Password',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: Sizes.dimen_14
              )
          ),
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.black),
              onPressed: ()=> Navigator.pop(context)
          ),
          backgroundColor: Colors.white,
          elevation: Sizes.dimen_0,
        ),
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
                    Image.asset('assets/images/loading_placeholder.png'),
                    const SizedBox(height: Sizes.dimen_30),
                    const Text(
                        TextLiterals.forgotPasswordMailConfirmation,
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
                onClicked: ()=> Navigator.pushNamed(context, RouteLiterals.verifyPasswordResetCodeRoute),
                title: TextLiterals.continueText,
              ),
            ]
          )
        )
      )
    );
  }

}