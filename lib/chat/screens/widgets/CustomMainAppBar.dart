import 'package:chat_project/export.dart';


class CustomMainAppBar extends StatelessWidget {
  CustomMainAppBar(
      {this.leadingWidget,
      this.actionWidget,
      this.isNotPaddingTop = false,
      this.isChatScreen = false,
      this.widget,
      this.height,
      super.key});

  final Widget? leadingWidget;
  final List<Widget>? actionWidget;
  final Widget? widget;
  double? height;
  final bool isChatScreen;
  final bool isNotPaddingTop;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: AppColors.primary,
          image: const DecorationImage(
              fit: BoxFit.cover, image: AssetImage(ImageAssets.appbarShadow))),
      padding: EdgeInsets.only(
        top: 30.h,
        bottom: 10.h,
        right: 10.w,
        left: 10.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              leadingWidget ?? Container(),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [...actionWidget ?? []],
                ),
              ),
            ],
          ),
          widget ?? Container()
        ],
      ),
    );
  }
}
