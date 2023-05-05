import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ConnectToUser extends StatelessWidget {
  // const ImageAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser.uid;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (!chatSnapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data;
        // final img_url2 = chatDocs.get('image_url');
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final img_url = chatDocs.data().toString().contains('image_url')
            ? chatDocs.get('image_url')
            : '';
        final username = chatDocs.data().toString().contains('username')
            ? chatDocs.get('username')
            : '';
        final usertype = chatDocs.data().toString().contains('usertype')
            ? chatDocs.get('usertype')
            : '';

        return Container(
          // height: 250,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Connect to Patient',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
                Card(
                    margin: EdgeInsets.all(20),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Icon(
                              Icons.person_add,
                              size: 50,
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(CircleBorder()),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(20)),
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.red), // <-- Button color
                            ),
                          ),
                          Text('Currently Connected To : ')
                        ],
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
