
import 'package:chat_project/export.dart';

class CustomChatAppBar extends StatefulWidget {
  const CustomChatAppBar({super.key});

  @override
  State<CustomChatAppBar> createState() => _CustomChatAppBarState();
}

class _CustomChatAppBarState extends State<CustomChatAppBar> {
  @override
  void initState() {
    context.read<ChatCubit>().selectedTab == 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ChatCubit>();
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (BuildContext context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 0.h, top: 15.h),
              child: CustomContainerWithShadow(
                isShadow: false,
                reduis: 8.r,
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      // رسائل Tab
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            cubit.changeTab(0);
                          },
                          child: Container(
                            color: AppColors.transparent,
                            child: IntrinsicWidth(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 6.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .stretch, // يجعل العرض ممتدًا
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.symmetric(
                                          vertical: 1.0.h, horizontal: 1.w),
                                      child: Container(
                                        height: 2,
                                        decoration: BoxDecoration(
                                          color: cubit.selectedTab == 0
                                              ? AppColors.primary
                                              : AppColors.transparent,
                                        ),
                                      ),
                                    ),
                                   5.h.verticalSpace,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          ImageAssets.messages,
                                          color: cubit.selectedTab == 0
                                              ? AppColors.primary
                                              : AppColors.grey,
                                        ),
                                        5.w.horizontalSpace,
                                        Text(
                                          "رسالة",
                                          style: TextStyle(
                                            color: cubit.selectedTab == 0
                                                ? AppColors.primary
                                                : AppColors.grey,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        5.w.horizontalSpace,
                                        CustomContainerWithShadow(
                                          isShadow: false,
                                          color: cubit.selectedTab == 0
                                              ? AppColors.secondPrimary
                                              : AppColors.greyLight,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text("75",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: cubit.selectedTab == 0
                                                      ? AppColors.primary
                                                      : AppColors.black,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: .7.w,
                        color: AppColors.grey,
                      ),
                      // فريق العمل Tab
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            cubit.changeTab(1);
                          },
                          child: Container(
                            color: AppColors.transparent,
                            child: IntrinsicWidth(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 6.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .stretch, // يجعل العرض ممتدًا

                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1.0, horizontal: 1),
                                      child: Container(
                                        height: 2,
                                        decoration: BoxDecoration(
                                          color: cubit.selectedTab == 1
                                              ? AppColors.primary
                                              : AppColors.transparent,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          ImageAssets.users,
                                          color: cubit.selectedTab == 1
                                              ? AppColors.primary
                                              : AppColors.grey,
                                        ),
                                        5.w.horizontalSpace,
                                        Text(
                                          "الفريق الميداني",
                                          style: TextStyle(
                                            color: cubit.selectedTab == 1
                                                ? AppColors.primary
                                                : AppColors.grey,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        5.w.horizontalSpace,
                                        CustomContainerWithShadow(
                                          isShadow: false,
                                          color: cubit.selectedTab == 1
                                              ? AppColors.secondPrimary
                                              : AppColors.greyLight,
                                          child: Padding(
                                            padding:  EdgeInsets.symmetric(
                                                horizontal: 10.h, vertical: 5.w),
                                            child: Text("75",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: cubit.selectedTab == 1
                                                      ? AppColors.primary
                                                      : AppColors.black,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        );
      },
    );
  }
}
