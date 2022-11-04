import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/data/core/db_constants.dart';
import 'package:trybe_one_mobile/data/models/user/user_model.dart';

import 'package:trybe_one_mobile/domain/repositories/user_repository.dart';
import 'package:trybe_one_mobile/domain/repositories/life_update_repository.dart';

import 'package:trybe_one_mobile/data/repositories/user_repository_impl.dart';
import 'package:trybe_one_mobile/data/repositories/life_update_repository_impl.dart';
import 'package:trybe_one_mobile/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:trybe_one_mobile/presentation/blocs/authentication/authentication_state.dart';
import 'package:trybe_one_mobile/presentation/blocs/login/login_bloc.dart';

import 'package:trybe_one_mobile/presentation/journeys/screens/auth/student_corper_address_info.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/kyc_basic_details.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/life_update.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/login.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/upload_profile_pic.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/utility_bills.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/dashboard/dashboard.dart';

import 'package:trybe_one_mobile/presentation/journeys/screens/intro/page_one.dart';

import 'package:trybe_one_mobile/presentation/blocs/life_update_pages/life_update_pages_bloc.dart';
import 'package:trybe_one_mobile/presentation/blocs/life_update_pages/life_update_pages_state.dart';
import 'package:trybe_one_mobile/presentation/blocs/register/register_bloc.dart';
import 'package:trybe_one_mobile/presentation/blocs/register/register_state.dart';
import 'package:trybe_one_mobile/presentation/widgets/general/app.dart';

import 'package:trybe_one_mobile/utils/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pedantic/pedantic.dart';
import 'package:path_provider/path_provider.dart' as PathProvider;
import 'package:trybe_one_mobile/di/get_it_locator.dart' as getIt;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(getIt.init());
  await Hive.initFlutter();
  await Hive.openBox(DBConstants.userBoxName);
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value)=> {
    runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserRepository>(
            create: (context) =>
            UserRepositoryImpl(dataSource: getIt.getItInstance()),
          ),
          RepositoryProvider<LifeUpdateRepository>(
            create: (context) =>
                LifeUpdateRepositoryImpl(dataSource: getIt.getItInstance()),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthenticationBloc>(
              create: (context) {
                return AuthenticationBloc(repository: getIt.getItInstance());
              },
            ),
            BlocProvider<RegisterBloc>(
              create: (context) {
                return RegisterBloc(repository: getIt.getItInstance());
              },
            ),
            BlocProvider<LoginBloc>(
              create: (context) {
                return LoginBloc(repository: getIt.getItInstance(),);
              },
            ),
            BlocProvider<LifeUpdatePagesBloc>(
                create: (context) {
                  return LifeUpdatePagesBloc(LifeUpdatePagesStateInitial());
                }
            ),
          ],
          child: const TrybeOneApp(),
        ),
      )
    )
  });
}