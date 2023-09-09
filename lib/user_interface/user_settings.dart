import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conspirapcy/authentification/add_data.dart';
import 'package:conspirapcy/elements/Button.dart';
import 'package:conspirapcy/elements/default_image.dart';
import 'package:conspirapcy/elements/photo_profil.dart';
import 'package:conspirapcy/elements/pick_image.dart';
import 'package:conspirapcy/elements/text_box_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  Uint8List? _image;
  final String? email = FirebaseAuth.instance.currentUser?.email;
  final currentUser = FirebaseAuth.instance.currentUser!;
  Future<void> selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  Future<void> editfield(String field) async {
    String newvalue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 107, 106, 106),
        title: Text(
          "Modifier $field",
          style: GoogleFonts.poppins(
            color: const Color.fromARGB(250, 0, 0, 0),
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        content: TextField(
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Fait toi plaiz",
            hintStyle: TextStyle(color: Color.fromARGB(42, 255, 255, 255)),
          ),
          onChanged: (value) {
            newvalue = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('ANNULER'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(newvalue);
            },
            child: const Text('CONFIRMER'),
          ),
        ],
      ),
    );

    if (newvalue.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('USER')
          .doc(currentUser.email)
          .update({
        field: newvalue,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(132, 55, 55, 55),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'U S E R  S E T T I N G S',
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        shadowColor: const Color(0xFFEDECF2),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('USER')
              .doc(email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 50,
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        _image != null
                            ? UserPhoto(
                                image: _image!,
                              )
                            : CurrentImage(
                                path: userData['image'],
                              ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Colors.black,
                              ),
                              color: Colors.white,
                            ),
                            child: GestureDetector(
                              child: const Icon(
                                Icons.edit,
                              ),
                              onTap: () async {
                                await selectImage();
                                if (_image != null) {
                                  String imageUrl =
                                      await StoreData().uploadImageToStorage(
                                    'ProfilName',
                                    _image!,
                                  );
                                  FirebaseFirestore.instance
                                      .collection('USER')
                                      .doc(email)
                                      .update({
                                    'image': imageUrl,
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "MES INFOS",
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Textbox(
                      onPressed: () {
                        editfield('Nom du compte');
                      },
                      text: userData['nom_compte'],
                      sectionName: 'Nom du compte',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Textbox(
                      onPressed: () {
                        editfield('Pseudo');
                      },
                      text: userData['pseudo'],
                      sectionName: "Pseudo",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Textbox(
                      onPressed: () {
                        editfield('bio');
                      },
                      text: userData['bio'],
                      sectionName: "Bio",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyButton(
                      onTap: () async {},
                      text: 'C O N F I R M E R',
                    ),
                    const SizedBox(
                      height: 20,
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
        ),
      ),
    );
  }
}
