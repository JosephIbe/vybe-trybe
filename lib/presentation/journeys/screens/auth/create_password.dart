import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/data/core/db_constants.dart';

import 'package:trybe_one_mobile/presentation/blocs/create_password/create_password_bloc.dart';
import 'package:trybe_one_mobile/presentation/blocs/create_password/create_password_state.dart';
import 'package:trybe_one_mobile/presentation/blocs/create_password/create_password_event.dart';
import 'package:trybe_one_mobile/di/get_it_locator.dart' as getIt;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trybe_one_mobile/presentation/journeys/themes/app_colors.dart';
import 'package:trybe_one_mobile/presentation/widgets/auth/trybeone_password_input_field.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/regular_button.dart';

class CreatePassword extends StatelessWidget {

  const CreatePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: CreatePasswordBloc(repository: getIt.getItInstance()),
      child: BlocConsumer<CreatePasswordBloc, CreateNewPasswordState>(
        listener: (context, state){
          if(state is CreateNewPasswordStateSuccess) {
            print(state);
            print('pwd updated');
            MotionToast.success(description: Text('Password changed successfully')).show(context);
            Navigator.pushNamed(context, RouteLiterals.passwordChangedConfirmationRoute);
          }
          if(state is CreateNewPasswordStateFailure){
            print('could not re-send verification code');
            print(state);
          }
        },
        builder: (context, state){
          if(state is CreateNewPasswordStateLoading){
            print('state is $state');
          }
          return const CreateNewPasswordFormView();
        },
      ),
    );
  }

}

class CreateNewPasswordFormView extends StatefulWidget {

  const CreateNewPasswordFormView({Key? key}) : super(key: key);

  @override
  _CreateNewPasswordFormViewState createState() => _CreateNewPasswordFormViewState();

}

late Size size;

class _CreateNewPasswordFormViewState extends State<CreateNewPasswordFormView> {

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box(DBConstants.userBoxName);
  }

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create new password',
            style: TextStyle(
              fontSize: Sizes.dimen_14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.dimen_22,
            vertical: Sizes.dimen_40
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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

                      const SizedBox(height: Sizes.dimen_12),
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
                        // validator: validatePassword(passwordController.text),
                          controller: confirmPasswordController,
                          isPassword: true,
                          labelTitle: TextLiterals.confirmPasswordLabel,
                          placeHolderText:
                          TextLiterals.confirmPasswordPlaceHolder
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
                        child: const Text(
                          TextLiterals.passwordMatch,
                          style: TextStyle(
                              color: TrybeColors.mediumDarkGray,
                              fontWeight: FontWeight.w400,
                              fontSize: Sizes.dimen_12),
                        ),
                      ),

                      const SizedBox(height: Sizes.dimen_12),

                    ],
                  ),
                ),
                AuthenticationButton(
                  title: TextLiterals.continueText,
                  isEnabled: passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty,
                  onClicked: ()=> validateForm(),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  validateForm() {
    if(formKey.currentState != null && formKey.currentState!.validate()){

      dynamic body = {
        'userId': box.get(DBConstants.id),
        'newPassword': passwordController.text
      }; // todo validate both inputs

      BlocProvider.of<CreatePasswordBloc>(context).add(SubmitNewPassword(body: body));
    }
  }

}