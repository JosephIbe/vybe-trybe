import 'package:trybe_one_mobile/data/data_sources/remote/life_update_remote_data_source.dart';
import 'package:trybe_one_mobile/data/models/life_update/countries_model.dart';
import 'package:trybe_one_mobile/data/models/life_update/schools_model.dart';
import 'package:trybe_one_mobile/domain/repositories/life_update_repository.dart';

class LifeUpdateRepositoryImpl extends LifeUpdateRepository {

  LifeUpdateRemoteDataSource dataSource;
  LifeUpdateRepositoryImpl({required this.dataSource});

  @override
  Future<List<CountriesModel>> fetchAllCountries() async {
    return await dataSource.fetchAllCountries();
  }

  @override
  Future<List<SchoolsModel>> fetchSchoolByCountry({required String countryISO}) async {
    return await dataSource.fetchSchoolByCountry(countryISO: countryISO);
  }

}