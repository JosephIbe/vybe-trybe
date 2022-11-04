import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/data/core/db_constants.dart';
import 'package:trybe_one_mobile/presentation/blocs/verify/verify_bloc.dart';
import 'package:trybe_one_mobile/presentation/blocs/verify/verify_event.dart';
import 'package:trybe_one_mobile/presentation/blocs/verify/verify_state.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/regular_button.dart';

import 'package:trybe_one_mobile/di/get_it_locator.dart' as getIt;

class VerifyEmail extends StatelessWidget {

  const VerifyEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: VerifyBloc(repository: getIt.getItInstance()),
      child: BlocConsumer<VerifyBloc, VerifyState>(
        listener: (context, state){
          if(state is VerifyStateSuccess) {
            print(state);
            Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.userAgreementRoute, (route) => false);
          }
          if(state is VerifyStateFailure){
            print(state.errorMessage);
            MotionToast
              .error(description: Text(state.errorMessage)
            ).show(context);
          }
          if(state is ResendVerificationCodeStateSuccess){
            print('verification code re-sent');
            print(state);
          }
          if(state is ResendVerificationCodeStateFailure){
            print('could not re-send verification code');
            print(state);
          }
        },
        builder: (context, state){
          if(state is VerifyStateLoading){
            return const Center(
                child: CircularProgressIndicator()
            );
          }
          return const VerifyEmailForm();
        },
      )
    );
  }

}

class VerifyEmailForm extends StatefulWidget {

  const VerifyEmailForm({Key? key}) : super(key: key);

  @override
  _VerifyEmailFormState createState() => _VerifyEmailFormState();
}

class _VerifyEmailFormState extends State<VerifyEmailForm> {

  late Size size;

  final formKey = GlobalKey<FormState>();

  final firstController = TextEditingController();
  final secondController = TextEditingController();
  final thirdController = TextEditingController();
  final fourthController = TextEditingController();

  final focusOne = FocusNode();
  final focusTwo = FocusNode();
  final focusThree = FocusNode();
  final focusFour = FocusNode();

  late String? email;

