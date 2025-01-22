import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageSheet extends StatefulWidget {
  final Function(File img) onImageSelected;

  const SelectImageSheet({super.key, required this.onImageSelected});

  @override
  State<SelectImageSheet> createState() => _SelectImageSheetState();
}

class _SelectImageSheetState extends State<SelectImageSheet> {
  void pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    File img = File(image.path);

    widget.onImageSelected(img);
  }

  void showSelectPhotoOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.drag_handle_rounded,
                color: Colors.grey,
              ),
              ElevatedButton(
                onPressed: () => pickImage(ImageSource.gallery),
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  backgroundColor: Colors.grey.shade200,
                  shape: const StadiumBorder(),
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_rounded,
                      color: Colors.black,
                    ),
                    Gap(14),
                    Text(
                      'Browse Gallery',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              const Gap(10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 5, right: 15),
                      child: const Divider(
                        // color: Colors.white,
                        height: 10,
                      ),
                    ),
                  ),
                  const Text(
                    'or',
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15, right: 5),
                      child: const Divider(
                        // color: Colors.white,
                        height: 10,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              ElevatedButton(
                onPressed: () => pickImage(ImageSource.camera),
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  backgroundColor: Colors.grey.shade200,
                  shape: const StadiumBorder(),
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                    ),
                    Gap(14),
                    Text(
                      'Open Camera',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: showSelectPhotoOptions,
      icon: const Icon(Icons.camera_alt),
    );
  }
}
