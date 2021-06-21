import 'package:flutter/material.dart';
import 'package:firebase_employee/res/custom_colors.dart';
import 'package:firebase_employee/utils/departement.dart';
import 'package:firebase_employee/utils/validator.dart';

import 'custom_form_field.dart';

class EditDeptForm extends StatefulWidget {
  final FocusNode idFocusNode;
  final FocusNode namaFocusNode;
  final FocusNode tempatFocusNode;
  final String currentId;
  final String currentNama;
  final String currentTempat;
  final String documentId;

  const EditDeptForm({
    this.idFocusNode,
    this.namaFocusNode,
    this.tempatFocusNode,
    this.currentId,
    this.currentNama,
    this.currentTempat,
    this.documentId,
  });

  @override
  _EditDeptFormState createState() => _EditDeptFormState();
}

class _EditDeptFormState extends State<EditDeptForm> {
  final _editDeptFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  TextEditingController _idController;
  TextEditingController _namaController;
  TextEditingController _tempatController;

  @override
  void initState() {
    _idController = TextEditingController(
      text: widget.currentId,
    );

    _namaController = TextEditingController(
      text: widget.currentNama,
    );

    _tempatController = TextEditingController(
      text: widget.currentTempat,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _editDeptFormKey,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  bottom: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0),
                    Text(
                      'ID',
                      style: TextStyle(
                        color: CustomColors.firebaseGrey,
                        fontSize: 15.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    CustomFormField(
                      isLabelEnabled: false,
                      controller: _idController,
                      focusNode: widget.idFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) => Validator.validateField(
                        value: value,
                      ),
                      label: 'ID',
                      hint: 'Enter your id here',
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Nama',
                      style: TextStyle(
                        color: CustomColors.firebaseGrey,
                        fontSize: 15.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    CustomFormField(
                      isLabelEnabled: false,
                      controller: _namaController,
                      focusNode: widget.namaFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) => Validator.validateField(
                        value: value,
                      ),
                      label: 'Nama',
                      hint: 'Enter your name here',
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Tempat',
                      style: TextStyle(
                        color: CustomColors.firebaseGrey,
                        fontSize: 15.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    CustomFormField(
                      isLabelEnabled: false,
                      controller: _tempatController,
                      focusNode: widget.tempatFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) => Validator.validateField(
                        value: value,
                      ),
                      label: 'Tempat',
                      hint: 'Enter your location here',
                    ),
                    SizedBox(height: 50.0),
                  ],
                ),
              ),
              _isProcessing
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          CustomColors.firebaseOrange,
                        ),
                      ),
                    )
                  : Container(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            CustomColors.firebaseOrange,
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          widget.idFocusNode.unfocus();
                          widget.namaFocusNode.unfocus();
                          widget.tempatFocusNode.unfocus();

                          if (_editDeptFormKey.currentState.validate()) {
                            setState(() {
                              _isProcessing = true;
                            });

                            await Departement.updateDept(
                              docId: widget.documentId,
                              id: _idController.text,
                              namaDept: _namaController.text,
                              tempat: _tempatController.text,
                            );

                            setState(() {
                              _isProcessing = false;
                            });

                            Navigator.of(context).pop();
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 16.0, bottom: 16.0, right: 16.0, left: 16.0),
                          child: Text(
                            'UPDATE DEPARTEMENT',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.firebaseGrey,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
