import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/create_password_confirmation.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/employed_self_employed_address_info.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/lets_go.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/student_corper_address_info.dart';

import 'package:trybe_one_mobile/presentation/journeys/screens/auth/bvn_sign_up_type.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/create_password.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/forgot_mail_confirmation.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/forgot_password.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/kyc_basic_details.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/kyc_bvn.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/life_update.dart';

import 'package:trybe_one_mobile/presentation/journeys/screens/auth/register.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/login.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/upload_profile_pic.dart';

import 'package:trybe_one_mobile/presentation/journeys/screens/auth/user_agreement.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/user_interests.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/utility_bills.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/verify_email.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/verify_password_reset_code.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/dashboard/dashboard.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/intro/page_one.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/intro/page_two.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/intro/page_three.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/intro/page_four.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/intro/page_five.dart';

class TrybeOneRouter {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case RouteLiterals.onboardingOne:
        return CupertinoPageRoute(builder: (_)=> const OnboardingPageOne());
      case RouteLiterals.onboardingTwo:
        return CupertinoPageRoute(builder: (_)=> const OnboardingPageTwo());
      case RouteLiterals.onboardingThree:
        return CupertinoPageRoute(builder: (_)=> const OnboardingPageThree());
      case RouteLiterals.onboardingFour:
        return CupertinoPageRoute(builder: (_)=> const OnboardingPageFour());
      case RouteLiterals.onboardingFive:
        return CupertinoPageRoute(builder: (_)=> const OnboardingPageFive());
      case RouteLiterals.loginRoute:
        return CupertinoPageRoute(builder: (_)=> const Login());
      case RouteLiterals.forgotPasswordRoute:
        return CupertinoPageRoute(builder: (_)=> const ForgotPassword());
      case RouteLiterals.forgotPasswordMailConfirmationRoute:
        return CupertinoPageRoute(builder: (_)=> const ForgotPasswordEmailConfirmation());
      case RouteLiterals.verifyPasswordResetCodeRoute:
        return CupertinoPageRoute(builder: (_)=> const VerifyPasswordResetCode());
      case RouteLiterals.createPasswordRoute:
        return CupertinoPageRoute(builder: (_)=> const CreatePassword());
      case RouteLiterals.passwordChangedConfirmationRoute:
        return CupertinoPageRoute(builder: (_)=> const CreatedPasswordConfirmation());
      case RouteLiterals.registerRoute:
        return CupertinoPageRoute(builder: (_)=> const Register());
      case RouteLiterals.verifyEmailRoute:
        return CupertinoPageRoute(builder: (_)=> const VerifyEmail());
      case RouteLiterals.userAgreementRoute:
        return CupertinoPageRoute(builder: (_) => const UserAgreement());
      case RouteLiterals.lifeUpdateRoute:
        return CupertinoPageRoute(builder: (_) => const LifeUpdate());
      case RouteLiterals.bvnSignUpTypeRoute:
        return CupertinoPageRoute(builder: (_) => const BVNSignUpType());
      case RouteLiterals.kycBasicDetailsRoute:
        return CupertinoPageRoute(builder: (_) => const KYCBasicDetails());
      case RouteLiterals.kycBVNRoute:
        return CupertinoPageRoute(builder: (_) => const KYCBVN());
      case RouteLiterals.studentAndCorperAddressInfoRoute:
        return CupertinoPageRoute(builder: (_) => const StudentAndCorpMemberAddressInfo());
      case RouteLiterals.employeeSelfEmployedAddressInfo:
        return CupertinoPageRoute(builder: (_) => const EmployeeAndSelfEmployedAddressInfo());
      case RouteLiterals.uploadProfilePictureRoute:
        return CupertinoPageRoute(builder: (_) => const UploadProfilePicture());
      case RouteLiterals.utilityBillsRoute:
        return CupertinoPageRoute(builder: (_) => const UtilityBills());
      case RouteLiterals.interestsRoute:
        return CupertinoPageRoute(builder: (_) => const UserInterests());
      case RouteLiterals.letsGoRoute:
        return CupertinoPageRoute(builder: (_) => const OnboardingComplete());
      case RouteLiterals.dashboardRoute:
        return CupertinoPageRoute(builder: (_) => const Dashboard());
      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route specified for ${settings.name}'),
              ),
            )
        );
    }
  }
}