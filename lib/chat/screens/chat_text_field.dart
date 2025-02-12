import 'dart:io';
import 'package:chat_project/chat/screens/widgets/chat_widget.dart';
import 'package:chat_project/export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
class ChatTextField extends StatefulWidget {
  final String currentUserId;
  final String receiverId;

  const ChatTextField({super.key, required this.currentUserId, required this.receiverId});

  @override
  _ChatTextFieldState createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final TextEditingController _controller = TextEditingController();

  void sendMessage() {
    if (_controller.text.trim().isEmpty) {
      print("❌ لا يمكن إرسال رسالة فارغة!");
      return;
    }

    List<String> ids = [widget.currentUserId, widget.receiverId];
    ids.sort();
    String chatId = ids.join("_");

    FirebaseFirestore.instance.collection('messages').add({
      'bodyMessage': _controller.text.trim(),
      'time': FieldValue.serverTimestamp(),
      'senderId': widget.currentUserId,
      'receiverId': widget.receiverId,
      'chatId': chatId,
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "اكتب رسالتك...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: sendMessage,
          ),
        ],
      ),
    );
  }
}
