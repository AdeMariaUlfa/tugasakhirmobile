import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_employee/screens/add_screen_dept.dart';
import 'package:firebase_employee/screens/dashboard_screen_dept.dart';
import 'package:firebase_employee/screens/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_employee/res/custom_colors.dart';
import 'package:firebase_employee/screens/add_screen.dart';
import 'package:firebase_employee/login_page.dart';
import 'package:firebase_employee/sign_in.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 15);
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // final name = 'Ade Maria Ulfa';
    // final email = 'ademariaulfaa@gmail.com';
    // final urlImage =
    //     'https://i.pinimg.com/originals/53/d5/85/53d585645dc8b46af8ec724961872aca.jpg';
    final notif = 'dont forget to a wear mask!';

    return Drawer(
      child: Material(
        color: CustomColors.firebaseNavy,
        child: ListView(
          padding: padding,
          children: <Widget>[
            buildHeader(
              imageUrl: imageUrl,
              email: _auth.currentUser.email,
              notif: notif,
            ),
            buildMenuItem(
              text: 'Add Data Employee',
              icon: Icons.my_library_add,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 20),
            buildMenuItem(
              text: 'Add Departement',
              icon: Icons.my_library_books,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 28),
            Divider(color: Colors.white70),
            const SizedBox(height: 28),
            buildMenuItem(
              text: 'View Data Employee',
              icon: Icons.account_box,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(height: 20),
            buildMenuItem(
              text: 'View Data Departement',
              icon: Icons.account_tree,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(height: 28),
            Divider(color: Colors.white70),
            const SizedBox(height: 28),
            buildMenuItem(
              text: 'Logout',
              icon: Icons.logout,
              onClicked: () => selectedItem(context, 4),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    String text,
    IconData icon,
    VoidCallback onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}

buildHeader({String imageUrl, String name, String email, String notif}) =>
    InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Row(
          children: [
            CircleAvatar(radius: 30, backgroundImage: NetworkImage(imageUrl)),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  email,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  notif,
                  style: TextStyle(fontSize: 10, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );

void selectedItem(BuildContext context, int i) {
  Navigator.of(context).pop();

  switch (i) {
    case 0:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddScreen(),
      ));
      break;
    case 1:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddScreenDept(),
      ));
      break;
    case 2:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DashboardScreen(),
      ));
      break;
    case 3:
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DashboardDeptScreen(),
      ));
      break;
    case 4:
      signOutGoogle();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
        return LoginPage();
      }), ModalRoute.withName('/'));
      break;
  }
}
