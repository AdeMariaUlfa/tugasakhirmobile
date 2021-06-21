import 'package:flutter/material.dart';
import 'package:firebase_employee/res/custom_colors.dart';
import 'package:firebase_employee/utils/departement.dart';
import 'package:firebase_employee/widgets/app_bar_title.dart';
import 'package:firebase_employee/widgets/edit_dept_form.dart';

class EditDeptScreen extends StatefulWidget {
  final String currentId;
  final String currentNama;
  final String currentTempat;
  final String documentId;

  EditDeptScreen({
    this.currentId,
    this.currentNama,
    this.currentTempat,
    this.documentId,
  });

  @override
  _EditScreenDeptState createState() => _EditScreenDeptState();
}

class _EditScreenDeptState extends State<EditDeptScreen> {
  final FocusNode _idFocusNode = FocusNode();
  final FocusNode _namaFocusNode = FocusNode();
  final FocusNode _tempatFocusNode = FocusNode();

  bool _isDeleting = false;

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
          actions: [
            _isDeleting
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      right: 16.0,
                    ),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.redAccent,
                      ),
                      strokeWidth: 3,
                    ),
                  )
                : IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                      size: 32,
                    ),
                    onPressed: () async {
                      setState(() {
                        _isDeleting = true;
                      });

                      await Departement.deleteDept(
                        docId: widget.documentId,
                      );

                      setState(() {
                        _isDeleting = false;
                      });

                      Navigator.of(context).pop();
                    },
                  ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: EditDeptForm(
              documentId: widget.documentId,
              idFocusNode: _idFocusNode,
              namaFocusNode: _namaFocusNode,
              tempatFocusNode: _tempatFocusNode,
              currentId: widget.currentId,
              currentNama: widget.currentNama,
              currentTempat: widget.currentTempat,
            ),
          ),
        ),
      ),
    );
  }
}
