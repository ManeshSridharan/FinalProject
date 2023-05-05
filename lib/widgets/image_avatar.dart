import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageAvatar extends StatelessWidget {
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
                  'Your Profile',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
                Card(
                  // color: Colors.white70, // learn how to use custom colors
                  shadowColor: Colors.red,
                  // surfaceTintColor: Colors.amber,
                  margin: EdgeInsets.all(20),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CachedNetworkImage(
                          imageUrl: img_url,
                          imageBuilder: (context, imageProvider) => Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(75)),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Column contents vertically,
                          crossAxisAlignment: CrossAxisAlignment
                              .center, //Center Column contents horizontally,
                          children: [
                            Text(
                              username,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              usertype,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
