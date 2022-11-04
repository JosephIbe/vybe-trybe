import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';

import 'package:trybe_one_mobile/data/core/api_client.dart';
import 'package:trybe_one_mobile/data/core/api_constants.dart';
import 'package:trybe_one_mobile/data/core/db_constants.dart';

import 'package:trybe_one_mobile/data/models/life_update/countries_model.dart';
import 'package:trybe_one_mobile/data/models/life_update/schools_model.dart';

import 'package:trybe_one_mobile/presentation/blocs/life_update_pages/life_update_pages_bloc.dart';
import 'package:trybe_one_mobile/presentation/blocs/life_update_pages/life_update_pages_event.dart';

import 'package:trybe_one_mobile/presentation/journeys/themes/app_colors.dart';

import 'package:trybe_one_mobile/presentation/widgets/onboarding/regular_button.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import 'package:http_parser/http_parser.dart';

class StudentLifeUpdateView extends StatefulWidget {

  const StudentLifeUpdateView({Key? key}) : super(key: key);

  @override
  _StudentLifeUpdateViewState createState() => _StudentLifeUpdateViewState();
}

late Size size;

class _StudentLifeUpdateViewState extends State<StudentLifeUpdateView> {

  bool hasSelectedCountry = false;
  bool hasSelectedSchool = false;

  late String selectedCountry;
  late String selectedCountryISO;
  late String selectedSchool;

  List<CountriesModel>  allCountriesList = [];
  List<CountriesModel> searchedCountries = [];

  List<SchoolsModel>  allSchoolsList = [];
  List<SchoolsModel> searchedSchools = [];

  bool hasSelectedSchoolAndCountry = false;

  File? selectedImage;
  File? selectedDocument;

  bool hasSelectedImage = false;
  bool hasSelectedDocument = false;

  APIClient client = APIClient();

  late Box box;

  @override
  void initState() {
    super.initState();

    box = Hive.box(DBConstants.userBoxName);

    setState(() {
      searchedCountries = allCountriesList;
      searchedSchools = allSchoolsList;
    });

    getCountries();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(hasSelectedCountry && selectedCountryISO.isNotEmpty){
      getSchoolsInCountry();
    }
  }

  Future<List<CountriesModel>> getCountries() async {
    return await client.getCountriesData(pathSegment: APIConstants.COUNTRIES_SEGMENT);
  }

  Future<List<SchoolsModel>> getSchoolsInCountry() async {
    var response = await client.getSchoolsByCountry(
      pathSegment: '${APIConstants.SCHOOLS_BY_COUNTRY_SEGMENT}/$selectedCountryISO',
      countryISO: selectedCountryISO
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    print('life update type:\t${box.get(DBConstants.lifeUpdateType)}');

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: Sizes.dimen_80,
              decoration: BoxDecoration(
                color: TrybeColors.primaryRed.withOpacity(0.1),
                borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
              ),
              padding: const EdgeInsets.fromLTRB(
                  Sizes.dimen_15, Sizes.dimen_0, Sizes.dimen_15, Sizes.dimen_5
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: Sizes.dimen_40,
                        height: Sizes.dimen_40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: TrybeColors.primaryRed.withOpacity(0.2),
                        ),
                        child: Center(
                          child: Image.asset('assets/images/book.png'),
                        ),
                      ),
                      const SizedBox(width: Sizes.dimen_10),
                      const Text(
                          TextLiterals.student,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: Sizes.dimen_16,
                              color: Colors.black
                          )
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      BlocProvider.of<LifeUpdatePagesBloc>(context).add(LoadDefaultLifeUpdatePage());
                      box.delete(DBConstants.lifeUpdateType);
                      print('life update type after close:\t${box.get(DBConstants.lifeUpdateType)}');
                    },
                    child: Container(
                      width: Sizes.dimen_24,
                      height: Sizes.dimen_24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: TrybeColors.primaryRed.withOpacity(0.2),
                      ),
                      child: Center(
                        child: Image.asset('assets/images/close.png'),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: Sizes.dimen_20),

