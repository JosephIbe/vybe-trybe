import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:trybe_one_mobile/common/constants/text_constants.dart';

import 'package:trybe_one_mobile/data/core/db_constants.dart';

import 'package:trybe_one_mobile/presentation/journeys/screens/auth/login.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/user_interests.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/intro/page_one.dart';

import 'package:trybe_one_mobile/utils/router.dart';

class TrybeOneApp extends StatefulWidget {

  const TrybeOneApp({Key? key}) : super(key: key);

  @override
  State<TrybeOneApp> createState() => _TrybeOneAppState();
}

class _TrybeOneAppState extends State<TrybeOneApp> {

  late Box box;
  late var hasViewedIntroScreens;

  @override
  void initState() {
    super.initState();
    box = Hive.box(DBConstants.userBoxName);
    hasViewedIntroScreens = box.get(DBConstants.hasViewedIntroScreens);
    print('hvis value initstate is:\t$hasViewedIntroScreens');
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: TextLiterals.appName,
      onGenerateRoute: TrybeOneRouter.generateRoute,
      builder: EasyLoading.init(),
      // home: const UserInterests(),
      home: hasViewedIntroScreens != null ? const Login() : const OnboardingPageOne(),
      // home: const UserInterests(),

      // home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
      //   builder: (context, state){
      //     if(state is AuthenticationStateAuthenticated){
      //       UserModel user = state.user;
      //       return const Dashboard();
      //     }
      //     return const Login();
      //   },
      // ),
      // home: LifeUpdate(),
      // home: UploadProfilePicture()
      // home: UtilityBills(),

    );
  }
}