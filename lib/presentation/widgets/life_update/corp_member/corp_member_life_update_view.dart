import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:trybe_one_mobile/common/constants/route_constants.dart';

import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/data/core/api_client.dart';
import 'package:trybe_one_mobile/data/core/api_constants.dart';
import 'package:trybe_one_mobile/data/core/db_constants.dart';
import 'package:trybe_one_mobile/data/models/life_update/states_model.dart';

import 'package:trybe_one_mobile/presentation/blocs/life_update_pages/life_update_pages_bloc.dart';
import 'package:trybe_one_mobile/presentation/blocs/life_update_pages/life_update_pages_event.dart';

import 'package:trybe_one_mobile/presentation/blocs/submit_life_update/submit_life_update_bloc.dart';
import 'package:trybe_one_mobile/presentation/blocs/submit_life_update/submit_life_update_state.dart';
import 'package:trybe_one_mobile/presentation/blocs/submit_life_update/submit_life_update_event.dart';
import 'package:trybe_one_mobile/presentation/journeys/screens/auth/bvn_sign_up_type.dart';

import 'package:trybe_one_mobile/presentation/journeys/themes/app_colors.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trybe_one_mobile/presentation/widgets/onboarding/regular_button.dart';

import 'package:trybe_one_mobile/di/get_it_locator.dart' as getIt;

// class CorpMemberLifeUpdateView extends StatelessWidget {
//
//   const CorpMemberLifeUpdateView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: SubmitLifeUpdateBloc(repository: getIt.getItInstance()),
//       child: BlocListener<SubmitLifeUpdateBloc, SubmitLifeUpdateState>(
//         listener: (context, state){
//           if(state is CorpMemberLifeUpdateStateSuccess){
//             print(state);
//             MotionToast.success(
//                 description: const Text('You have submitted your life update successfully')
//             ).show(context);
//             Navigator.pushNamed(context, RouteLiterals.bvnSignUpTypeRoute);
//           }
//           if(state is CorpMemberLifeUpdateStateFailure){
//             MotionToast.error(
//               description: Text('Unable to submit your life update at this moment...:\n${state.errorMessage}')
//             ).show(context);
//           }
//         },
//         child: BlocBuilder<SubmitLifeUpdateBloc, SubmitLifeUpdateState>(
//           builder: (context, state){
//             if(state is SubmitLifeUpdateStateLoading){
//               return const Scaffold(
//                 backgroundColor: TrybeColors.primaryRed,
//                 body: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//             }
//             if(state is CorpMemberLifeUpdateStateFailure){
//               return const CorpMemberLifeUpdateViewForm();
//             }
//             return const CorpMemberLifeUpdateViewForm();
//           },
//         ),
//       ),
//     );
//   }
//
// }

class CorpMemberLifeUpdateView extends StatefulWidget {
  const CorpMemberLifeUpdateView({Key? key}) : super(key: key);

  @override
  _CorpMemberLifeUpdateViewState createState() =>
      _CorpMemberLifeUpdateViewState();
}

late Size size;

class _CorpMemberLifeUpdateViewState extends State<CorpMemberLifeUpdateView> {

  bool hasSelectedState = false;
  late String selectedState;

  List<StatesModel> allStatesList = [];
  List<StatesModel> searchedStates = [];

  File? selectedImage;
  File? selectedDocument;

  bool hasSelectedImage = false;
  bool hasSelectedDocument = false;

  late Box box;

  late Future<List<StatesModel>> statesFuture;
  late APIClient client;

  @override
  void initState() {
    super.initState();
    client = APIClient();
    box = Hive.box(DBConstants.userBoxName);
    statesFuture = getStates();
    searchedStates = allStatesList;
  }

  Future<List<StatesModel>> getStates() async {
    final response = await client.getStates(pathSegment: APIConstants.STATES_SEGMENT);
    print(response);
    return response;
  }

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    print('life update type:\t${box.get(DBConstants.lifeUpdateType)}');

