import 'package:flutter/material.dart';
import 'package:firebase_employee/res/custom_colors.dart';
import 'package:firebase_employee/screens/edit_screen.dart';
import 'package:firebase_employee/utils/database.dart';
import 'package:firebase_employee/widgets/add_item_form.dart';

class ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Database.readItems(),
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
              String nip = noteInfo['nip'];
              String nama = noteInfo['nama'];
              String dept = noteInfo['dept'];
              String alamat = noteInfo['alamat'];
              String nohp = noteInfo['nohp'];

              return Ink(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  leading: Icon(Icons.assignment_ind_rounded),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditScreen(
                        currentNip: nip,
                        currentNama: nama,
                        currentDept: dept,
                        currentAlamat: alamat,
                        currentNohp: nohp,
                        documentId: docID,
                      ),
                    ),
                  ),
                  title: Text(
                    "Nama : " + nama,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    "NIP : " + nip,
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
