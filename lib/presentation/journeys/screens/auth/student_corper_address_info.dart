import 'package:flutter/material.dart';
import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/data/core/api_client.dart';
import 'package:trybe_one_mobile/data/core/api_constants.dart';
import 'package:trybe_one_mobile/data/core/db_constants.dart';
import 'package:trybe_one_mobile/presentation/journeys/themes/app_colors.dart';
import 'package:trybe_one_mobile/presentation/widgets/kyc/kyc_header_text.dart';

import 'package:hive/hive.dart';
import 'package:okhi_flutter/okhi_flutter.dart';

class StudentAndCorpMemberAddressInfo extends StatefulWidget {

  const StudentAndCorpMemberAddressInfo({Key? key}) : super(key: key);

  @override
  _StudentAndCorpMemberAddressInfoState createState() => _StudentAndCorpMemberAddressInfoState();

}

late Size size;

class _StudentAndCorpMemberAddressInfoState extends State<StudentAndCorpMemberAddressInfo> {

  late String schoolStreetAddress;
  late String schoolState;

  late String houseStreetAddress;
  late String houseState;

  bool hasSetSchoolAddress = false;
  bool hasSetHouseAddress = false;

  bool isContinueButtonEnabled = false;
  bool isCollectingSchoolAddress = false;
  bool isCollectingHouseAddress = false;

  bool _launchLocationManager = false;
  late OkHiUser _user;

  int? setSelectedOption;
  late String selectedOptionValue;

  late String countryCodePhoneNumber;

  late Box box;

  @override
  void initState() {
    super.initState();

    box = Hive.box(DBConstants.userBoxName);

    final config = OkHiAppConfiguration(
      branchId: "EaBJBdk6zV",
      clientKey: "58a653ca-f099-4f6f-98a2-48124bfdb292",
      env: OkHiEnv.sandbox,
    );
    OkHi.initialize(config).then((result) {
      debugPrint(result.toString()); // returns true if initialization is successfull
    });

    selectedOptionValue = '';

    String phoneNumber = box.get(DBConstants.userPhoneNumber);
    var sub = phoneNumber.substring(0, phoneNumber.length);

    countryCodePhoneNumber = '+234' + sub;
    _user = OkHiUser(phone: countryCodePhoneNumber);

  }

