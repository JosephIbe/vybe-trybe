import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/common/mixins/input_validations.dart';

import 'package:trybe_one_mobile/domain/repositories/user_repository.dart';

import 'package:trybe_one_mobile/presentation/blocs/register/register_bloc.dart';
import 'package:trybe_one_mobile/presentation/blocs/register/register_state.dart';
import 'package:trybe_one_mobile/presentation/blocs/register/register_event.dart';

import 'package:trybe_one_mobile/presentation/journeys/themes/app_colors.dart';

import 'package:trybe_one_mobile/presentation/widgets/auth/auth_page_header.dart';
import 'package:trybe_one_mobile/presentation/widgets/auth/trybeone_input_field.dart';
import 'package:trybe_one_mobile/presentation/widgets/auth/trybeone_password_input_field.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/regular_button.dart';

late String email;

class Register extends StatelessWidget {

  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(
        repository: RepositoryProvider.of<UserRepository>(context)
      ),
      child: const RegisterForm(),
    );
  }
}

class RegisterForm extends StatelessWidget {

  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state){
        if(state is RegisterStateSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.verifyEmailRoute, (route) => false);
        }
        if(state is RegisterStateFailure) {
          print('register state is $state');
          print(state.errorMessage);
          MotionToast
            .error(
              description: Text(state.errorMessage),
              position: MOTION_TOAST_POSITION.center,
              toastDuration: const Duration(seconds: 3),
          ).show(context);
        }
      },
      builder: (context, state){
        if (state is RegisterStateLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if(state is RegisterStateFailure){
          print('register state in builder:\t$state');
          return const RegisterFormView();
        }
        return const RegisterFormView();
      },
    );
  }

}

class RegisterFormView extends StatefulWidget {

  const RegisterFormView({Key? key}) : super(key: key);

  @override
  _RegisterFormViewState createState() => _RegisterFormViewState();
}

class _RegisterFormViewState extends State<RegisterFormView > {

  late Size size;

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final referralCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.dimen_22, vertical: Sizes.dimen_20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const AuthPageHeaderText(
                  title: TextLiterals.registerPageTitle,
                  description: TextLiterals.registerPageDescription,
                ),
                Container(
                  constraints: BoxConstraints(
                    minHeight: size.height * 0.5,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
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
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Email is required';
                                }
                                if (!value.contains('@') && value.length < 3) {
                                  return 'Invalid email format';
                                } else {
                                  setState(()=> email = emailController.text);
                                  return null;
                                }
                              },
                              controller: emailController,
                              labelTitle: TextLiterals.emailLabel,
                              placeHolderText: TextLiterals.emailPlaceHolder,
                            ),
                          ],
                        ),
                        const SizedBox(height: Sizes.dimen_12),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 800),
                          opacity: emailController.text.length > 3 ? 1.0 : 0.0,
                          child:
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                TextLiterals.passwordLabel,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: Sizes.dimen_14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: Sizes.dimen_7),
                              TrybeOnePasswordField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Password is required';
                                    } else if (value.length < 6) {
                                      return "Password is too short";
                                    } else if (!value.contains(RegExp(r'[0-9]'))) {
                                      return "Password must contain a number";
                                    }
                                  },
                                  controller: passwordController,
                                  isPassword: true,
                                  labelTitle: TextLiterals.passwordLabel,
                                  placeHolderText:
                                  TextLiterals.passwordPlaceHolder),
                            ],
                          ),
                        ),
                        const SizedBox(height: Sizes.dimen_12),
                        AnimatedOpacity(
                            duration: const Duration(milliseconds: 800),
                            opacity: passwordController.text.length > 3 ? 1.0 : 0.0,
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  TextLiterals.confirmPasswordLabel,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: Sizes.dimen_14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: Sizes.dimen_7),
                                TrybeOnePasswordField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Password is required';
                                      } else if (value.length < 6) {
                                        return "Password is too short";
                                      } else if (!value.contains(RegExp(r'[0-9]'))) {
                                        return "Password must contain a number";
                                      }
                                    },
                                    controller: confirmPasswordController,
                                    isPassword: true,
                                    labelTitle: TextLiterals.confirmPasswordLabel,
                                    placeHolderText:
                                    TextLiterals.confirmPasswordPlaceHolder
                                ),
                              ],
                            ),
                        ),
                        const SizedBox(height: Sizes.dimen_12),
                        AnimatedOpacity(
                            duration: const Duration(milliseconds: 1800),
                            opacity:
                            confirmPasswordController.text.length > 3 &&
                                confirmPasswordController.text ==
                                    passwordController.text
                                ? 1.0
                                : 0.0,
                            child: Text(
                              confirmPasswordController.text == passwordController.text
                                  ? TextLiterals.passwordMatch
                                  : TextLiterals.passwordNotMatched,
                              style: TextStyle(
                                  color: confirmPasswordController.text == passwordController.text ? Colors.green : TrybeColors.primaryRed,
                                  fontWeight: FontWeight.w400,
                                  fontSize: Sizes.dimen_12),
                            ),
                        ),
                        const SizedBox(height: Sizes.dimen_12),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 800),
                          opacity: confirmPasswordController.text.length > 3 &&
                              confirmPasswordController.text ==
                                  passwordController.text ? 1.0 : 0.0,
                          child:
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  TextLiterals.referralCode,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: Sizes.dimen_14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: Sizes.dimen_7),
                                Container(
                                  width: double.infinity,
                                  height: Sizes.dimen_45,
                                  padding: const EdgeInsets.fromLTRB(
                                    Sizes.dimen_22,
                                    Sizes.dimen_0,
                                    Sizes.dimen_5,
                                    Sizes.dimen_5,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(Sizes.dimen_6)),
                                      border: Border.all(
                                          color: const Color(0xFF727272),
                                          width: Sizes.dimen_1)),
                                  child: TextFormField(
                                    // validator: widget.validator,
                                    controller: referralCodeController,
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(
                                      fontSize: Sizes.dimen_16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                      hintText: 'a9b6-fu',
                                      hintStyle: TextStyle(
                                          fontSize: Sizes.dimen_14,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.italic,
                                          color: TrybeColors.hintTextColor
                                      ),
                                    ),
                                  ),
                                )
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: Sizes.dimen_15),
                AnimatedOpacity(
                  opacity: emailController.text.isNotEmpty
                      && passwordController.text.isNotEmpty
                      && confirmPasswordController.text.isNotEmpty
                      && confirmPasswordController.text == passwordController.text
                      ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 800),
                  child: Column(children: [
                    AuthenticationButton(
                      title: TextLiterals.continueText,
                      isEnabled: emailController.text.isNotEmpty
                          && passwordController.text.isNotEmpty
                          && confirmPasswordController.text.isNotEmpty,
                      onClicked: ()=> validateForm(),
                    ),
                    const SizedBox(height: Sizes.dimen_45),
                    const Text(TextLiterals.newToTheTrybe,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: Sizes.dimen_14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black)),
                    const SizedBox(height: Sizes.dimen_7),
                    InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, RouteLiterals.loginRoute),
                      child: const Text(TextLiterals.signIn,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: Sizes.dimen_14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFE60026))),
                    )
                  ]),
                ),
              ],
            ),
          )
        ),
      )
    );
  }

  validateForm(){
    if(formKey.currentState != null && formKey.currentState!.validate()){
      Map<String, dynamic> body = {
        "email": emailController.text,
        "password": passwordController.text,
        //todo add referral code
      };
      BlocProvider.of<RegisterBloc>(context).add(RegisterWithEmail(body: body));
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    referralCodeController.dispose();
  }

}