    return Expanded(
      child: Column(
        children: [
          Container(
            width: size.width,
            height: Sizes.dimen_80,
            decoration: BoxDecoration(
              color: TrybeColors.primaryRed.withOpacity(0.1),
              borderRadius:
                  const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
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
                        child: Image.asset('assets/images/teacher.png'),
                      ),
                    ),
                    const SizedBox(width: Sizes.dimen_10),
                    const Text(TextLiterals.corpMember,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Sizes.dimen_16,
                            color: Colors.black)),
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
              minHeight: Sizes.dimen_60,
            ),
            padding: const EdgeInsets.all(
              Sizes.dimen_15,
            ),
            decoration: BoxDecoration(
                color: TrybeColors.lightGray3,
                borderRadius: BorderRadius.circular(Sizes.dimen_7)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(TextLiterals.stateServingIn,
                    style: TextStyle(
                      fontSize: Sizes.dimen_14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
                const SizedBox(height: Sizes.dimen_10),
                hasSelectedState
                    ? Row(
                        children: [
                          Text(selectedState,
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
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(Sizes.dimen_10),
                                      topLeft: Radius.circular(Sizes.dimen_10)),
                                  ),
                                  builder: (context) => FractionallySizedBox(heightFactor: 0.75, child: statesList(),));
                            },
                            child: const Text(TextLiterals.change,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: Sizes.dimen_12)
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
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(Sizes.dimen_10),
                                    topLeft: Radius.circular(Sizes.dimen_10)),
                              ),
                              builder: (context) => statesList());
                        },
                        child: Container(
                          width: size.width,
                          height: Sizes.dimen_50,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(Sizes.dimen_10)),
                              border: Border.all(
                                  color: TrybeColors.gray,
                                  width: Sizes.dimen_1)),
                        )),
              ],
            ),
          ),
          const SizedBox(height: Sizes.dimen_30),

          Opacity(
            opacity: hasSelectedState ? 1.0 : 0.0,
            child: Container(
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(TextLiterals.verify,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Sizes.dimen_16,
                            fontWeight: FontWeight.w500,
                          )
                      ),
                      const SizedBox(height: Sizes.dimen_20),
                      hasSelectedImage || hasSelectedDocument
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
                                        builder: (context) => showDocumentPicker()
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                    builder: (context) => showDocumentPicker()
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
                                        TextLiterals.uploadCallUpLetter,
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
                          ]
                      )
                    ]
                )
            ),
          ),
          const SizedBox(height: Sizes.dimen_70),

          Opacity(
              opacity: hasSelectedState && hasSelectedImage || hasSelectedDocument ? 1.0 : 0.0,
              child: AuthenticationButton(
                isEnabled: hasSelectedState && hasSelectedImage || hasSelectedDocument,
                onClicked: ()=> submitLifeUpdate(),
                title: TextLiterals.continueText,
              )
          ),
        ],
      ),
    );

  }

  submitLifeUpdate() async {

    print('selected state:\t$selectedState');

    if(selectedImage != null || selectedDocument != null ) {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          selectedImage!.path,
          filename: selectedImage!.path.split('/').last,
          contentType: MediaType('image', '*'),
        ),
        'userType': box.get(DBConstants.lifeUpdateType),
        'corpServiceLocation': selectedState,
      });

      client.submitLifeUpdateType(pathSegment: APIConstants.LIFE_UPDATE_SEGMENT, body: formData,);

      box.put(DBConstants.isFromEmployedCategory, false);
      box.put(DBConstants.showPPAText, true);
      Navigator.pushNamed(context, RouteLiterals.bvnSignUpTypeRoute);
    }

    // BlocProvider.of<SubmitLifeUpdateBloc>(context).add(SubmitCorpMemberLifeUpdate(body: formData));

  }

  Widget statesList() {
    // return ClipRRect(
    //     borderRadius: const BorderRadius.only(topRight: Radius.circular(Sizes.dimen_10), topLeft: Radius.circular(Sizes.dimen_10)),
    //     child: FractionallySizedBox(
    //         heightFactor: 0.75,
    //         child: FutureBuilder<List<StatesModel>>(
    //           future: statesFuture,
    //           builder: (context, snapshot){
    //             if(snapshot.hasData){
    //               allStatesList = snapshot.data!;
    //               searchedStates = snapshot.data!;
    //               return Container(
    //                 width: size.width,
    //                 height: Sizes.dimen_500,
    //                 padding: const EdgeInsets.symmetric(
    //                     horizontal: Sizes.dimen_32,
    //                     vertical: Sizes.dimen_11
    //                 ),
    //                 decoration: const BoxDecoration(
    //                   color: Colors.white,
    //                 ),
    //                 child: Column(
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: [
    //                       Align(
    //                         alignment: Alignment.topRight,
    //                         child: GestureDetector(
    //                           onTap: ()=> Navigator.pop(context),
    //                           child: Container(
    //                             width: Sizes.dimen_24,
    //                             height: Sizes.dimen_24,
    //                             decoration: BoxDecoration(
    //                               shape: BoxShape.circle,
    //                               color: TrybeColors.primaryRed.withOpacity(0.2),
    //                             ),
    //                             child: Image.asset('assets/images/close.png'),
    //                           ),
    //                         ),
    //                       ),
    //                       const SizedBox(height: Sizes.dimen_20),
    //                       TextFormField(
    //                         onChanged: (value) => _filterStates(value),
    //                         decoration: InputDecoration(
    //                           hintText: TextLiterals.searchCountries,
    //                           suffixIcon: IconButton(
    //                             onPressed: ()=>{},
    //                             icon: const Icon(Icons.search, color: TrybeColors.primaryRed,),
    //                           ),
    //                         ),
    //                       ),
    //                       searchedStates.isNotEmpty
    //                           ? Expanded(
    //                         child: ListView.separated(
    //                           shrinkWrap: true,
    //                           itemCount: searchedStates.length,
    //                           separatorBuilder: (context, index) => const Divider(height: Sizes.dimen_1,),
    //                           itemBuilder: (context, index){
    //                             return ListTile(
    //                               onTap: (){
    //                                 setState((){
    //                                   selectedState = allStatesList[index].name!;
    //                                   hasSelectedState = true;
    //                                 });
    //                                 Navigator.pop(context);
    //                               },
    //                               contentPadding: const EdgeInsets.symmetric(vertical: Sizes.dimen_10),
    //                               title: Text(allStatesList[index].name!),
    //                             );
    //                           },
    //                         ),
    //                       )
    //                           : const Center(
    //                         child: Text(
    //                           'No results found',
    //                           style: TextStyle(
    //                               color: Colors.black,
    //                               fontWeight: FontWeight.w400,
    //                               fontSize: Sizes.dimen_14
    //                           ),
    //                         ),
    //                       ),
    //                     ]
    //                 ),
    //               );
    //             } else {
    //               return Container(
    //                   width: size.width,
    //                   height: Sizes.dimen_500,
    //                   padding: const EdgeInsets.symmetric(
    //                       horizontal: Sizes.dimen_32,
    //                       vertical: Sizes.dimen_11
    //                   ),
    //                   decoration: const BoxDecoration(
    //                     color: Colors.white,
    //                   ),
    //                   child: const Center(
    //                     child: CircularProgressIndicator(),
    //                   )
    //               );
    //             }
    //           },
    //         )
    //     )
    // );
    return ClipRRect(
        borderRadius: const BorderRadius.only(topRight: Radius.circular(Sizes.dimen_10), topLeft: Radius.circular(Sizes.dimen_10)),
        child: FractionallySizedBox(
            heightFactor: 0.75,
            child: FutureBuilder<List<StatesModel>>(
              future: statesFuture,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  allStatesList = snapshot.data!;
                  searchedStates = allStatesList;
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
                            onChanged: (value) => _filterStates(value),
                            decoration: InputDecoration(
                              hintText: TextLiterals.searchCountries,
                              suffixIcon: IconButton(
                                onPressed: ()=>{},
                                icon: const Icon(Icons.search, color: TrybeColors.primaryRed,),
                              ),
                            ),
                          ),
                          searchedStates.isNotEmpty
                              ? Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: searchedStates.length,
                              separatorBuilder: (context, index) => const Divider(height: Sizes.dimen_1,),
                              itemBuilder: (context, index){
                                return ListTile(
                                  onTap: (){
                                    setState((){
                                      selectedState = allStatesList[index].name!;
                                      hasSelectedState = true;
                                    }
                                    );
                                    Navigator.pop(context);
                                  },
                                  contentPadding: const EdgeInsets.symmetric(vertical: Sizes.dimen_10),
                                  title: Text(allStatesList[index].name!),
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

  void _filterStates(String value) {
    dynamic results = [];
    if (value.isEmpty) {
      results = allStatesList;
    } else {
      results = allStatesList
          .where(
              (state) => state.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setState(() => searchedStates = results);
    }
  }

  showDocumentPicker() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(Sizes.dimen_10),
          topLeft: Radius.circular(Sizes.dimen_10)),
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.dimen_28, vertical: Sizes.dimen_11),
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
                  onTap: () => Navigator.pop(context),
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
                  selectImage(source: ImageSource.camera);
                },
                child: Container(
                  width: size.width,
                  height: Sizes.dimen_80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_15,
                    vertical: Sizes.dimen_20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
                    color: TrybeColors.primaryRed.withOpacity(0.1),
                  ),
                  child: Row(children: [
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
                    const Text(TextLiterals.takePicture,
                        style: TextStyle(
                          fontSize: Sizes.dimen_16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ))
                  ]),
                ),
              ),
              const SizedBox(height: Sizes.dimen_19),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  selectImage(source: ImageSource.gallery);
                },
                child: Container(
                  width: size.width,
                  height: Sizes.dimen_80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_15,
                    vertical: Sizes.dimen_20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
                    color: TrybeColors.primaryRed.withOpacity(0.1),
                  ),
                  child: Row(children: [
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
                    const Text(TextLiterals.uploadFromGallery,
                        style: TextStyle(
                          fontSize: Sizes.dimen_16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ))
                  ]),
                ),
              ),
              const SizedBox(height: Sizes.dimen_19),
              GestureDetector(
                onTap: () => {Navigator.pop(context), selectDocument()},
                child: Container(
                  width: size.width,
                  height: Sizes.dimen_80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_15,
                    vertical: Sizes.dimen_20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
                    color: TrybeColors.primaryRed.withOpacity(0.1),
                  ),
                  child: Row(children: [
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
                    const Text(TextLiterals.uploadDocument,
                        style: TextStyle(
                          fontSize: Sizes.dimen_16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ))
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  selectImage({required ImageSource source}) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        setState(() => hasSelectedImage = false);
      } else {
        final tempImage = File(image.path);
        setState(() {
          selectedImage = tempImage;
          hasSelectedImage = true;
        });
      }
    } on PlatformException catch (e) {
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