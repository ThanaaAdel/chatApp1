
import 'package:chat_project/chat/screens/login_screen.dart';
import 'package:chat_project/chat/screens/users_screen.dart';
import 'package:chat_project/export.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.setLanguageCode("ar");
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug, // ✅ وضع التطوير
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat',
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(), // ✅ التحقق من حالة المستخدم عند التشغيل
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator()); // ✅ عرض لودينج أثناء التحقق
            }
            if (snapshot.hasData && snapshot.data != null) {
              // ✅ المستخدم مسجل الدخول، انتقل إلى UsersScreen
              return BlocProvider(
                create: (context) => ChatCubit(),
                child: UsersScreen(

                    ),
              );
            }
            // ✅ المستخدم غير مسجل، أظهر شاشة تسجيل الدخول
            return BlocProvider(
              create: (context) => ChatCubit(),
              child: const LoginScreen(),
            );
          },
        ),
      ),
    );
  }
}

