import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trybe_one_mobile/common/constants/route_constants.dart';

import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/data/core/api_client.dart';
import 'package:trybe_one_mobile/data/core/api_constants.dart';
import 'package:trybe_one_mobile/data/core/db_constants.dart';

import 'package:trybe_one_mobile/presentation/blocs/life_update_pages/life_update_pages_bloc.dart';
import 'package:trybe_one_mobile/presentation/blocs/life_update_pages/life_update_pages_event.dart';
import 'package:trybe_one_mobile/presentation/journeys/themes/app_colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/regular_button.dart';

class EmployedLifeUpdateView extends StatefulWidget {

  const EmployedLifeUpdateView({Key? key}) : super(key: key);

  @override
  _EmployedLifeUpdateViewState createState() => _EmployedLifeUpdateViewState();
}

late Size size;

class _EmployedLifeUpdateViewState extends State<EmployedLifeUpdateView> {

  final formKey = GlobalKey<FormState>();
  final occupationController = TextEditingController();
  final workPlaceController = TextEditingController();

  File? selectedImage;
  File? selectedDocument;

  bool hasOccupation = false;
  bool hasWorkPlace = false;

  bool hasSelectedImage = false;
  bool hasSelectedDocument = false;

  late Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box(DBConstants.userBoxName);
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
              padding: const EdgeInsets.all(Sizes.dimen_15),
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
                          child: Image.asset('assets/images/briefcase.png'),
                        ),
                      ),
                      const SizedBox(width: Sizes.dimen_10),
                      const Text(
                          TextLiterals.employed,
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
                      BlocProvider.of<LifeUpdatePagesBloc>(context)
                          .add(LoadDefaultLifeUpdatePage());
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
                minHeight: Sizes.dimen_80,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.dimen_15,
                vertical: Sizes.dimen_15,
              ),
              decoration: BoxDecoration(
                  color: TrybeColors.lightGray,
                  borderRadius: BorderRadius.circular(Sizes.dimen_7)
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        TextLiterals.occupation,
                        style: TextStyle(
                          fontSize: Sizes.dimen_14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )
                    ),
                    const SizedBox(height: Sizes.dimen_7),
                    TextFormField(
                      controller: occupationController,
                      validator: (value){
                        if(value!.length < 3){
                          return 'Input is too short';
                        } else if(value.isEmpty) {
                          return 'Occupation is Required';
                        } else {
                          return '';
                        }
                      },
                      onChanged: (value) {
                        if(value.length > 3 && value.isNotEmpty) {
                          setState(()=> hasOccupation = true);
                        }
                      },
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        fontSize: Sizes.dimen_14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Your Job Title...',
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

                    const SizedBox(height: Sizes.dimen_20,),

                    const Text(
                      TextLiterals.whereDoYouWork,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Sizes.dimen_14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: Sizes.dimen_7),
                    TextFormField(
                      controller: workPlaceController,
                      onChanged: (value) {
                        if(value.length > 3 && value.isNotEmpty) {
                          setState(()=> hasWorkPlace = true);
                        }
                      },
                      validator: (value){
                        if(value!.length < 3){
                          return 'Input is too short';
                        } else if(value.isEmpty) {
                          return 'Place of Work is Required';
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
                        hintText: 'Your Company Name...',
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
            ),
            const SizedBox(height: Sizes.dimen_20,),

            Opacity(
              opacity: hasOccupation && hasWorkPlace ? 1.0 : 0.0,
              child: Container(
                  constraints: const BoxConstraints(
                    minHeight: Sizes.dimen_70,
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
                                    TextLiterals.uploadWorkIDCard,
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
              ),
            ),
            const SizedBox(height: Sizes.dimen_20),

            Opacity(
              opacity: hasSelectedImage || hasSelectedDocument? 1.0 : 0.0,
              child: AuthenticationButton(
                isEnabled: hasSelectedImage || hasSelectedDocument,
                onClicked: ()=> submitLifeUpdate(),
                title: TextLiterals.continueText,
              ),
            ),
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
      'organisation': workPlaceController.text,
      'occupation': occupationController.text,
    });

    APIClient client = APIClient();
    client.submitLifeUpdateType(pathSegment: APIConstants.LIFE_UPDATE_SEGMENT, body: formData,);

    box.put(DBConstants.isFromEmployedCategory, true);
    Navigator.pushNamed(context, RouteLiterals.bvnSignUpTypeRoute);
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