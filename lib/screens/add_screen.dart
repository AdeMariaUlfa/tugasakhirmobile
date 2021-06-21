import 'package:flutter/material.dart';
import 'package:firebase_employee/res/custom_colors.dart';
import 'package:firebase_employee/widgets/add_item_form.dart';
import 'package:firebase_employee/widgets/app_bar_title.dart';

class AddScreen extends StatelessWidget {
  final FocusNode _nipFocusNode = FocusNode();
  final FocusNode _namaFocusNode = FocusNode();
  final FocusNode _alamatFocusNode = FocusNode();
  final FocusNode _nohpFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _nipFocusNode.unfocus();
        _namaFocusNode.unfocus();
        _alamatFocusNode.unfocus();
        _nohpFocusNode.unfocus();
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
            child: AddItemForm(
              nipFocusNode: _nipFocusNode,
              namaFocusNode: _namaFocusNode,
              alamatFocusNode: _alamatFocusNode,
              nohpFocusNode: _nohpFocusNode,
            ),
          ),
        ),
      ),
    );
  }
}
