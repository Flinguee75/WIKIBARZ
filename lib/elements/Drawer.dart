// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conspirapcy/elements/default_image.dart';
import 'package:conspirapcy/elements/my_list_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawer extends StatefulWidget {
  final void Function()? onuserfunction;
  final void Function()? logoutfunction;

  const MyDrawer(
      {super.key, required this.onuserfunction, required this.logoutfunction});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('USER')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          final String pseudo = userData['nom_compte'];
          return Drawer(
            backgroundColor: const Color.fromARGB(255, 62, 62, 62),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    DrawerHeader(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                            child: CurrentImage(
                              path: userData['image'],
                            ),
                          ),
                          Text(
                            pseudo,
                            style: GoogleFonts.poppins(
                              color: Colors.white54,
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MyListTile(
                      icon: Icons.home,
                      text: "H O M E",
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    MyListTile(
                      icon: Icons.person,
                      text: "U S E R",
                      onTap: widget.onuserfunction,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: MyListTile(
                    icon: Icons.logout,
                    text: "L O G O U T",
                    onTap: widget.logoutfunction,
                  ),
                ),
              ],
            ),
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
    );
  }
}