  @override
  Widget build(BuildContext context) {

    String phoneNumber = box.get(DBConstants.userPhoneNumber);
    var sub = phoneNumber.substring(1, phoneNumber.length - 1);
    print('sub $sub');

    size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: buildBody()
      )
    );

  }

  Widget buildBody() {
    if(!_launchLocationManager) {
      return Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.fromLTRB(Sizes.dimen_22, Sizes.dimen_22, Sizes.dimen_22, Sizes.dimen_10),
        decoration: const BoxDecoration( color: Colors.white, ),
        child: SingleChildScrollView(
          child: Column(
              children: [
                const KYCHeaderText(
                  showStepCount: true,
                  stepTitle: TextLiterals.stepTwoOfFive,
                  title: TextLiterals.yourInfo,
                  description: TextLiterals.whereAreYouLocated,
                ),
                const SizedBox(height: Sizes.dimen_10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        TextLiterals.schoolLocation,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Sizes.dimen_16,
                          fontWeight: FontWeight.w500,
                        )
                    ),
                    const SizedBox(height: Sizes.dimen_10,),
                    hasSetSchoolAddress && !isCollectingSchoolAddress ? schoolAddressWidget() : addressLocation(
                        address: 'Tap to here to set address',
                        onTap: ()=> verifySchoolAddress()
                    ),
                    const SizedBox(height: Sizes.dimen_15,),

                    const Text(
                        TextLiterals.houseLocation,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Sizes.dimen_16,
                          fontWeight: FontWeight.w500,
                        )
                    ),
                    const SizedBox(height: Sizes.dimen_10,),
                    hasSetHouseAddress
                      ? houseAddressWidget()
                      : addressLocation(
                        address: 'Tap to here to set address',
                        onTap: ()=> verifyHouseAddress()
                    ),
                    const SizedBox(height: Sizes.dimen_20,),
                  ],
                ),

                Opacity(
                  opacity: hasSetSchoolAddress && hasSetHouseAddress ? 1.0 : 0.0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                            TextLiterals.debitCardDelivery,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.dimen_16,
                              fontWeight: FontWeight.w500,
                            )
                        ),
                        const Text(
                            TextLiterals.howToDeliverDebitCard,
                            style: TextStyle(
                              color: TrybeColors.gray,
                              fontSize: Sizes.dimen_13,
                              fontWeight: FontWeight.w500,
                            )
                        ),
                        const SizedBox(height: Sizes.dimen_10),

                        RadioListTile(
                          title: const Text(
                              'To my school address (Charges will apply)',
                              style: TextStyle(
                                fontSize: Sizes.dimen_14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              )
                          ),
                          value: 1,
                          groupValue: setSelectedOption,
                          onChanged: (value){
                            setState((){
                              setSelectedOption = value as int?;
                              selectedOptionValue = 'To my school address (Charges will apply)';
                            });
                            print(selectedOptionValue);
                          },
                        ),
                        RadioListTile(
                          title: const Text(
                              'To my house address (Charges will apply)',
                              style: TextStyle(
                                fontSize: Sizes.dimen_14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              )
                          ),
                          value: 2,
                          groupValue: setSelectedOption,
                          onChanged: (value){
                            setState((){
                              setSelectedOption = value as int?;
                              selectedOptionValue = 'To my house address (Charges will apply)';
                            });
                            print(selectedOptionValue);
                          },
                        ),
                        RadioListTile(
                          title: const Text(
                              'To the nearest Sterling Bank branch (free)',
                              style: TextStyle(
                                fontSize: Sizes.dimen_14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              )
                          ),
                          value: 3,
                          groupValue: setSelectedOption,
                          onChanged: (value){
                            setState((){
                              setSelectedOption = value as int?;
                              selectedOptionValue = 'To the nearest Sterling Bank branch (free)';
                            });
                            print(selectedOptionValue);
                          },
                        ),
                      ]
                  ),
                ),

                const SizedBox(height: Sizes.dimen_30,),
                Opacity(
                  opacity: hasSetSchoolAddress && hasSetHouseAddress && selectedOptionValue.isNotEmpty ? 1.0 : 0.0,
                  child: Row(
                    children: [
                      // Expanded(
                      //   flex: 1,
                      //   child: GestureDetector(
                      //     onTap: ()=> Navigator.pop(context),
                      //     child: Container(
                      //       height: Sizes.dimen_50,
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
                      //         border: Border.all(color: TrybeColors.gray, width: Sizes.dimen_1),
                      //       ),
                      //       child: const Center(
                      //         child: Text(
                      //           TextLiterals.goBack,
                      //           style: TextStyle(
                      //               color: TrybeColors.gray,
                      //               fontSize: Sizes.dimen_18,
                      //               fontWeight: FontWeight.w500
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(width: Sizes.dimen_10),

                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: ()=>
                            hasSetSchoolAddress && hasSetHouseAddress && selectedOptionValue.isNotEmpty
                            ? submitAddressInfoAndNavigateToProfileUtilities() : null,
                          child: Container(
                            height: Sizes.dimen_50,
                            decoration: BoxDecoration(
                              color: TrybeColors.primaryRed,
                              borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
                            ),
                            child: const Center(
                              child: Text(
                                TextLiterals.continueText,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Sizes.dimen_18,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ]
          ),
        ),
      );
    }

    return isCollectingSchoolAddress ?
      OkHiLocationManager(
        user: _user,
        onCloseRequest: _handleOnCloseSchoolAddressRequest,
        onError: _handleOnSchoolAddressError,
        onSucess: _handleOnSchoolAddressSuccess,
      ) : OkHiLocationManager(
          user: _user,
          onCloseRequest: _handleOnCloseHouseAddressRequest,
          onError: _handleOnHouseAddressError,
          onSucess: _handleOnHouseAddressSuccess,
      );
    }

  _handleOnCloseSchoolAddressRequest() {
    // user wants to exit the OkHiLocationManager experience
    setState(() {
      _launchLocationManager = false;
    });
  }

  _handleOnCloseHouseAddressRequest() {
    // user wants to exit the OkHiLocationManager experience
    setState(() {
      _launchLocationManager = false;
    });
  }

  _handleOnSchoolAddressError(OkHiException error) {
    // handle OkHiLocationManager errors here
    setState(() {
      _launchLocationManager = false;
    });
  }

  _handleOnHouseAddressError(OkHiException error) {
    // handle OkHiLocationManager errors here
    setState(() {
      _launchLocationManager = false;
    });
  }

  _handleOnSchoolAddressSuccess(OkHiLocationManagerResponse response) async {
    // response.user - user information
    // response.location - address information
    setState(() {
      _launchLocationManager = false;
      hasSetSchoolAddress = true;
      schoolStreetAddress = response.location.displayTitle!;
      schoolState = response.location.state!;
    });

    print('okhi response\t $response');
    print('response.location\t ${response.location}');

    String result = await response.startVerification(null); // start address verification with default configuration

    SnackBar addressBar = const SnackBar(
      content: Text('Started Verifying Your Address...'),
      elevation: Sizes.dimen_2,
      duration: Duration(milliseconds: 2500),
      backgroundColor: TrybeColors.mediumDarkGray,
    );
    ScaffoldMessenger.of(context).showSnackBar(addressBar);
  }

  _handleOnHouseAddressSuccess(OkHiLocationManagerResponse response) async {
    // response.user - user information
    // response.location - address information
    setState(() {
      _launchLocationManager = false;
      hasSetHouseAddress = true;
      houseStreetAddress = response.location.displayTitle!;
      houseState = response.location.state!;
    });

    print('okhi response\t $response');
    print('response.location\t ${response.location}');

    String result = await response.startVerification(null); // start address verification with default configuration

    SnackBar addressBar = const SnackBar(
      content: Text('Started Verifying Your School Address...'),
      elevation: Sizes.dimen_2,
      duration: Duration(milliseconds: 2500),
      backgroundColor: TrybeColors.mediumDarkGray,
    );
    ScaffoldMessenger.of(context).showSnackBar(addressBar);
  }

  verifySchoolAddress() async {

    setState(() {
      isCollectingSchoolAddress = true;
      isCollectingHouseAddress = false;
    });

    final result = await OkHi.canStartVerification(true);
    setState(() => _launchLocationManager = result);

    return OkHiLocationManager(
      user: _user,
      onCloseRequest: _handleOnCloseSchoolAddressRequest,
      onError: _handleOnSchoolAddressError,
      onSucess: _handleOnSchoolAddressSuccess,
    );

  }

  verifyHouseAddress() async {

    setState(() {
      isCollectingHouseAddress = true;
      isCollectingSchoolAddress = false;
    });

    final result = await OkHi.canStartVerification(true);
    setState(() => _launchLocationManager = result);

    return OkHiLocationManager(
      user: _user,
      onCloseRequest: _handleOnCloseHouseAddressRequest,
      onError: _handleOnHouseAddressError,
      onSucess: _handleOnHouseAddressSuccess,
    );

  }

  Widget addressLocation({required String address, required VoidCallback onTap}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width,
        height: Sizes.dimen_80,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_10)),
          color: TrybeColors.lightGray3.withOpacity(0.15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/location_pin.png'),
            const SizedBox(width: Sizes.dimen_10),
            Text(
              address,
              style: const TextStyle(
                color: Colors.black,
                fontSize: Sizes.dimen_14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget schoolAddressWidget(){
    return Container(
      width: size.width,
      height: Sizes.dimen_80,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_10)),
        color: TrybeColors.lightGray3.withOpacity(0.15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/location_pin.png'),
          const SizedBox(width: Sizes.dimen_10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                schoolStreetAddress.substring(0, 15),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: Sizes.dimen_12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                schoolState,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: Sizes.dimen_12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              GestureDetector(
                onTap: ()=>  verifySchoolAddress(),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(Sizes.dimen_0, Sizes.dimen_2, Sizes.dimen_0, Sizes.dimen_0),
                  child: Text(
                    TextLiterals.tapChange,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Sizes.dimen_12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget houseAddressWidget(){
    return Container(
      width: size.width,
      height: Sizes.dimen_80,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_10)),
        color: TrybeColors.lightGray3.withOpacity(0.15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/location_pin.png'),
          const SizedBox(width: Sizes.dimen_10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                houseStreetAddress.substring(0, 15),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: Sizes.dimen_12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                houseState,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: Sizes.dimen_12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              GestureDetector(
                onTap: ()=>  verifyHouseAddress(),
                child: const Text(
                  TextLiterals.tapChange,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Sizes.dimen_10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  submitAddressInfoAndNavigateToProfileUtilities() async {

    final data = {
      'address': houseStreetAddress,
      'address_school': schoolStreetAddress,
      'userType': box.get(DBConstants.lifeUpdateType),
      'debit_card_delivery': selectedOptionValue,
    };

    APIClient client = APIClient();
    await client.updateAddress(pathSegment: APIConstants.UPDATE_ADDRESS, body: data);

    Navigator.pushNamed(context, RouteLiterals.uploadProfilePictureRoute);

  }

}