import 'package:flutter/material.dart';
import 'package:firebase_employee/res/custom_colors.dart';
import 'package:firebase_employee/screens/edit_screen_dept.dart';
import 'package:firebase_employee/utils/departement.dart';

class DeptList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Departement.readDept(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              var noteInfo = snapshot.data.docs[index].data();
              String docID = snapshot.data.docs[index].id;
              String id = noteInfo['id'];
              String namaDept = noteInfo['namaDept'];
              String tempat = noteInfo['tempat'];

              return Ink(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  leading: Icon(Icons.category_sharp),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditDeptScreen(
                        currentId: id,
                        currentNama: namaDept,
                        currentTempat: tempat,
                        documentId: docID,
                      ),
                    ),
                  ),
                  title: Text(
                    "ID : " + id,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    "Nama : " + namaDept,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Icon(Icons.edit_sharp),
                  selected: true,
                ),
              );
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              CustomColors.firebaseOrange,
            ),
          ),
        );
      },
    );
  }
}
