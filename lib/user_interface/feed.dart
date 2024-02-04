import 'package:conspirapcy/user_interface/post_barz.dart';
import 'package:conspirapcy/user_interface/user_settings.dart';
import 'package:conspirapcy/user_interface/wallpost.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../elements/Drawer.dart';

class user_page extends StatefulWidget {
  const user_page({super.key});

  @override
  State<user_page> createState() => _user_pageState();
}

class _user_pageState extends State<user_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        shadowColor: const Color(0xFFEDECF2),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              size: 20,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Image.asset(
          'images/titre.png',
          height: 30,
        ),
      ),
      drawer: MyDrawer(
        onuserfunction: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UserSettings(),
            ),
          );
        },
        logoutfunction: FirebaseAuth.instance.signOut,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Post(),
            ),
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 7,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('POST')
                  .orderBy(
                    'time',
                    descending: false,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];

                      return WallPost(
                          username: post['pseudo'],
                          barz: post['barz'],
                          imagepath: post['photo_profile'],
                          image: post['image']);
                    },
                  );
                } else if (snapshot.hasError) {
                  Center(
                    child: Text(
                      'Error : ${snapshot.error}',
                      style: const TextStyle(
                        height: 50,
                      ),
                    ),
                  );
                }
                return const SizedBox(
                  height: 30,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
