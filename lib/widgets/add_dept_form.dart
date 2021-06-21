import 'package:firebase_employee/utils/departement.dart';
import 'package:flutter/material.dart';
import 'package:firebase_employee/res/custom_colors.dart';
import 'package:firebase_employee/utils/validator.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_employee/widgets/dept_list.dart';
import 'custom_form_field.dart';

class AddDeptForm extends StatefulWidget {
  final FocusNode idFocusNode;
  final FocusNode namaFocusNode;
  final FocusNode tempatFocusNode;

  const AddDeptForm({
    this.idFocusNode,
    this.namaFocusNode,
    this.tempatFocusNode,
  });

  @override
  _AddDeptFormState createState() => _AddDeptFormState();
}

class _AddDeptFormState extends State<AddDeptForm> {
  final _addDeptFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tempatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addDeptFormKey,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 8.0,
                    right: 8.0,
                    bottom: 24.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 15.0),
                      Text(
                        'ID',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      CustomFormField(
                        isLabelEnabled: false,
                        controller: _idController,
                        focusNode: widget.idFocusNode,
                        keyboardType: TextInputType.number,
                        inputAction: TextInputAction.next,
                        validator: (value) => Validator.validateField(
                          value: value,
                        ),
                        label: 'ID',
                        hint: 'Enter your id here',
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        'Nama',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15.0,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6.0),
                      CustomFormField(
                        isLabelEnabled: false,
                        controller: _namaController,
                        focusNode: widget.namaFocusNode,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        validator: (value) => Validator.validateField(
                          value: value,
                        ),
                        label: 'Nama Departement',
                        hint: 'Enter your name departement here',
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        'Tempat',
                        style: TextStyle(
                          color: Colors.white70,
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
                    ],
                  ),
                ),
                _isProcessing
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
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

                            if (_addDeptFormKey.currentState.validate()) {
                              setState(() {
                                _isProcessing = true;
                              });

                              await Departement.addDept(
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
                                top: 15.0,
                                bottom: 15.0,
                                left: 15.0,
                                right: 15.0),
                            child: Text(
                              'ADD DEPARTEMENT',
                              style: TextStyle(
                                fontSize: 18,
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
        },
      ),
    );
  }
}
