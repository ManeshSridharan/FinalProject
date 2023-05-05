import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;

  CustomAppBar({
    @required this.title,
    @required this.backgroundColor,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: backgroundColor,
      actions: [
        DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            // icon: CircleAvatar(
            //     // backgroundImage: NetworkImage(img_url),
            //     ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 8,
                    ),
                    Text('logout'),
                  ]),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            })
      ],
    );
  }
}
