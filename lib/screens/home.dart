// import 'package:flutter/src/widgets/placeholder.dart';

// import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_final_project/screens/help_page.dart';
import 'package:flutter_final_project/screens/medication_page.dart';
import 'package:flutter_final_project/screens/rewards_page.dart';
import 'package:flutter_final_project/widgets/bottom_navbar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/connect_to_user.dart';
import '../widgets/image_avatar.dart';
import '../widgets/reuseable_appbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser.uid;

  // DocumentReference userName = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(FirebaseAuth.instance.currentUser.uid);

  // String firstName = '';

  // @override
  // void initState() async {
  //   super.initState();
  //   userName.get().then((DocumentSnapshot ds) {
  //     firstName = ds['image_url'];
  //     print(firstName);
  //   });
  // }

  // const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: 'Home',
      ),
      // bottomNavigationBar: BottomNavBar(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ImageAvatar(),
          ConnectToUser(),
        ],
      )),
    );
  }
}
