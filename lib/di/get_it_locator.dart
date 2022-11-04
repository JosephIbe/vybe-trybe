import 'package:get_it/get_it.dart';
import 'package:trybe_one_mobile/data/core/api_client.dart';
import 'package:trybe_one_mobile/data/data_sources/remote/life_update_remote_data_source.dart';
import 'package:trybe_one_mobile/data/data_sources/remote/user_remote_data_source.dart';
import 'package:trybe_one_mobile/data/repositories/life_update_repository_impl.dart';
import 'package:trybe_one_mobile/data/repositories/user_repository_impl.dart';
import 'package:trybe_one_mobile/domain/repositories/life_update_repository.dart';
import 'package:trybe_one_mobile/domain/repositories/user_repository.dart';

final getItInstance = GetIt.instance;

Future<void> init() async {
  getItInstance.registerLazySingleton<APIClient>(() => APIClient());

  getItInstance.registerLazySingleton<UserRemoteDataSource>(
          () => UserRemoteDataSourceImpl(client: getItInstance()));
  getItInstance.registerLazySingleton<UserRepository>(
          () => UserRepositoryImpl(dataSource: getItInstance()));

  getItInstance.registerLazySingleton<LifeUpdateRemoteDataSource>(
          () => LifeUpdateRemoteDataSourceImpl(client: getItInstance()));
  getItInstance.registerLazySingleton<LifeUpdateRepository>(
          () => LifeUpdateRepositoryImpl(dataSource: getItInstance()));

}