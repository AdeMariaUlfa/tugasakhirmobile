import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_employee/res/custom_colors.dart';
import 'package:firebase_employee/utils/database.dart';
import 'package:firebase_employee/utils/departement.dart';
import 'package:firebase_employee/utils/validator.dart';

import 'custom_form_field.dart';

class EditItemForm extends StatefulWidget {
  final FocusNode nipFocusNode;
  final FocusNode namaFocusNode;
  final FocusNode alamatFocusNode;
  final FocusNode nohpFocusNode;
  final String currentNip;
  final String currentNama;
  final String currentDept;
  final String currentAlamat;
  final String currentNohp;
  final String documentId;

  const EditItemForm({
    this.nipFocusNode,
    this.namaFocusNode,
    this.alamatFocusNode,
    this.nohpFocusNode,
    this.currentNip,
    this.currentNama,
    this.currentDept,
    this.currentAlamat,
    this.currentNohp,
    this.documentId,
  });

  @override
  _EditItemFormState createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final _editItemFormKey = GlobalKey<FormState>();

  var selectedDept, selectedType;
  bool _isProcessing = false;

  TextEditingController _nipController;
  TextEditingController _namaController;
  TextEditingController _alamatController;
  TextEditingController _nohpController;

  @override
  void initState() {
    _nipController = TextEditingController(
      text: widget.currentNip,
    );

    _namaController = TextEditingController(
      text: widget.currentNama,
    );

    _alamatController = TextEditingController(
      text: widget.currentAlamat,
    );

    _nohpController = TextEditingController(
      text: widget.currentNohp,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _editItemFormKey,
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
                      'NIP',
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
                      controller: _nipController,
                      focusNode: widget.nipFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) => Validator.validateField(
                        value: value,
                      ),
                      label: 'NIP',
                      hint: 'Enter your nip here',
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
                      hint: 'Enter your nama here',
                    ),
                    SizedBox(height: 8.0),
                    StreamBuilder<QuerySnapshot>(
                      stream: Departement.readDept(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text("Loading...");
                        } else {
                          List<DropdownMenuItem> deptItems = [];
                          for (int i = 0; i < snapshot.data.docs.length; i++) {
                            DocumentSnapshot snap = snapshot.data.docs[i];
                            deptItems.add(DropdownMenuItem(
                              child: Text(
                                snap.get('namaDept'),
                                style: TextStyle(
                                    color: CustomColors.firebaseOrange),
                              ),
                              value: "${snap.get('namaDept')}",
                            ));
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.account_tree,
                                size: 45.0,
                                color: Colors.white70,
                              ),
                              SizedBox(
                                width: 50.0,
                              ),
                              DropdownButton(
                                items: deptItems,
                                onChanged: (deptValue) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                      'selected departement value is $deptValue',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                  setState(() {
                                    selectedDept = deptValue;
                                  });
                                },
                                value: selectedDept,
                                isExpanded: false,
                                hint: new Text(
                                  widget.currentDept,
                                  style: TextStyle(
                                      color: CustomColors.firebaseYellow),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Alamat',
                      style: TextStyle(
                        color: CustomColors.firebaseGrey,
                        fontSize: 15.0,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    CustomFormField(
                      maxLines: 5,
                      isLabelEnabled: false,
                      controller: _alamatController,
                      focusNode: widget.alamatFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.done,
                      validator: (value) => Validator.validateField(
                        value: value,
                      ),
                      label: 'Alamat',
                      hint: 'Enter your alamat here',
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'No Hp',
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
                      controller: _nohpController,
                      focusNode: widget.nohpFocusNode,
                      keyboardType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (value) => Validator.validateField(
                        value: value,
                      ),
                      label: 'No Hp',
                      hint: 'Enter your no hp here',
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
                          widget.nipFocusNode.unfocus();
                          widget.namaFocusNode.unfocus();
                          widget.alamatFocusNode.unfocus();
                          widget.nohpFocusNode.unfocus();

                          if (_editItemFormKey.currentState.validate()) {
                            setState(() {
                              _isProcessing = true;
                            });

                            await Database.updateItem(
                              docId: widget.documentId,
                              nip: _nipController.text,
                              nama: _namaController.text,
                              dept: selectedDept,
                              alamat: _alamatController.text,
                              nohp: _nohpController.text,
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
                            'UPDATE ITEM',
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
