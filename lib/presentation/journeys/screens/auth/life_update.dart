import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:trybe_one_mobile/common/constants/size_constants.dart';
import 'package:trybe_one_mobile/common/constants/text_constants.dart';
import 'package:trybe_one_mobile/data/core/db_constants.dart';
import 'package:trybe_one_mobile/presentation/blocs/life_update_pages/life_update_pages_bloc.dart';
import 'package:trybe_one_mobile/presentation/blocs/life_update_pages/life_update_pages_state.dart';
import 'package:trybe_one_mobile/presentation/widgets/auth/auth_page_header.dart';
import '../../../widgets/life_update/corp_member/corp_member_life_update_view.dart';
import '../../../widgets/life_update/employed/employed_life_update_view.dart';
import 'package:trybe_one_mobile/presentation/widgets/life_update/life_update_options_page.dart';
import '../../../widgets/life_update/self_employed/self_employed_life_update_view.dart';
import '../../../widgets/life_update/student/student_life_update_view.dart';

dynamic size;

class LifeUpdate extends StatefulWidget {

  const LifeUpdate({Key? key}) : super(key: key);

  @override
  _LifeUpdateState createState() => _LifeUpdateState();
}

class _LifeUpdateState extends State<LifeUpdate> {

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    var box = Hive.box(DBConstants.userBoxName);
    print('life update type:\t${box.get(DBConstants.lifeUpdateType)}');

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.fromLTRB(
            Sizes.dimen_22, Sizes.dimen_40, Sizes.dimen_22, Sizes.dimen_20
          ),
          child: Column(
            children: [
              const AuthPageHeaderText(
                  title: TextLiterals.lifeUpdate,
                  description: TextLiterals.likeToKnowWYD
              ),
              const SizedBox(height: Sizes.dimen_10),
              BlocBuilder<LifeUpdatePagesBloc, LifeUpdatePagesState>(
                builder: (context, state){
                  if(state is LifeUpdatePagesStateInitial){
                    return const LifeUpdateOptionsPage();
                  }
                  if(state is LifeUpdatePagesStateStudentView){
                    box.put(DBConstants.lifeUpdateType, 'student');
                    return const StudentLifeUpdateView();
                  }
                  if(state is LifeUpdatePagesStateCorpMemberView){
                    box.put(DBConstants.lifeUpdateType, 'corper');
                    return const CorpMemberLifeUpdateView();
                  }
                  if(state is LifeUpdatePagesStateEmployedView){
                    box.put(DBConstants.lifeUpdateType, 'employed');
                    return const EmployedLifeUpdateView();
                  }
                  if(state is LifeUpdatePagesStateSelfEmployedView){
                    box.put(DBConstants.lifeUpdateType, 'selfEmployed');
                    return const SelfEmployedLifeUpdateView();
                  }
                  return const LifeUpdateOptionsPage();
                },
              ),
            ],
          )
        )
      ),
    );
  }

}