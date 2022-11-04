import 'dart:io';

import 'package:dio/dio.dart';
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

class UploadProfilePicture extends StatefulWidget {

  const UploadProfilePicture({Key? key}) : super(key: key);

  @override
  _UploadProfilePictureState createState() => _UploadProfilePictureState();
}

late Size size;

class _UploadProfilePictureState extends State<UploadProfilePicture> {

  bool hasSelectedImage = false;

  File? selectedImage;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.fromLTRB(
              Sizes.dimen_15, Sizes.dimen_0, Sizes.dimen_15, Sizes.dimen_5
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              const KYCHeaderText(
                showStepCount: true,
                stepTitle: 'Step 3 of 5',
                title: 'Put a face to the name',
                description: 'Upload a live picture',
              ),
              const SizedBox(height: Sizes.dimen_32),
              SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: ()=> selectImage(context: context),
                      child: Container(
                          width: Sizes.dimen_292,
                          height: Sizes.dimen_292,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child:
                          hasSelectedImage
                              ? ClipOval(child: Image.file(selectedImage!, height: Sizes.dimen_292, width: Sizes.dimen_292, fit: BoxFit.cover,))
                              : Image.asset('assets/images/profie_pic_placeholder.png')
                      ),
                    ),
                    const SizedBox(height: Sizes.dimen_200),
                    Row(
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
                            hasSelectedImage
                                ? uploadProfilePicture() : null,
                            child: Container(
                              height: Sizes.dimen_50,
                              decoration: BoxDecoration(
                                color: hasSelectedImage ? TrybeColors.primaryRed : TrybeColors.primaryRed.withOpacity(0.3),
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
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  selectImage({required BuildContext context}) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
      if(image == null) {
        setState(()=> hasSelectedImage = false);
      } else {
        final tempImage = File(image.path);
        setState(() {
          selectedImage = tempImage;
          hasSelectedImage = true;
        });
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

  uploadProfilePicture() async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        selectedImage!.path,
        filename: selectedImage!.path.split('/').last,
        contentType: MediaType('image', '*'),
      ),
    });

    APIClient client = APIClient();
    var response = await client.uploadImageDocument(pathSegment: APIConstants.UPLOAD_PROFILE_IMAGE, body: formData,);
    print(response);

    Navigator.pushNamed(context, RouteLiterals.utilityBillsRoute);

  }

}