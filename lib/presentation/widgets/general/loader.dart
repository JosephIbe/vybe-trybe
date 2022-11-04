import 'package:flutter/material.dart';
import 'package:trybe_one_mobile/presentation/journeys/themes/app_colors.dart';

class Loader extends StatelessWidget {

  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(TrybeColors.primaryRed),
          ),
        ),
      ),
    );
  }

}