            Container(
              constraints: const BoxConstraints(
                minHeight: Sizes.dimen_70,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.dimen_15,
                vertical: Sizes.dimen_15,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Sizes.dimen_7)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /**
                   *  Country Selector
                   * **/
                  const Text(
                      TextLiterals.schoolCountryLocation,
                      style: TextStyle(
                        fontSize: Sizes.dimen_14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      )
                  ),
                  const SizedBox(height: Sizes.dimen_10),
                  Column(
                      children: [
                        hasSelectedCountry
                            ? Row(
                          children: [
                            Text(
                                selectedCountry,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Sizes.dimen_16
                                )
                            ),
                            const SizedBox(width: Sizes.dimen_10),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: (context),
                                    elevation: 2.0,
                                    isDismissible: false,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(Sizes.dimen_10), topLeft: Radius.circular(Sizes.dimen_10)),
                                    ),
                                    builder: (context) {
                                      return countriesList();
                                    }
                                );
                              },
                              child: const Text(
                                  TextLiterals.change,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: Sizes.dimen_12
                                  )
                              ),
                            ),
                          ],
                        )
                            : GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: (context),
                                  elevation: 2.0,
                                  isDismissible: false,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(Sizes.dimen_10), topLeft: Radius.circular(Sizes.dimen_10)),
                                  ),
                                  builder: (context) {
                                    return countriesList();
                                  }
                              );
                            },
                            child: Container(
                              width: size.width,
                              height: Sizes.dimen_50,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_10)),
                                  border: Border.all(
                                      color: TrybeColors.gray,
                                      width: Sizes.dimen_1
                                  )
                              ),
                            )
                        ),
                        const SizedBox(height: Sizes.dimen_30),
                      ]
                  ),
                  /**
                   *  School in Country Selector
                   * **/
                  AnimatedOpacity(
                    duration: const Duration(seconds: 3),
                    opacity: hasSelectedCountry
                        ? 1.0 : 0.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                            TextLiterals.schoolInCountry,
                            style: TextStyle(
                              fontSize: Sizes.dimen_14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )
                        ),
                        const SizedBox(height: Sizes.dimen_10),
                        hasSelectedSchool
                            ? Row(
                          children: [
                            Text(
                                selectedSchool,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Sizes.dimen_16
                                )
                            ),
                            const SizedBox(width: Sizes.dimen_10),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    context: (context),
                                    elevation: 2.0,
                                    isDismissible: false,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(Sizes.dimen_10), topLeft: Radius.circular(Sizes.dimen_10)),
                                    ),
                                    builder: (context) => schoolsInCountryList(context)
                                );
                              },
                              child: const Text(
                                  TextLiterals.change,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: Sizes.dimen_12
                                  )
                              ),
                            ),
                          ],
                        )
                            : GestureDetector(
                            onTap: (){
                              showModalBottomSheet(
                                  context: context,
                                  elevation: 2.0,
                                  isDismissible: false,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(Sizes.dimen_10), topLeft: Radius.circular(Sizes.dimen_10)),
                                  ),
                                  builder: (_) => schoolsInCountryList(context)
                              );
                            },
                            child: Container(
                              width: size.width,
                              height: Sizes.dimen_50,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_10)),
                                  border: Border.all(
                                      color: TrybeColors.gray,
                                      width: Sizes.dimen_1
                                  )
                              ),
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: Sizes.dimen_20),

            hasSelectedSchoolAndCountry
                ? Container(
                constraints: const BoxConstraints(
                  minHeight: Sizes.dimen_140,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.dimen_15,
                  vertical: Sizes.dimen_15,
                ),
                decoration: BoxDecoration(
                    color: TrybeColors.lightGray,
                    borderRadius: BorderRadius.circular(Sizes.dimen_7)
                ),
                child: hasSelectedImage || hasSelectedDocument
                    ? Container(
                    constraints: const BoxConstraints(
                      minHeight: Sizes.dimen_100,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.dimen_15,
                      vertical: Sizes.dimen_15,
                    ),
                    decoration: BoxDecoration(
                        color: TrybeColors.lightGray,
                        borderRadius: BorderRadius.circular(Sizes.dimen_7)
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_5)),
                            child: Image.file(selectedImage!, height: Sizes.dimen_96, width: Sizes.dimen_72, fit: BoxFit.cover,),
                          ),
                          const SizedBox(width: Sizes.dimen_10),
                          GestureDetector(
                              onTap: ()=> showModalBottomSheet(
                                  context: (context),
                                  elevation: 2.0,
                                  isDismissible: false,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(Sizes.dimen_10), topLeft: Radius.circular(Sizes.dimen_10)),
                                  ),
                                  builder: (context) => showDocumentPicker(context)
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.dimen_10,
                                  vertical: Sizes.dimen_10,
                                ),
                                child: Text(
                                    TextLiterals.changePicture,
                                    style: TextStyle(
                                      fontSize: Sizes.dimen_14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    )
                                ),
                              )
                          )
                        ]
                    )
                )
                    : Column(
                    children: [
                      GestureDetector(
                          onTap: ()=> showModalBottomSheet(
                            context: (context),
                            elevation: 2.0,
                            isDismissible: false,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(Sizes.dimen_10), topLeft: Radius.circular(Sizes.dimen_10)),
                            ),
                            builder: (context) => showDocumentPicker(context),
                          ),
                          child: Row(
                            children: [
                              Container(
                                  width: Sizes.dimen_40,
                                  height: Sizes.dimen_40,
                                  decoration: BoxDecoration(
                                    color: TrybeColors.primaryRed.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                      child: Image.asset('assets/images/admission_letter.png')
                                  )
                              ),
                              const SizedBox(width: Sizes.dimen_10),
                              const Text(
                                  TextLiterals.uploadAdmissionLetter,
                                  style: TextStyle(
                                      fontSize: Sizes.dimen_16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                                  )
                              ),
                            ],
                          )
                      ),
                      const SizedBox(height: Sizes.dimen_20),
                      GestureDetector(
                          onTap: ()=> showModalBottomSheet(
                              context: (context),
                              elevation: 2.0,
                              isDismissible: false,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(Sizes.dimen_10), topLeft: Radius.circular(Sizes.dimen_10)),
                              ),
                              builder: (context) => showDocumentPicker(context)
                          ),
                          child: Row(
                            children: [
                              Container(
                                  width: Sizes.dimen_40,
                                  height: Sizes.dimen_40,
                                  decoration: BoxDecoration(
                                    color: TrybeColors.primaryRed.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                      child: Image.asset('assets/images/admission_letter.png')
                                  )
                              ),
                              const SizedBox(width: Sizes.dimen_10),
                              const Text(
                                  TextLiterals.uploadSchoolIdCard,
                                  style: TextStyle(
                                      fontSize: Sizes.dimen_16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                                  )
                              ),
                            ],
                          )
                      ),
                    ]
                )
            )
                : Container(),
            const SizedBox(height: Sizes.dimen_20),
            Opacity(
                opacity: hasSelectedSchoolAndCountry && hasSelectedImage || hasSelectedDocument? 1.0 : 0.0,
                child: AuthenticationButton(
                  isEnabled: hasSelectedSchoolAndCountry && hasSelectedImage || hasSelectedDocument,
                  onClicked: ()=> submitLifeUpdate(),
                  title: TextLiterals.continueText,
                ),
            )
          ],
        ),
      ),
    );

  }

  submitLifeUpdate() async {

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        selectedImage!.path,
        filename: selectedImage!.path.split('/').last,
        contentType: MediaType('image', '*'),
      ),
      'userType': box.get(DBConstants.lifeUpdateType),
      'schoolName': selectedSchool,
      'schoolLocation': selectedCountry,
    });

    APIClient client = APIClient();
    await client.submitLifeUpdateType(pathSegment: APIConstants.LIFE_UPDATE_SEGMENT, body: formData,);
    box.put(DBConstants.isFromEmployedCategory, false);
    Navigator.pushNamed(context, RouteLiterals.bvnSignUpTypeRoute);
  }

  Widget countriesList() {
    return ClipRRect(
        borderRadius: const BorderRadius.only(topRight: Radius.circular(Sizes.dimen_10), topLeft: Radius.circular(Sizes.dimen_10)),
        child: FractionallySizedBox(
            heightFactor: 0.75,
            child: FutureBuilder<List<CountriesModel>>(
              future: getCountries(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  allCountriesList = snapshot.data!;
                  searchedCountries = allCountriesList;
                  print('scl:\n$searchedCountries');
                  return Container(
                    width: size.width,
                    height: Sizes.dimen_500,
                    padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.dimen_32,
                        vertical: Sizes.dimen_11
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: ()=> Navigator.pop(context),
                            child: Container(
                              width: Sizes.dimen_24,
                              height: Sizes.dimen_24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: TrybeColors.primaryRed.withOpacity(0.2),
                              ),
                              child: Image.asset('assets/images/close.png'),
                            ),
                          ),
                        ),
                        const SizedBox(height: Sizes.dimen_20),
                        TextFormField(
                          onChanged: (value) => _filterCountries(value),
                          decoration: InputDecoration(
                            hintText: TextLiterals.searchCountries,
                            suffixIcon: IconButton(
                              onPressed: ()=>{},
                              icon: const Icon(Icons.search, color: TrybeColors.primaryRed,),
                            ),
                          ),
                        ),
                        searchedCountries.isNotEmpty
                            ? Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: searchedCountries.length,
                            separatorBuilder: (context, index) => const Divider(height: Sizes.dimen_1,),
                            itemBuilder: (context, index){
                              return ListTile(
                                onTap: (){
                                  setState((){
                                      selectedCountry = allCountriesList[index].nicename!;
                                      selectedCountryISO = allCountriesList[index].iso!;
                                      hasSelectedCountry = true;
                                    }
                                  );
                                  Navigator.pop(context);
                                },
                                contentPadding: const EdgeInsets.symmetric(vertical: Sizes.dimen_10),
                                title: Text(allCountriesList[index].nicename!),
                              );
                            },
                          ),
                        )
                            : const Center(
                          child: Text(
                            'No results found',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: Sizes.dimen_14
                            ),
                          ),
                        ),
                      ]
                    ),
                  );
                } else {
                  return Container(
                    width: size.width,
                    height: Sizes.dimen_500,
                    padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.dimen_32,
                        vertical: Sizes.dimen_11
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    )
                  );
                }
              },
            )
        )
    );
  }

  Widget schoolsInCountryList(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topRight: Radius.circular(Sizes.dimen_10), topLeft: Radius.circular(Sizes.dimen_10)),
      child: FractionallySizedBox(
        heightFactor: 0.75,
        child: FutureBuilder<List<SchoolsModel>>(
          future: getSchoolsInCountry(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              allSchoolsList = snapshot.data!;
              searchedSchools = snapshot.data!;
              return Container(
                width: size.width,
                height: Sizes.dimen_500,
                padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_32,
                    vertical: Sizes.dimen_11
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: ()=> Navigator.pop(context),
                        child: Container(
                          width: Sizes.dimen_24,
                          height: Sizes.dimen_24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: TrybeColors.primaryRed.withOpacity(0.2),
                          ),
                          child: Image.asset('assets/images/close.png'),
                        ),
                      ),
                    ),
                    const SizedBox(height: Sizes.dimen_20),
                    TextFormField(
                      onChanged: (value) => _filterSchoolsInCountry(value),
                      decoration: InputDecoration(
                        hintText: TextLiterals.searchSchoolsInCountry,
                        suffixIcon: IconButton(
                          onPressed: ()=>{},
                          icon: const Icon(Icons.search, color: TrybeColors.primaryRed,),
                        ),
                      ),
                    ),
                    searchedSchools.isNotEmpty
                        ? Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: searchedSchools.length,
                        separatorBuilder: (_, index) => const Divider(color: TrybeColors.listItemDividerColor, height: Sizes.dimen_1,),
                        padding: const EdgeInsets.all(Sizes.dimen_16),
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: (){
                              Navigator.pop(context);
                              setState(()=> {
                                hasSelectedSchool = true,
                                selectedSchool = searchedSchools[index].name!,
                                hasSelectedSchoolAndCountry = true
                              });
                            },
                            title: Text(
                              searchedSchools[index].name!,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: Sizes.dimen_14
                              ),
                            ),
                          );
                        },
                      ),
                    )
                        : const Center(
                      child: Text(
                        'No results found',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: Sizes.dimen_14
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                  width: size.width,
                  height: Sizes.dimen_500,
                  padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.dimen_32,
                      vertical: Sizes.dimen_11
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  )
              );
            }
          }
        ),
      ),
    );
  }

  void _filterCountries(String value) {
    dynamic results = [];
    if(value.isEmpty) {
      results = allCountriesList;
    } else {
      results = searchedCountries.where((country) => country.toLowerCase().contains(value.toLowerCase())).toList();
      setState(()=> searchedCountries = results);
    }
  }

  void _filterSchoolsInCountry(String value) {
    dynamic results = [];
    if(value.isEmpty) {
      results = allSchoolsList;
    } else {
      results = allSchoolsList.where((school) => school.toLowerCase().contains(value.toLowerCase())).toList();
      setState(()=> searchedSchools = results);
    }
  }

  showDocumentPicker(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topRight: Radius.circular(Sizes.dimen_10), topLeft: Radius.circular(Sizes.dimen_10)),
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.dimen_28,
          vertical: Sizes.dimen_11
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: ()=> Navigator.pop(context),
                  child: Container(
                    width: Sizes.dimen_24,
                    height: Sizes.dimen_24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: TrybeColors.primaryRed.withOpacity(0.2),
                    ),
                    child: Image.asset('assets/images/close.png'),
                  ),
                ),
              ),
              const SizedBox(height: Sizes.dimen_10),

              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  selectImage(source: ImageSource.camera, context: context);
                },
                child: Container(
                  width: size.width,
                  height: Sizes.dimen_80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_15,
                    vertical: Sizes.dimen_20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
                    color: TrybeColors.primaryRed.withOpacity(0.1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: Sizes.dimen_40,
                        height: Sizes.dimen_40,
                        decoration: BoxDecoration(
                          color: TrybeColors.primaryRed.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset('assets/images/camera.png'),
                      ),
                      const SizedBox(width: Sizes.dimen_10),
                      const Text(
                        TextLiterals.takePicture,
                        style: TextStyle(
                          fontSize: Sizes.dimen_16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )
                      )
                    ]
                  ),
                ),
              ),
              const SizedBox(height: Sizes.dimen_19),

              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  selectImage(source: ImageSource.gallery, context: context);
                },
                child: Container(
                  width: size.width,
                  height: Sizes.dimen_80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_15,
                    vertical: Sizes.dimen_20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
                    color: TrybeColors.primaryRed.withOpacity(0.1),
                  ),
                  child: Row(
                      children: [
                        Container(
                            width: Sizes.dimen_40,
                            height: Sizes.dimen_40,
                            decoration: BoxDecoration(
                              color: TrybeColors.primaryRed.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                          child: Image.asset('assets/images/gallery.png'),
                        ),
                        const SizedBox(width: Sizes.dimen_10),
                        const Text(
                            TextLiterals.uploadFromGallery,
                            style: TextStyle(
                              fontSize: Sizes.dimen_16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )
                        )
                      ]
                  ),
                ),
              ),
              const SizedBox(height: Sizes.dimen_19),

              GestureDetector(
                onTap: ()=> {
                  Navigator.pop(context),
                  selectDocument(),
                },
                child: Container(
                  width: size.width,
                  height: Sizes.dimen_80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_15,
                    vertical: Sizes.dimen_20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
                    color: TrybeColors.primaryRed.withOpacity(0.1),
                  ),
                  child: Row(
                      children: [
                        Container(
                            width: Sizes.dimen_40,
                            height: Sizes.dimen_40,
                            decoration: BoxDecoration(
                              color: TrybeColors.primaryRed.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                          child: Image.asset('assets/images/gallery.png'),
                        ),
                        const SizedBox(width: Sizes.dimen_10),
                        const Text(
                            TextLiterals.uploadDocument,
                            style: TextStyle(
                              fontSize: Sizes.dimen_16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )
                        )
                      ]
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  selectImage({required ImageSource source, required BuildContext context}) async {
    try {
      final image = await ImagePicker().pickImage(source: source, preferredCameraDevice: CameraDevice.front);
      if(image == null) {
        setState(()=> hasSelectedImage = false);
      } else {
        final tempImage = File(image.path);
        setState(() {
          selectedImage = tempImage;
          hasSelectedImage = true;
        });
        print(hasSelectedImage);
      }
    } on PlatformException catch(e) {
      SnackBar snackBar = SnackBar(
        backgroundColor: TrybeColors.primaryRed,
        content: Text('${e.message}'),
        duration: const Duration(milliseconds: 2500),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  selectDocument() async {}

}