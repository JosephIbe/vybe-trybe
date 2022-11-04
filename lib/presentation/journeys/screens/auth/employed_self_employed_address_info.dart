import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/data/core/api_client.dart';
import 'package:trybe_one_mobile/data/core/api_constants.dart';
import 'package:trybe_one_mobile/data/core/db_constants.dart';
import 'package:trybe_one_mobile/presentation/journeys/themes/app_colors.dart';
import 'package:trybe_one_mobile/presentation/widgets/kyc/kyc_header_text.dart';

import 'package:okhi_flutter/okhi_flutter.dart';

class EmployeeAndSelfEmployedAddressInfo extends StatefulWidget {

  const EmployeeAndSelfEmployedAddressInfo({Key? key}) : super(key: key);

  @override
  _EmployeeAndSelfEmployedAddressInfoState createState() => _EmployeeAndSelfEmployedAddressInfoState();
}

late Size size;

class _EmployeeAndSelfEmployedAddressInfoState extends State<EmployeeAndSelfEmployedAddressInfo> {

  late String streetAddress;
  late String state;

  bool hasSetAddress = false;

  bool isContinueButtonEnabled = false;
  bool isCollectingAddress = false;

  bool _launchLocationManager = false;
  final _user = OkHiUser(phone: '+2349066060485');

  int? setSelectedOption;
  late String selectedOptionValue;

  @override
  void initState() {
    super.initState();

    final config = OkHiAppConfiguration(
      branchId: "EaBJBdk6zV",
      clientKey: "58a653ca-f099-4f6f-98a2-48124bfdb292",
      env: OkHiEnv.sandbox,
    );
    OkHi.initialize(config).then((result) {
      debugPrint(result.toString()); // returns true if initialization is successfull
    });

    selectedOptionValue = '';

  }

  @override
  Widget build(BuildContext context) {

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
                        TextLiterals.location,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Sizes.dimen_16,
                          fontWeight: FontWeight.w500,
                        )
                    ),
                    const SizedBox(height: Sizes.dimen_10,),
                    hasSetAddress ? addressWidget() : addressLocation(
                        address: 'Tap to here to set address',
                        onTap: ()=> verifyAddress()
                    ),
                    const SizedBox(height: Sizes.dimen_20,),
                  ],
                ),

                Opacity(
                  opacity: hasSetAddress ? 1.0 : 0.0,
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
                  opacity: hasSetAddress && selectedOptionValue.isNotEmpty ? 1.0 : 0.0,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: ()=> Navigator.pop(context),
                          child: Container(
                            height: Sizes.dimen_50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
                              border: Border.all(color: TrybeColors.gray, width: Sizes.dimen_1),
                            ),
                            child: const Center(
                              child: Text(
                                TextLiterals.goBack,
                                style: TextStyle(
                                    color: TrybeColors.gray,
                                    fontSize: Sizes.dimen_18,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: Sizes.dimen_10),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: ()=>
                            hasSetAddress && selectedOptionValue.isNotEmpty
                                ? submitAddressInfoAndNavigateToProfileUtilities()
                                : null,
                          child: Container(
                            height: Sizes.dimen_50,
                            decoration: const BoxDecoration(
                              color: TrybeColors.primaryRed,
                              borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_7)),
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
    return OkHiLocationManager(
      user: _user,
      onCloseRequest: _handleOnCloseAddressRequest,
      onError: _handleOnAddressError,
      onSucess: _handleOnAddressSuccess,
    );
  }

  submitAddressInfoAndNavigateToProfileUtilities() async {

    print('e-se-submit-btn-clkd');

    var box = Hive.box(DBConstants.userBoxName);

    final data = {
      'address': streetAddress,
      'address_school': '',
      'userType': box.get(DBConstants.lifeUpdateType),
      'debit_card_delivery': selectedOptionValue,
    };

    APIClient client = APIClient();
    await client.updateAddress(pathSegment: APIConstants.UPDATE_ADDRESS, body: data);

    Navigator.pushNamed(context, RouteLiterals.uploadProfilePictureRoute);

  }

  _handleOnCloseAddressRequest() {
    // user wants to exit the OkHiLocationManager experience
    setState(() {
      _launchLocationManager = false;
    });
  }

  _handleOnAddressError(OkHiException error) {
    // handle OkHiLocationManager errors here
    setState(() {
      _launchLocationManager = false;
    });
  }

  _handleOnAddressSuccess(OkHiLocationManagerResponse response) async {
    // response.user - user information
    // response.location - address information
    setState(() {
      _launchLocationManager = false;
      hasSetAddress = true;
      streetAddress = response.location.displayTitle!;
      state = response.location.state!;
    });

    print('okhi response\t $response');
    print('response.location\t ${response.location}');

    String result = await response.startVerification(null); // start address verification with default configuration

    // _showMessage("Address verification started",
    //     "Successfully started verification for: $result");

    SnackBar addressBar = const SnackBar(
      content: Text('Started Verifying Your Address...'),
      elevation: Sizes.dimen_2,
      duration: Duration(milliseconds: 2500),
      backgroundColor: TrybeColors.mediumDarkGray,
    );
    ScaffoldMessenger.of(context).showSnackBar(addressBar);

  }

  verifyAddress() async {

    setState(() {
      isCollectingAddress = true;
    });

    final result = await OkHi.canStartVerification(true);
    setState(() => _launchLocationManager = result);

    return OkHiLocationManager(
      user: _user,
      onCloseRequest: _handleOnCloseAddressRequest,
      onError: _handleOnAddressError,
      onSucess: _handleOnAddressSuccess,
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

  Widget addressWidget(){
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
                streetAddress.substring(0, 15),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: Sizes.dimen_12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                state,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: Sizes.dimen_12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              GestureDetector(
                onTap: ()=>  verifyAddress(),
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

}