  @override
  void initState() {
    super.initState();
    var box = Hive.box(DBConstants.userBoxName);
    setState(()=> email = box.get(DBConstants.email));
  }

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
              horizontal: Sizes.dimen_22,
              vertical: Sizes.dimen_40
          ),
          child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    TextLiterals.letsKnowItsYou,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: Sizes.dimen_25
                    ),
                  ),
                  const SizedBox(height: Sizes.dimen_20),
                  Text(
                    'A code has been sent to your mail $email. Input the code below \nto verify and continue',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: Sizes.dimen_14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: Sizes.dimen_46),
                  Form(
                    key: formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: Sizes.dimen_50,
                            height: Sizes.dimen_60,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEDEDED),
                              borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller: firstController,
                                  keyboardType: TextInputType.phone,
                                  focusNode: focusOne,
                                  textInputAction: TextInputAction.next,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: Sizes.dimen_16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1)
                                  ],
                                  onChanged: (value){
                                    if(value.length == 1){
                                      if(focusOne.hasFocus){
                                        focusOne.unfocus();
                                      }
                                      FocusScope.of(context).requestFocus(focusTwo);
                                    }
                                  },
                                  onFieldSubmitted: (value){
                                    if(focusOne.hasFocus){
                                      focusOne.unfocus();
                                      FocusScope.of(context).requestFocus(focusTwo);
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                  ),
                                )
                              ],
                            )
                        ),
                        const SizedBox(width: Sizes.dimen_20,),
                        Container(
                            width: Sizes.dimen_50,
                            height: Sizes.dimen_60,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEDEDED),
                              borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller: secondController,
                                  keyboardType: TextInputType.phone,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: Sizes.dimen_16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                  focusNode: focusTwo,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1)
                                  ],
                                  onChanged: (value){
                                    if(value.length == 1){
                                      if(focusTwo.hasFocus){
                                        focusTwo.unfocus();
                                      }
                                      FocusScope.of(context).requestFocus(focusThree);
                                    }
                                  },
                                  onFieldSubmitted: (value){
                                    if(focusTwo.hasFocus){
                                      focusTwo.unfocus();
                                      FocusScope.of(context).requestFocus(focusThree);
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                  ),
                                )
                              ],
                            )
                        ),
                        const SizedBox(width: Sizes.dimen_20,),
                        Container(
                            width: Sizes.dimen_50,
                            height: Sizes.dimen_60,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEDEDED),
                              borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller: thirdController,
                                  keyboardType: TextInputType.phone,
                                  textAlign: TextAlign.center,
                                  focusNode: focusThree,
                                  textInputAction: TextInputAction.next,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1)
                                  ],
                                  onChanged: (value){
                                    if(value.length == 1){
                                      if(focusThree.hasFocus){
                                        focusThree.unfocus();
                                      }
                                      FocusScope.of(context).requestFocus(focusFour);
                                    }
                                  },
                                  onFieldSubmitted: (value){
                                    if(focusThree.hasFocus){
                                      focusThree.unfocus();
                                      FocusScope.of(context).requestFocus(focusFour);
                                    }
                                  },
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: Sizes.dimen_16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                  ),
                                )
                              ],
                            )
                        ),
                        const SizedBox(width: Sizes.dimen_20,),
                        Container(
                            width: Sizes.dimen_50,
                            height: Sizes.dimen_60,
                            decoration: const BoxDecoration(
                              color: Color(0xFFEDEDED),
                              borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextFormField(
                                  controller: fourthController,
                                  keyboardType: TextInputType.phone,
                                  textAlign: TextAlign.center,
                                  textInputAction: TextInputAction.done,
                                  focusNode: focusFour,
                                  onChanged: (value){},
                                  onFieldSubmitted: (value){
                                    if(value.length == 1){
                                      if(focusFour.hasFocus){
                                        focusFour.unfocus();
                                      }
                                    }
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1)
                                  ],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: Sizes.dimen_16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                  ),
                                )
                              ],
                            )
                        ),
                        const SizedBox(width: Sizes.dimen_20,)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.dimen_30,
                      vertical: Sizes.dimen_33,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.dimen_0,
                              vertical: Sizes.dimen_0
                          ),
                          child: InkWell(
                            onTap: ()=> resendVerificationCode(),
                            child: const Text(
                              TextLiterals.resendCode,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Sizes.dimen_14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              TextLiterals.enteredWrongMail,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: Sizes.dimen_14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: Sizes.dimen_10),
                            Padding(
                              padding: const EdgeInsets.only(top: Sizes.dimen_2),
                              child: InkWell(
                                onTap: ()=> {},
                                child: const Text(
                                  TextLiterals.changeMail,
                                  style: TextStyle(
                                    color: Color(0xFFE60026),
                                    fontSize: Sizes.dimen_14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: Sizes.dimen_100),
                  AuthenticationButton(
                      isEnabled: firstController.text.length == 1 && secondController.text.length == 1
                          && thirdController.text.length == 1 && fourthController.text.length == 1,
                      onClicked: ()=> submitVerificationCode(),
                      title: TextLiterals.continueText
                  )
                ],
              )
          ),
        ),
      ),
    );
  }

  submitVerificationCode() {

    log('submit verif code clkd');

    String code = firstController.text + secondController.text + thirdController.text +
        fourthController.text;

    var box = Hive.box(DBConstants.userBoxName);
    var userId = box.get(DBConstants.id);
    // print('userId $userId');
    // print('userId ${userId.runtimeType}');

    Map<String, dynamic> body = {
      'token': code,
      'userId': userId
      // 'userId': userId.toString()
    };

    BlocProvider.of<VerifyBloc>(context).add(SubmitVerificationCode(body: body));
  }

  resendVerificationCode() {

    print('resend code clicked');

    var box = Hive.box(DBConstants.userBoxName);
    var email = box.get(DBConstants.email);

    Map<String, dynamic> body = {
      'email': email,
    };

    BlocProvider.of<VerifyBloc>(context).add(ResendVerificationCode(body: body));
  }

  @override
  void dispose() {
    super.dispose();
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    fourthController.dispose();

    focusOne.dispose();
    focusTwo.dispose();
    focusThree.dispose();
    focusFour.dispose();
  }

}