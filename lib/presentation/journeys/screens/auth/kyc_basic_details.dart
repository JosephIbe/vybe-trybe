import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/data/core/api_client.dart';
import 'package:trybe_one_mobile/data/core/api_constants.dart';
import 'package:trybe_one_mobile/data/core/db_constants.dart';
import 'package:trybe_one_mobile/presentation/journeys/themes/app_colors.dart';
import 'package:trybe_one_mobile/presentation/widgets/kyc/kyc_header_text.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/regular_button.dart';

class KYCBasicDetails extends StatefulWidget {

  const KYCBasicDetails({Key? key}) : super(key: key);

  @override
  _KYCBasicDetailsState createState() => _KYCBasicDetailsState();
}

late Size size;

class _KYCBasicDetailsState extends State<KYCBasicDetails> {

  final genderArray = ['Male', 'Female', 'Others'];
  String selectedGender = 'Gender';
  String selectedBirthDate = '1 Jan 1994';

  final formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();

  bool hasFirstName = false;
  bool hasLastName = false;
  bool hasPhoneNumber = false;

  late Box box;
  late bool hasBVN;

  @override
  void initState() {
    super.initState();
    box = Hive.box(DBConstants.userBoxName);

    hasBVN = box.get(DBConstants.hasBVN);
    print('hasBVN:$hasBVN');

  }

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    print('hasBVN:$hasBVN');

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.dimen_22,
            vertical: Sizes.dimen_40
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const KYCHeaderText(
                  showStepCount: true,
                  stepTitle: TextLiterals.stepOneOfFive,
                  title: TextLiterals.yourInfo,
                  description: TextLiterals.wedlikeToKnowYou,
                ),
                const SizedBox(height: Sizes.dimen_20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'BioData',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: TrybeColors.lightGray2,
                        fontSize: Sizes.dimen_18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: Sizes.dimen_20,),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'First Name',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Sizes.dimen_14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: Sizes.dimen_7),
                                    TextFormField(
                                      controller: firstNameController,
                                      onChanged: (value){
                                        if(value.length >= 3){
                                          setState(()=> hasFirstName = true);
                                        }
                                      },
                                      validator: (value){
                                        if(value!.length < 3){
                                          return 'First name is too short';
                                        } else if(value.isEmpty) {
                                          return 'Required';
                                        } else {
                                          return '';
                                        }
                                      },
                                      keyboardType: TextInputType.text,
                                      style: const TextStyle(
                                        fontSize: Sizes.dimen_14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: 'John',
                                        contentPadding: EdgeInsets.symmetric(vertical: Sizes.dimen_10, horizontal: Sizes.dimen_22),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_6)),
                                            borderSide: BorderSide(
                                                color: TrybeColors.gray,
                                                width: Sizes.dimen_1
                                            )
                                        ),
                                        hintStyle: TextStyle(
                                            fontSize: Sizes.dimen_14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ),
                              const SizedBox(width: Sizes.dimen_10),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Last Name',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Sizes.dimen_14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: Sizes.dimen_7),
                                    TextFormField(
                                      controller: lastNameController,
                                      onChanged: (value){
                                        if(value.length >= 3){
                                          setState(()=> hasLastName = true);
                                        }
                                      },
                                      validator: (value){
                                        if(value!.length < 3){
                                          return 'Last name is too short';
                                        } else if(value.isEmpty) {
                                          return 'Required';
                                        } else {
                                          return '';
                                        }
                                      },
                                      keyboardType: TextInputType.text,
                                      style: const TextStyle(
                                        fontSize: Sizes.dimen_14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                      decoration: const InputDecoration(
                                        hintText: 'Doe',
                                        contentPadding: EdgeInsets.symmetric(vertical: Sizes.dimen_10, horizontal: Sizes.dimen_22),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_6)),
                                            borderSide: BorderSide(
                                                color: TrybeColors.gray,
                                                width: Sizes.dimen_1
                                            )
                                        ),
                                        hintStyle: TextStyle(
                                            fontSize: Sizes.dimen_14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: Sizes.dimen_10),

                          const Text(
                            'Gender',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.dimen_14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: Sizes.dimen_7),
                          GestureDetector(
                            onTap: ()=> showGenderPickerDialog(),
                            child: Container(
                              width: size.width,
                              height: Sizes.dimen_50,
                              padding: const EdgeInsets.symmetric(
                                horizontal: Sizes.dimen_20,
                                vertical: Sizes.dimen_16,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: TrybeColors.gray, width: Sizes.dimen_1),
                                borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_6)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedGender,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: Sizes.dimen_14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Image.asset('assets/images/chevron_down.png'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: Sizes.dimen_10),

                          const Text(
                            'Birthday',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.dimen_14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: Sizes.dimen_7),
                          GestureDetector(
                            onTap: ()=> showDatePickerDialog(),
                            child: Container(
                              width: size.width,
                              height: Sizes.dimen_50,
                              padding: const EdgeInsets.symmetric(
                                horizontal: Sizes.dimen_20,
                                vertical: Sizes.dimen_16,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: TrybeColors.gray, width: Sizes.dimen_1),
                                borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_6)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedBirthDate,
                                    // '$selectedDate',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: Sizes.dimen_14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Image.asset('assets/images/chevron_down.png'),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: Sizes.dimen_10,),
                          const Text(
                            'Phone Number',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.dimen_14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: Sizes.dimen_7),
                          TextFormField(
                            controller: phoneController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(11),
                            ],
                            onChanged: (value){
                              if(value.length == 11){
                                setState(()=> hasPhoneNumber = true);
                              }
                            },
                            validator: (value){
                              if(value!.length < 10){
                                return 'Invalid phone number';
                              } else if(value.isEmpty) {
                                return 'Required';
                              } else {
                                return '';
                              }
                            },
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                              fontSize: Sizes.dimen_14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                            decoration: const InputDecoration(
                              hintText: '080xxxxxxxx',
                              contentPadding: EdgeInsets.symmetric(vertical: Sizes.dimen_10, horizontal: Sizes.dimen_22),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_6)),
                                  borderSide: BorderSide(
                                      color: TrybeColors.gray,
                                      width: Sizes.dimen_1
                                  )
                              ),
                              hintStyle: TextStyle(
                                  fontSize: Sizes.dimen_14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black
                              ),
                            ),
                          ),

                          const SizedBox(height: Sizes.dimen_50),
                          AuthenticationButton(
                            isEnabled: hasFirstName && hasLastName && hasPhoneNumber
                                && selectedGender.isNotEmpty && selectedBirthDate.isNotEmpty,
                            title: TextLiterals.continueText,
                            onClicked: ()=> submitBioData(),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ]
            )
          ),
        ),
      ),
    );

  }

  submitBioData() async {

    if(formKey.currentState != null && !formKey.currentState!.validate()){

      var sub = phoneController.text.substring(0, phoneController.text.length);
      print(sub);

      var countryCodePhoneNumber = '+234' + sub;
      print(countryCodePhoneNumber);
      box.put(DBConstants.userPhoneNumber, phoneController.text);

      String bvn = hasBVN ? '12345678910' : '';

      final data = {
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'gender': selectedGender,
        'birthdate': selectedBirthDate,
        // 'phone': phoneController.text,
        'phone': countryCodePhoneNumber,
        'hasBvn': hasBVN,
        'bvn': bvn
      };

      APIClient client = APIClient();
      client.submitBioData(pathSegment: APIConstants.UPDATE_BVN_BIO, body: data);
      // Navigator.pushNamed(context, RouteLiterals.kycBVNRoute);

      var showOtherAddressInfo = box.get(DBConstants.isFromEmployedCategory);
      print('showOtherAddressInfo value:\t$showOtherAddressInfo');
      showOtherAddressInfo
          ? Navigator.pushNamed(context, RouteLiterals.employeeSelfEmployedAddressInfo)
          : Navigator.pushNamed(context, RouteLiterals.studentAndCorperAddressInfoRoute);

    }

  }

  showGenderPickerDialog() {
    showModalBottomSheet(
      context: context,
      elevation: 2.0,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(Sizes.dimen_10), topLeft: Radius.circular(Sizes.dimen_10)),
      ),
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(Sizes.dimen_10), topLeft: Radius.circular(Sizes.dimen_10)
          ),
          child: Container(
            width: size.width,
            height: Sizes.dimen_250,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.dimen_28,
              vertical: Sizes.dimen_11
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
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
                    setState(()=> selectedGender = 'Male');
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: size.width,
                    height: Sizes.dimen_50,
                    decoration: BoxDecoration(
                      color: TrybeColors.primaryRed.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: Sizes.dimen_35,
                            height: Sizes.dimen_35,
                            decoration: BoxDecoration(
                              color: TrybeColors.primaryRed.withOpacity(0.1),
                            ),
                            child: Center(
                              child: Image.asset('assets/images/male.png'),
                            )
                          ),
                          const SizedBox(width: Sizes.dimen_10),
                          const Text(
                            'Male',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Sizes.dimen_14,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    )
                  )
                ),
                const SizedBox(height: Sizes.dimen_10),
                GestureDetector(
                    onTap: (){
                      setState(()=> selectedGender = 'Female');
                      Navigator.pop(context);
                    },
                    child: Container(
                        width: size.width,
                        height: Sizes.dimen_50,
                        decoration: BoxDecoration(
                          color: TrybeColors.primaryRed.withOpacity(0.1),
                          borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                  width: Sizes.dimen_35,
                                  height: Sizes.dimen_35,
                                  decoration: BoxDecoration(
                                    color: TrybeColors.primaryRed.withOpacity(0.1),
                                  ),
                                child: Center(
                                  child: Image.asset('assets/images/female.png'),
                                ),
                              ),
                              const SizedBox(width: Sizes.dimen_10),
                              const Text(
                                'Female',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Sizes.dimen_14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                    )
                ),
                const SizedBox(height: Sizes.dimen_10),
                GestureDetector(
                    onTap: (){
                      setState(()=> selectedGender = 'Others');
                      Navigator.pop(context);
                    },
                    child: Container(
                        width: size.width,
                        height: Sizes.dimen_50,
                        decoration: BoxDecoration(
                          color: TrybeColors.primaryRed.withOpacity(0.1),
                          borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                  width: Sizes.dimen_35,
                                  height: Sizes.dimen_35,
                                  decoration: BoxDecoration(
                                    color: TrybeColors.primaryRed.withOpacity(0.1),
                                  ),
                                child: Center(
                                  child: Image.asset('assets/images/other_gender.png'),
                                ),
                              ),
                              const SizedBox(width: Sizes.dimen_10),
                              const Text(
                                'Others',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Sizes.dimen_14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                    )
                ),
              ]
            )
          ),
        );
      },
    );
  }

  showDatePickerDialog() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2007),
      lastDate: DateTime(2032),
    );
    print(date);
    if(date != null){
      final formatter = DateFormat('d MMM yyyy');
      final formattedText = formatter.format(date);
      setState(()=> selectedBirthDate = formattedText);
    }
  }

}