import 'package:osta_user_app/utils/constants/exports.dart';

class SecondButtonWidget extends StatelessWidget {
  const SecondButtonWidget({super.key, required this.bgColor, required this.widget, required this.onTap});

  final Color bgColor;
  final Widget widget;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWellWidget(
      onTap: onTap,
      child: Container(
        width: 184.w,
        height: 58.h,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Center(child: widget),
      ),
    );
  }
}
