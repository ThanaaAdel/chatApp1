import 'package:chat_project/chat/screens/widgets/chat_widget.dart';
import 'package:chat_project/export.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chat_text_field.dart';

class ChattingScreen extends StatelessWidget {
  const ChattingScreen({super.key, required this.userId});
  final String userId; // ✅ المستخدم الذي يتم الدردشة معه

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser; // ✅ معرفة المستخدم الحالي

    if (currentUser == null) {
      return const Center(child: Text("يرجى تسجيل الدخول لمتابعة الدردشة"));
    }

    String currentUserId = currentUser.uid; // ✅ تخزين معرف المستخدم الحالي
    String receiverId = userId; // ✅ المستخدم الذي يتم الدردشة معه

    return Scaffold(
      body: BlocProvider(
        create: (context) => ChatCubit(),
        child: Column(
          children: [
            CustomMainAppBar(
              leadingWidget: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SvgPicture.asset(ImageAssets.arrowRight),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: CustomContainerWithShadow(
                      color: AppColors.secondPrimary,
                      reduis: 8.r,
                      width: 40.h,
                      height: 40.h,
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0.h),
                        child: const CustomNetworkImage(
                          image:
                          "https://static.vecteezy.com/system/resources/previews/037/276/125/non_2x/ai-generated-3d-cartoon-arab-man-smiling-closeup-halfbody-isolated-on-transparent-background-free-png.png",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("عبدالله القحطاني",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.white)),
                        Text("موظف الميداني",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300,
                                color: AppColors.white))
                      ],
                    ),
                  )
                ],
              ),
              actionWidget: [SvgPicture.asset(ImageAssets.addIcon)],
            ),
            Expanded(
              child: ChatScreen(
                currentUserId: currentUserId, // ✅ معرف المستخدم الحالي
                receiverId: receiverId, // ✅ معرف المستخدم الذي يتم الدردشة معه
              ),
            ),
            ChatTextField(
              currentUserId: currentUserId, // ✅ تمرير معرف المستخدم الحالي
              receiverId: receiverId, // ✅ تمرير معرف المستخدم الذي يتم الدردشة معه
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }
}
