import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/data/core/db_constants.dart';
import 'package:trybe_one_mobile/presentation/journeys/themes/app_colors.dart';
import 'package:trybe_one_mobile/presentation/widgets/kyc/kyc_header_text.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/regular_button.dart';

class KYCBVN extends StatefulWidget {

  const KYCBVN({Key? key}) : super(key: key);

  @override
  _KYCBVNState createState() => _KYCBVNState();
}

late Size size;

class _KYCBVNState extends State<KYCBVN> {

  final formKey = GlobalKey<FormState>();

  final bvnController = TextEditingController();
  String? bvn;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

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
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const KYCHeaderText(
                    showStepCount: false,
                    stepTitle: '',
                    title: TextLiterals.shareBVN,
                    description: TextLiterals.shareBVNDescription
                  ),
                  const SizedBox(height: Sizes.dimen_79),
                  const Text(
                    'BVN Number',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Sizes.dimen_14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: Sizes.dimen_7),
                  TextFormField(
                    controller: bvnController,
                    validator: (value){
                      if (value!.length < 11) {
                        return 'Invalid bvn format';
                      } else {
                        setState(()=> bvn = bvnController.text);
                        return null;
                      }
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(11),
                    ],
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Sizes.dimen_14,
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: 'BVN goes here...',
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
                  const SizedBox(height: Sizes.dimen_320),
                  AuthenticationButton(
                    isEnabled: bvnController.text.length > 3,
                    title: TextLiterals.continueText,
                    onClicked: ()=> validateBVN()
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  validateBVN(){
    if(formKey.currentState != null && formKey.currentState!.validate()){
      var box = Hive.box(DBConstants.userBoxName);
      var showOtherAddressInfo = box.get(DBConstants.isFromEmployedCategory);
      print('showOtherAddressInfo value:\t$showOtherAddressInfo');

      showOtherAddressInfo
        ? Navigator.pushNamed(context, RouteLiterals.employeeSelfEmployedAddressInfo)
        : Navigator.pushNamed(context, RouteLiterals.studentAndCorperAddressInfoRoute);
    }
  }

}