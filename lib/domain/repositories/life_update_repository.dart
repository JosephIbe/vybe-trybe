import 'package:trybe_one_mobile/data/models/life_update/countries_model.dart';
import 'package:trybe_one_mobile/data/models/life_update/schools_model.dart';

abstract class LifeUpdateRepository {
  Future<List<CountriesModel?>> fetchAllCountries();
  Future<List<SchoolsModel?>> fetchSchoolByCountry({required String countryISO});
}