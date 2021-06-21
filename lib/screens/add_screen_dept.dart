import 'package:flutter/material.dart';
import 'package:firebase_employee/res/custom_colors.dart';
import 'package:firebase_employee/widgets/add_dept_form.dart';
import 'package:firebase_employee/widgets/app_bar_title.dart';

class AddScreenDept extends StatelessWidget {
  final FocusNode _idFocusNode = FocusNode();
  final FocusNode _namaFocusNode = FocusNode();
  final FocusNode _tempatFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _idFocusNode.unfocus();
        _namaFocusNode.unfocus();
        _tempatFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: CustomColors.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.firebaseNavy,
          title: AppBarTitle(),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: AddDeptForm(
              idFocusNode: _idFocusNode,
              namaFocusNode: _namaFocusNode,
              tempatFocusNode: _tempatFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
