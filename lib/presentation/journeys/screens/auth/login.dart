import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/data/core/api_client.dart';
import 'package:trybe_one_mobile/data/core/api_constants.dart';
// import 'package:trybe_one_mobile/common/mixins/input_validations.dart';

import 'package:trybe_one_mobile/data/core/db_constants.dart';
import 'package:trybe_one_mobile/data/models/user/user_model.dart';
import 'package:trybe_one_mobile/data/models/user/user_response_model.dart';

import 'package:trybe_one_mobile/di/get_it_locator.dart' as getIt;

import 'package:trybe_one_mobile/presentation/blocs/login/login_bloc.dart';
import 'package:trybe_one_mobile/presentation/blocs/login/login_event.dart';
import 'package:trybe_one_mobile/presentation/blocs/login/login_state.dart';

import 'package:trybe_one_mobile/presentation/widgets/auth/auth_page_header.dart';
import 'package:trybe_one_mobile/presentation/widgets/auth/trybeone_input_field.dart';
import 'package:trybe_one_mobile/presentation/widgets/auth/trybeone_password_input_field.dart';
import 'package:trybe_one_mobile/presentation/widgets/general/loader.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/regular_button.dart';

class Login extends StatelessWidget {

  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context)=> BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          repository: getIt.getItInstance()
        ),
        child: const LoginForm(),
      )
    );
  }

}

late Box box;

class LoginForm extends StatelessWidget {

  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    box = Hive.box(DBConstants.userBoxName);

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state){
        print('login state listened:\n$state');
        if(state is LoginStateSuccess){

          MotionToast
              .success(
            description: const Text('You have logged in successfully'),
            position: MOTION_TOAST_POSITION.center,
          ).show(context);

          User? user = state.userModel as User?;
          // final user = UserResponseModel.fromJson(state.userModel).data?.user;

          print('user.email ${user?.email}');
          print('user.onboardingStep ${user?.onboardingStep}');
          print('user.isCompleteOnboarding ${user?.isCompleteOnboarding}');
          print('user.profile.image ${user?.profileImage}');
          print('user.address ${user?.address}');
          print('user.id ${user?.id}');
          print('user.phone ${user?.phone}');

          var complete = user?.isCompleteOnboarding;
          var verified = user?.isVerified;

          if(!verified!){
            Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.verifyEmailRoute, (route) => false);
          }

          if(!complete!){
            switch (user?.onboardingStep){
              case 0:
                Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.userAgreementRoute, (route) => false);
                break;
              case 1:
                Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.kycBasicDetailsRoute, (route) => false);
                break;
              case 2:
                var lifeUpdateType = user?.userType;
                print('lifeUpdateType $lifeUpdateType');
                if(lifeUpdateType != null){
                  switch(lifeUpdateType){
                    case 'STUDENT':
                      Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.studentAndCorperAddressInfoRoute, (route) => false);
                      break;
                    case 'CORPER':
                      Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.studentAndCorperAddressInfoRoute, (route) => false);
                      break;
                    case 'EMPLOYED':
                      Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.employeeSelfEmployedAddressInfo, (route) => false);
                      break;
                    case 'SELF_EMPLOYED':
                      Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.employeeSelfEmployedAddressInfo, (route) => false);
                      break;
                  }
                }
                break;
              case 3:
                Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.uploadProfilePictureRoute, (route) => false);
                break;
              case 4:
                Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.utilityBillsRoute, (route) => false);
                break;
              case 5:
                // Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.interestsRoute, (route) => false);
                Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.dashboardRoute, (route) => false);
                break;
            }
          } else {
            Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.dashboardRoute, (route) => false);
          }

        }
        if(state is LoginStateFailure){
          print('login failed due to:\n');
          print(state.errorMessage);
          MotionToast
            .error(
              description: Text(state.errorMessage!),
            position: MOTION_TOAST_POSITION.center,
          ).show(context);
        }
      },
      builder: (context, state){
        print('login state built:\n$state');
        if(state is LoginStateLoading) {
          return const Loader();
        }
        if(state is LoginStateFailure) {
          return const LoginFormView();
        }
        return const LoginFormView();
      },
    );
  }

}

class LoginFormView extends StatefulWidget {

  const LoginFormView({Key? key}) : super(key: key);

  @override
  _LoginFormViewState createState() => _LoginFormViewState();

}

class _LoginFormViewState extends State<LoginFormView> {

  late Size size;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.dimen_22,
            vertical: Sizes.dimen_20
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const AuthPageHeaderText(
                  title: TextLiterals.loginPageTitle,
                  description: TextLiterals.loginPageDescription,
                ),
                Container(
                  constraints: BoxConstraints(
                    minHeight: size.height * 0.5,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                // validator: validateEmail(emailController.text),
                              validator: (value){
                              },
                                controller: emailController,
                                labelTitle: TextLiterals.emailLabel,
                                placeHolderText: TextLiterals.emailPlaceHolder,
                            ),
                          ],
                        ),
                        const SizedBox(height: Sizes.dimen_32),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 800),
                          opacity: emailController.text.length > 3
                              ? 1.0 : 0.0, //todo also check for valid email format
                          child: Column(
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
                                  // validator: validatePassword(passwordController.text),
                                validator: (value){
                                  if(value.length > 3) {
                                  }
                                },
                                  controller: passwordController,
                                  isPassword: true,
                                  labelTitle: TextLiterals.passwordLabel,
                                  placeHolderText: TextLiterals.passwordPlaceHolder
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Sizes.dimen_16),
                        Opacity(
                          opacity: emailController.text.length > 3 ? 1.0 : 0.0,
                          child: InkWell(
                              onTap: ()=> Navigator.pushNamed(context, RouteLiterals.forgotPasswordRoute),
                              child: const Text(
                                  TextLiterals.forgotPassword,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: Sizes.dimen_14,
                                  )
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    AuthenticationButton(
                      isEnabled: emailController.text.isNotEmpty && passwordController.text.isNotEmpty,
                      title: TextLiterals.letsGo,
                      onClicked: ()=> submitLogin(),
                    ),
                    const SizedBox(height: Sizes.dimen_45),
                    const Text(
                      TextLiterals.newToTheTrybe,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Sizes.dimen_14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black
                      )
                    ),
                    const SizedBox(height: Sizes.dimen_7),
                    InkWell(
                      onTap: ()=> Navigator.pushNamed(context, RouteLiterals.registerRoute),
                      child: const Text(
                          TextLiterals.getStarted,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: Sizes.dimen_14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFE60026)
                          )
                      ),
                    )
                  ]
                )
              ],
            ),
          )
        )
      )
    );

  }

  submitLogin() async {

    print('login clkd');

    if(formKey.currentState != null && formKey.currentState!.validate()){
      Map<String, dynamic> body = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      BlocProvider.of<LoginBloc>(context).add(LoginWithEmail(body: body));

      // APIClient client = APIClient();
      // await client.postAuthData(pathSegment: APIConstants.LOGIN_SEGMENT, body: body);
    }

  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

}