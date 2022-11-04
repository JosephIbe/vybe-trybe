import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/common/mixins/input_validations.dart';

import 'package:trybe_one_mobile/presentation/widgets/auth/trybeone_input_field.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/regular_button.dart';

import 'package:trybe_one_mobile/presentation/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:trybe_one_mobile/presentation/blocs/forgot_password/forgot_password_state.dart';
import 'package:trybe_one_mobile/presentation/blocs/forgot_password/forgot_password_event.dart';

import 'package:trybe_one_mobile/di/get_it_locator.dart' as getIt;

import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassword extends StatelessWidget {

  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: ForgotPasswordBloc(repository: getIt.getItInstance()),
        child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state){
            if(state is ForgotPasswordStateSuccess) {
              print(state.response);

              Navigator.pushNamed(
                  context,
                  RouteLiterals.forgotPasswordMailConfirmationRoute
              );
            }
            if(state is ForgotPasswordStateFailure) {
              print(state);
              print(state.errorMessage);
            }
          },
          builder: (context, state){
            if(state is ForgotPasswordStateLoading){
              print('loading state');
              print(state);
            }

            return const ForgotPasswordForm();
          },
        ),
      ),
    );
  }
}


class ForgotPasswordForm extends StatefulWidget {

  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {

  final emailController = TextEditingController();
  late Size size;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return Scaffold(
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.dimen_22,
              vertical: Sizes.dimen_20
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  TextLiterals.emailLabel,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: Sizes.dimen_14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: Sizes.dimen_7),
                TrybeOneInputField(
                  // validator: validateEmail(emailController.text),
                  controller: emailController,
                  labelTitle: TextLiterals.emailLabel,
                  placeHolderText: TextLiterals.emailPlaceHolder,
                ),
                Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.65
                    )
                ),
                AuthenticationButton(
                  // isEnabled: emailController.text.length > 3, //todo validate email before enabling button
                  isEnabled: true,
                  onClicked: ()=> requestEmailVerificationCode(),
                  title: TextLiterals.continueText,
                )
              ],
            ),
          )
      ),
    );

  }

  requestEmailVerificationCode(){

    Map<String, String> body = {
      'email': emailController.text,
    };

    BlocProvider.of<ForgotPasswordBloc>(context).add(SendResetPasswordCode(body: body));

  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

}