import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker1/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<File?> image = ValueNotifier(null);
  ValueNotifier<int> imgIndex = ValueNotifier(0);
  ValueNotifier<bool> click = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xff088178),
          statusBarIconBrightness: Brightness.dark,
        ),
        title: Text(
          'Add Image / Icon',
          style: TextStyle(color: Colors.black.withOpacity(0.6)),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        shadowColor: Colors.grey.withOpacity(0.3),
        leading: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.black.withOpacity(0.6),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.6)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(
                      "Upload Image",
                      style: TextStyle(color: Colors.black.withOpacity(0.5)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        click.value = false;
                        imgIndex.value = 0;
                        pickImage();
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xff088178),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Choose from Device",
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.7)),
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ValueListenableBuilder(
                valueListenable: click,
                builder: (context, bool done, child) {
                  if (done) {
                    return ValueListenableBuilder(
                      valueListenable: image,
                      builder: (context, File? img, child) {
                        if (img == null) {
                          return const SizedBox();
                        }

                        return ValueListenableBuilder(
                          valueListenable: imgIndex,
                          builder: (context, int index, child) {
                            if (index == 1) {
                              return SizedBox(
                                  height: 400,
                                  width: 400,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.file(
                                        File(image.value!.path),
                                        fit: BoxFit.fill,
                                      )));
                            }
                            if (index == 2) {
                              return SizedBox(
                                  height: 400,
                                  width: 400,
                                  child: ClipOval(
                                      child: Image.file(
                                    File(image.value!.path),
                                    fit: BoxFit.fill,
                                  )));
                            }
                            if (index == 3) {
                              return SizedBox(
                                  height: 400,
                                  width: 450,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.file(
                                        File(image.value!.path),
                                        fit: BoxFit.fill,
                                      )));
                            }
                            return SizedBox(
                                height: 400,
                                child: Image.file(File(image.value!.path)));
                          },
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: pickedImage!.path,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop',
            toolbarColor: Colors.grey.shade700,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: false),
      ],
    );
    if (croppedImage != null) {
      image.value = File(croppedImage.path);
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(const Radius.circular(12.0))),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Uploaded Image",
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ValueListenableBuilder(
                        valueListenable: imgIndex,
                        builder: (context, int index, child) {
                          if (index == 1) {
                            return SizedBox(
                                height: 200,
                                width: 200,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      File(image.value!.path),
                                      fit: BoxFit.fill,
                                    )));
                          }
                          if (index == 2) {
                            return SizedBox(
                                height: 200,
                                width: 200,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.file(
                                      File(image.value!.path),
                                      fit: BoxFit.fill,
                                    )));
                          }
                          if (index == 3) {
                            return SizedBox(
                                height: 200,
                                width: 250,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      File(image.value!.path),
                                      fit: BoxFit.fill,
                                    )));
                          }
                          return SizedBox(
                              height: 200,
                              child: Image.file(File(image.value!.path)));
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        children: [
                          GestureDetector(
                            onTap: () {
                              imgIndex.value = 0;
                            },
                            child: Container(
                                height: 60,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  // color: Color(0xff088178),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "Original",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.7),
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              imgIndex.value = 1;
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                decoration: BoxDecoration(
                                  // color: Color(0xff088178),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Image.asset(
                                  K.img2,
                                  height: 50,
                                  width: 50,
                                )),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              imgIndex.value = 2;
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                decoration: BoxDecoration(
                                  // color: Color(0xff088178),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Image.asset(
                                  K.img3,
                                  height: 50,
                                  width: 50,
                                )),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              imgIndex.value = 3;
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                decoration: BoxDecoration(
                                  // color: Color(0xff088178),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Image.asset(
                                  K.img4,
                                  height: 50,
                                  width: 50,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          click.value = true;
                          Navigator.pop(context);
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xff088178),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                "Use This Image",
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.7)),
                              ),
                            ),),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }
}
