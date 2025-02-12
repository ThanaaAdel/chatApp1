import 'package:chat_project/export.dart';

// the width is flexible
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    required this.title,
    this.color,
    this.width,
    this.reduis,
    this.isBordered = false,
  });
  final void Function()? onTap;
  final String title;
  final Color? color;

  final double? width;
  final double? reduis;
  final bool isBordered;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getWidthSize(context) / 32),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(getWidthSize(context) / 12),
        child: Container(
          width: width ?? double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.all(getWidthSize(context) / 32),
          decoration: BoxDecoration(
            color: isBordered ? AppColors.white : color ?? AppColors.primary,
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(reduis??getWidthSize(context) / 12),
          ),
          child: Text(title,
             ),
        ),
      ),
    );
  }
}

// without width
class CustomSmallButton extends StatelessWidget {
  const CustomSmallButton({
    super.key,
    this.onTap,
    required this.title,
    this.color,
    this.width,
    this.fontSize,
    this.isBordered = false,
  });
  final void Function()? onTap;
  final String title;
  final Color? color;
  final bool isBordered;
  final double? width;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        // width: width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: getWidthSize(context) * 0.05,
            vertical: getHeightSize(context) * 0.008),
        decoration: BoxDecoration(
          color: isBordered ? AppColors.white : color ?? AppColors.primary,
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(getWidthSize(context) / 12),
        ),
        child: Text(title,
            maxLines: 1,
           ),
      ),
    );
  }
}
