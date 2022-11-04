import 'package:trybe_one_mobile/data/core/api_client.dart';
import 'package:trybe_one_mobile/data/core/api_constants.dart';
import 'package:trybe_one_mobile/data/models/life_update/countries_model.dart';
import 'package:trybe_one_mobile/data/models/life_update/countries_response_model.dart';
import 'package:trybe_one_mobile/data/models/life_update/schools_model.dart';
import 'package:trybe_one_mobile/data/models/life_update/schools_response_model.dart';

abstract class LifeUpdateRemoteDataSource {
  Future<List<CountriesModel>> fetchAllCountries();
  Future<List<SchoolsModel>> fetchSchoolByCountry({required String countryISO});
}

class LifeUpdateRemoteDataSourceImpl extends LifeUpdateRemoteDataSource {

  final APIClient client;
  LifeUpdateRemoteDataSourceImpl({required this.client});

  List<CountriesModel> allCountries = [];
  List<SchoolsModel> schoolsList = [];

  @override
  Future<List<CountriesModel>> fetchAllCountries() async {
    final response = await client.getCountriesData(
      pathSegment: APIConstants.COUNTRIES_SEGMENT
    );
    // print('countriesResponse in data src:\n$response');
    allCountries = CountriesResponseModel.fromJson(response).data!;
    // print('parsed countriesResponse in data src:\n$response');
    return allCountries;
  }

  @override
  Future<List<SchoolsModel>> fetchSchoolByCountry({required String countryISO}) async {
    final response = await client.getSchoolsByCountry(
      pathSegment: APIConstants.SCHOOLS_BY_COUNTRY_SEGMENT,
      countryISO: countryISO
    );
    print('schools by country response:\n $response');
    schoolsList = SchoolsResponseModel.fromJson(response).data!;
    print('schools by country parsed response:\n $response');
    return schoolsList;
  }

}