import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conspirapcy/animation/Fade_Animation.dart';
import 'package:conspirapcy/elements/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../authentification/add_data.dart';

import '../elements/pick_image.dart';

class Post extends StatefulWidget {
  const Post({
    super.key,
  });

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final postTextController = TextEditingController();
  final genderTextController = TextEditingController();
  final String? email = FirebaseAuth.instance.currentUser?.email;
  String imageUrl = "";
  Uint8List? _image;

  Future<void> selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void postbarz() {
    if (postTextController.text.isNotEmpty &
        genderTextController.text.isEmpty) {
      FirebaseFirestore.instance.collection('USER').doc(email).get().then(
        (DocumentSnapshot doc) async {
          final data = doc.data() as Map<String, dynamic>;

          if (_image == null) {
            FirebaseFirestore.instance.collection('POST').add({
              'barz': postTextController.text,
              'pseudo': data['nom_compte'],
              'time': Timestamp.now(),
              'photo_profile': data['image'],
            });
          } else {
            FirebaseFirestore.instance.collection('POST').add({
              'barz': postTextController.text,
              'pseudo': data['nom_compte'],
              'time': Timestamp.now(),
              'photo_profile': data['image'],
              'image':
                  await StoreData().uploadImageToStorage('PostImage', _image!),
            });
          }
        },
        onError: (e) => print('Error :$e'),
      );
    }

    genderTextController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'images/titre.png',
          height: 30,
        ),
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        shadowColor: const Color(0xFFEDECF2),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('USER')
            .doc(email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(userData['image']),
                        radius: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MyTextField(
                      controller: postTextController,
                      hintText: "Faites vous entendre...",
                      obsureText: false,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    MyTextField(
                      controller: genderTextController,
                      hintText: "Definissez votre genre musical... ",
                      obsureText: false,
                    ),
                    _image != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              fadeIn_fadeOut(
                                delay: 3,
                                image: Container(
                                  margin: const EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.memory(
                                      _image!,
                                      height: 230,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _image = null;
                                  });
                                },
                                icon: const Icon(Icons.close),
                                color: Colors.white,
                              )
                            ],
                          )
                        : const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.add_a_photo_rounded,
                          ),
                          color: Colors.white,
                          onPressed: () async {
                            await selectImage();
                            if (_image != null) {
                              imageUrl = await StoreData().uploadImageToStorage(
                                'PostImage',
                                _image!,
                              );
                            }
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed: postbarz,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.all(13),
                              shape: const StadiumBorder(),
                            ),
                            child: Text(
                              "CONFIRMER",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
      ),
    );
  }
}
