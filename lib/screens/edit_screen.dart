import 'package:flutter/material.dart';
import 'package:firebase_employee/res/custom_colors.dart';
import 'package:firebase_employee/utils/database.dart';
import 'package:firebase_employee/widgets/app_bar_title.dart';
import 'package:firebase_employee/widgets/edit_item_form.dart';

class EditScreen extends StatefulWidget {
  final String currentNip;
  final String currentNama;
  final String currentDept;
  final String currentAlamat;
  final String currentNohp;
  final String documentId;

  EditScreen({
    this.currentNip,
    this.currentNama,
    this.currentDept,
    this.currentAlamat,
    this.currentNohp,
    this.documentId,
  });

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final FocusNode _nipFocusNode = FocusNode();
  final FocusNode _namaFocusNode = FocusNode();
  final FocusNode _deptFocusNode = FocusNode();
  final FocusNode _alamatFocusNode = FocusNode();
  final FocusNode _nohpFocusNode = FocusNode();

  bool _isDeleting = false;

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

                      await Database.deleteItem(
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
            child: EditItemForm(
              documentId: widget.documentId,
              nipFocusNode: _nipFocusNode,
              namaFocusNode: _namaFocusNode,
              alamatFocusNode: _alamatFocusNode,
              nohpFocusNode: _nohpFocusNode,
              currentNip: widget.currentNip,
              currentNama: widget.currentNama,
              currentDept: widget.currentDept,
              currentAlamat: widget.currentAlamat,
              currentNohp: widget.currentNohp,
            ),
          ),
        ),
      ),
    );
  }
}
