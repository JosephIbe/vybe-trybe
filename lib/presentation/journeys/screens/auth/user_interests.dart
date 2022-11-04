import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trybe_one_mobile/common/constants/route_constants.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/data/core/api_client.dart';
import 'package:trybe_one_mobile/data/core/api_constants.dart';
import 'package:trybe_one_mobile/data/models/user/interests_model.dart';
import 'package:trybe_one_mobile/presentation/journeys/themes/app_colors.dart';
import 'package:trybe_one_mobile/presentation/widgets/kyc/kyc_header_text.dart';

class UserInterests extends StatefulWidget {

  const UserInterests({Key? key}) : super(key: key);

  @override
  _UserInterestsState createState() => _UserInterestsState();

}

late Size size;
List<int?> selectedInterests = [];

class _UserInterestsState extends State<UserInterests> {

  late Future<List<InterestsModel>> interestsFuture;
  late APIClient client;

  List<InterestsModel> allInterests = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    client = APIClient();
    // interestsFuture = fetchUserInterests();
    fetchUserInterests();
  }

  Future<List<InterestsModel>> fetchUserInterests() async {
    dynamic response = await client.getUserInterests(pathSegment: APIConstants.FETCH_INTERESTS);
    print(response);
    return response;
  }

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
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const KYCHeaderText(
                      showStepCount: true,
                      stepTitle: 'Step 5 of 5',
                      title: 'Let us know what you like',
                      description: 'What are your interests?',
                    ),
                    const SizedBox(height: Sizes.dimen_20,),
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: size.height * 0.6,
                      ),
                      child: FutureBuilder<List<InterestsModel>>(
                        future: fetchUserInterests(),
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            allInterests = snapshot.data!;
                            return GridView.builder(
                              itemCount: allInterests.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 3/2
                              ),
                              itemBuilder: (context, index){
                                final model = allInterests[index];
                                return InterestItems(model: model);
                              },
                            );
                          } else {
                            return const Center(child: CircularProgressIndicator(),);
                          }
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: ()=>
                        selectedInterests.isNotEmpty
                            ? submitUserInterests() : null,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  submitUserInterests() async {
    APIClient client = APIClient();
    if(selectedInterests.isNotEmpty){
      print(selectedInterests);
      // await client.updateUserInterests(
      //   pathSegment: APIConstants.UPDATE_INTERESTS,
      //   body: {
      //     'interests': selectedInterests
      //   }
      // );

      // await Navigator.pushNamedAndRemoveUntil(context, RouteLiterals.letsGoRoute, (route) => false);
    }
  }

}

class InterestItems extends StatefulWidget {

  final InterestsModel model;
  const InterestItems({
    required this.model,
    Key? key
  }) : super(key: key);

  @override
  _InterestItemsState createState() => _InterestItemsState();
}

class _InterestItemsState extends State<InterestItems> {

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        widget.model.name!,
        style: TextStyle(
          color: isSelected ? Colors.white : TrybeColors.mediumDarkGray,
        ),
      ),
      // selected: selectedInterests.contains(index),
      selected: isSelected,
      showCheckmark: false,
      onSelected: (value){
        setState(() {
          isSelected = value;
          selectedInterests.contains(widget.model.id)
            ? selectedInterests.remove(widget.model.id)
            : selectedInterests.add(widget.model.id);
        });
      },
      padding: const EdgeInsets.all(Sizes.dimen_8),
      backgroundColor: selectedInterests.contains(widget.model.id) ? TrybeColors.primaryRed : Colors.white,
      selectedColor: TrybeColors.primaryRed,
      shape: StadiumBorder(
        side: BorderSide(
          color: isSelected ? TrybeColors.primaryRed : Colors.blueGrey,
          width: 1.0
        )
      ),
    );
  }
}
