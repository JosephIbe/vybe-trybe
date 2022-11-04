import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/presentation/blocs/life_update_pages/life_update_pages_bloc.dart';
import 'package:trybe_one_mobile/presentation/blocs/life_update_pages/life_update_pages_event.dart';
import 'package:trybe_one_mobile/presentation/widgets/auth/auth_page_header.dart';
import 'package:trybe_one_mobile/presentation/widgets/life_update/life_update_type.dart';

var size;

class LifeUpdateOptionsPage extends StatelessWidget {

  const LifeUpdateOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return Expanded(
          child: ListView(
            children: [
              LifeUpdateType(
                title: TextLiterals.student,
                imagePath: 'assets/images/book.png',
                onTap: ()=> BlocProvider.of<LifeUpdatePagesBloc>(context).add(LoadStudentLifeUpdatePage())
              ),
              const SizedBox(height: Sizes.dimen_20),
              LifeUpdateType(
                title: TextLiterals.corpMember,
                imagePath: 'assets/images/teacher.png',
                onTap: ()=> BlocProvider.of<LifeUpdatePagesBloc>(context).add(LoadCorpMemberLifeUpdatePage())
              ),
              const SizedBox(height: Sizes.dimen_20),
              LifeUpdateType(
                title: TextLiterals.employed,
                imagePath: 'assets/images/briefcase.png',
                onTap: ()=> BlocProvider.of<LifeUpdatePagesBloc>(context).add(LoadEmployedLifeUpdatePage())
              ),
              const SizedBox(height: Sizes.dimen_20),
              LifeUpdateType(
                title: TextLiterals.selfEmployed,
                imagePath: 'assets/images/briefcase.png',
                onTap: ()=> BlocProvider.of<LifeUpdatePagesBloc>(context).add(LoadSelfEmployedLifeUpdatePage())
              ),
            ]
          )
        // ),
      // ),
    );
  }
}
