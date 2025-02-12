import 'package:chat_project/chat/screens/login_screen.dart';
import 'package:chat_project/chat/screens/widgets/chat_widget.dart';
import 'package:chat_project/export.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  String? currentUserId;
  Map<String, dynamic>? currentUserData;

  @override
  void initState() {
    super.initState();
    checkUserLoggedIn(); // ✅ التحقق من حالة تسجيل الدخول
  }

  /// ✅ التحقق مما إذا كان المستخدم قد سجل الدخول مسبقًا
  void checkUserLoggedIn() async {
    var currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      setState(() {
        currentUserId = currentUser.uid;
      });

      fetchCurrentUserData(); // ✅ جلب بيانات المستخدم الحالي
      context.read<ChatCubit>().fetchUsers(); // ✅ جلب المستخدمين فقط عند التأكد من تسجيل الدخول
    } else {
      // إذا لم يكن المستخدم مسجلاً، انتقل إلى شاشة تسجيل الدخول
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()), // ✅ توجيه المستخدم إلى شاشة تسجيل الدخول
      );
    }
  }

  /// 🔥 جلب بيانات المستخدم الحالي من Firestore
  void fetchCurrentUserData() async {
    if (currentUserId == null) return;

    try {
      var userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();

      if (userSnapshot.exists) {
        setState(() {
          currentUserData = userSnapshot.data();
        });
      }
    } catch (e) {
      print("❌ خطأ أثناء جلب بيانات المستخدم: $e");
    }
  }

  /// 🔥 تسجيل الخروج
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: currentUserData != null
            ? Row(
          children: [

            Text(currentUserData!['name'] ?? "المستخدم الحالي"), // ✅ اسمه
          ],
        )
            : const Text("المستخدمون"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          )
        ],
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ChatError) {
            return Center(child: Text(state.message));
          }

          if (state is UsersLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                var user = state.users[index];

                // ✅ لا تعرض المستخدم الحالي في القائمة
                if (user['userId'] == currentUserId) return const SizedBox();

                return FutureBuilder<Map<String, dynamic>?>(
                  future: FirebaseFirestore.instance
                      .collection('messages')
                      .where('chatId', whereIn: [
                    "${currentUserId}_${user['userId']}",
                    "${user['userId']}_$currentUserId"
                  ])
                      .orderBy('time', descending: true)
                      .limit(1)
                      .get()
                      .then((snapshot) => snapshot.docs.isNotEmpty ? snapshot.docs.first.data() as Map<String, dynamic>? : null),
                  builder: (context, snapshot) {
                    String lastMessage = "ابدأ المحادثة الآن...";
                    if (snapshot.hasData && snapshot.data != null) {
                      lastMessage = snapshot.data!['bodyMessage'] ?? "📷 صورة";
                    }

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user['profileImage'] ?? "https://as1.ftcdn.net/v2/jpg/03/46/83/96/1000_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"),
                      ),
                      title: Text(user['name']),
                      subtitle: Text(lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              currentUserId: currentUserId!,
                              receiverId: user['userId'],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );

              },
            );
          }

          return const Center(child: Text("لا يوجد مستخدمون"));
        },
      ),
    );
  }
}
