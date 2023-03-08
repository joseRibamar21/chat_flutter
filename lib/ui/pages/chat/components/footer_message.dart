/* import 'dart:convert';
import 'package:image_picker/image_picker.dart'; */

import 'package:flutter/material.dart';

class FooterMessage extends StatelessWidget {
  final Function(String image64) sendImage;
  final TextEditingController controller;
  final Function() sendMessage;
  final Function(String? value) typing;
  const FooterMessage(
      {Key? key,
      required this.sendImage,
      required this.controller,
      required this.typing,
      required this.sendMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(12.0))),
          child: Row(
            children: [
              /* IconButton(
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    // Capture a photo
                    final XFile? photo = await picker.pickImage(
                        source: ImageSource.camera, imageQuality: 12);
                    if (photo != null) {
                      List<int> imageBytes = await photo.readAsBytes();
                      sendImage(base64Encode(imageBytes));
                    }
                  },
                  icon: const Icon(Icons.photo_camera)), */
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  autofocus: false,
                  controller: controller,
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.multiline,
                  autocorrect: true,
                  enableSuggestions: true,
                  onChanged: (value) {
                    typing.call(value);
                  },
                  maxLines: 4,
                  minLines: 1,
                  toolbarOptions: const ToolbarOptions(
                      copy: true, cut: true, selectAll: true, paste: true),
                  onEditingComplete: sendMessage,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: const InputDecoration(
                      hintText: "Escreva uma mensagem..."),
                ),
              )),
              IconButton(
                onPressed: sendMessage,
                icon: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
