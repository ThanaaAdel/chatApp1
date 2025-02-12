import 'package:chat_project/chat/cubit/chat_state.dart';
import 'package:chat_project/export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ✅ استيراد FirebaseAuth

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  int selectedTab = 1;
  void changeTab(int index) {
    selectedTab = index;
    emit(ChangeTabState());
  }

  final TextEditingController controller = TextEditingController();
  final ScrollController controllerListView = ScrollController();

  CollectionReference messages = FirebaseFirestore.instance.collection('messages');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  List<Map<String, dynamic>> usersList = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void fetchUsers() async {
    try {
      emit(ChatLoading()); // ✅ تأكد من عرض اللودينج فقط في البداية

      var usersSnapshot = await _firestore.collection('users').get();

      List<Map<String, dynamic>> users = usersSnapshot.docs.map((doc) {
        var data = doc.data();
        data['userId'] = doc.id; // ✅ تأكد من إضافة الـ userId
        return data;
      }).toList();

      emit(UsersLoaded(users)); // ✅ أرسل الحالة مع البيانات
    } catch (e) {
      emit(ChatError("حدث خطأ أثناء تحميل المستخدمين: $e"));
    }
  }
  void sendMessage(String receiverId, String message) {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null || message.isEmpty) return; // ✅ التأكد من أن المستخدم مسجل والرسالة ليست فارغة

    String senderId = currentUser.uid;

    // ✅ إنشاء chatId باستخدام ترتيب ثابت للمستخدمين
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatId = ids.join("_");

    messages.add({
      'bodyMessage': message,
      'time': FieldValue.serverTimestamp(),
      'senderId': senderId,
      'receiverId': receiverId,
      'chatId': chatId, // ✅ تحديد المحادثة
    });

    emit(MessageSentSuccess());
  }


  /// 🔹 جلب الرسائل من Firestore
  Stream<List<Map<String, dynamic>>> fetchMessages() {
    return messages
        .orderBy('time', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }
}
