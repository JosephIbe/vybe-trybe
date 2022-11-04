import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/data/core/api_client.dart';
import 'package:trybe_one_mobile/data/core/api_constants.dart';
import 'package:trybe_one_mobile/presentation/journeys/themes/app_colors.dart';
import 'package:trybe_one_mobile/presentation/widgets/kyc/kyc_header_text.dart';

class UtilityBills extends StatefulWidget {

  const UtilityBills({Key? key}) : super(key: key);

  @override
  _UtilityBillsState createState() => _UtilityBillsState();
}

late Size size;

class _UtilityBillsState extends State<UtilityBills> {

  File? selectedImage;
  File? selectedDocument;

  bool hasSelectedImage = false;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_22, vertical: Sizes.dimen_20),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const KYCHeaderText(
                    showStepCount: true,
                    stepTitle: 'Step 4 of 5',
                    title: 'Utility Bill',
                    description: 'We need this to verify your address',
                  ),
                  const SizedBox(height: Sizes.dimen_32),
                  !hasSelectedImage
                      ? Column(
                          children: [
                            utilityBillItem(imagePath: 'assets/images/power_bill.png', title: 'Electricity Bill',),
                            const SizedBox(height: Sizes.dimen_20),
                            utilityBillItem(imagePath: 'assets/images/water_bill.png', title: 'Water Bill'),
                            const SizedBox(height: Sizes.dimen_20),
                            utilityBillItem(imagePath: 'assets/images/network_tv_bill.png', title: 'Cable TV Bill'),
                            // const SizedBox(height: Sizes.dimen_100),
                          ],
                        )
                      : changePictureWidget(),
                ],
              ),

              Opacity(
                opacity: hasSelectedImage ? 1.0 : 0.0,
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
                        onTap: ()=> uploadUtilityBill(),
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
              ),

            ],
          ),
        ),
      ),
    );
  }

  uploadUtilityBill() async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        selectedImage!.path,
        filename: selectedImage!.path.split('/').last,
        contentType: MediaType('image', '*'),
      ),
    });

    APIClient client = APIClient();
    await client.uploadImageDocument(pathSegment: APIConstants.UTILITY_BILL_SEGMENT, body: formData,);

    Navigator.pushNamed(context, RouteLiterals.interestsRoute);

  }

  utilityBillItem({required String imagePath, required String title}){
    return GestureDetector(
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
      child: Container(
        width: size.width,
        height: Sizes.dimen_80,
        padding: const EdgeInsets.symmetric(horizontal: Sizes.dimen_15, vertical: Sizes.dimen_20),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
          color: TrybeColors.primaryRed.withOpacity(0.1),
        ),
        child: Row(
          children: [
            Container(
              height: Sizes.dimen_40,
              width: Sizes.dimen_40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(imagePath),
            ),
            const SizedBox(width: Sizes.dimen_10,),
            Text(
              title,
              style: const TextStyle(
                  fontSize: Sizes.dimen_16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),
            )
          ],
        ),
      ),
    );
  }

  changePictureWidget(){
    return Container(
      constraints: BoxConstraints(
        maxWidth: size.width,
        // maxHeight: Sizes.dimen_200,
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          selectedImage == null
                ? const Center(child: CircularProgressIndicator())
                : ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_5)),
                    child: Image.file(selectedImage!, height: Sizes.dimen_277, width: Sizes.dimen_180,)
                  ),
          const SizedBox(height: Sizes.dimen_10,),
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
                  builder: (context) => showDocumentPicker(context)
              );
            },
            child: const Text(
              TextLiterals.changePicture,
              style: TextStyle(
                fontSize: Sizes.dimen_14,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          )
        ],
      )
    );
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