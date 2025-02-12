import 'package:chat_project/export.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:8.w,vertical: 4.h),
      child: Container(
        padding:  EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile image
            CustomContainerWithShadow(
              color: AppColors.secondPrimary,
              reduis: 8.r,
              child: CustomNetworkImage(
                image:
                "https://static.vecteezy.com/system/resources/previews/037/276/125/non_2x/ai-generated-3d-cartoon-arab-man-smiling-closeup-halfbody-isolated-on-transparent-background-free-png.png",
                height: 40.h,
                width: 40.h,
              ),
            ),

            SizedBox(width: 12.w),
            // Text section
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'عبد الله محمد القحطاني', // Name
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: AppColors.black,
                    ),
                     maxLines: 1,
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Padding(
                       padding:  EdgeInsets.only(top:8.0,left: 2.w),
                       child: SvgPicture.asset(ImageAssets.seen,width: 12.w,height: 6.h,),
                     ),
                     // SizedBox(width: 8),
                      Flexible(
                        child: Text(
                            "السلام عليكم، خالد. وصلتك تفاصيل المهمة الجديد...",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),

                          maxLines: 1,
                          overflow:TextOverflow.ellipsis ,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );;
  }
}
