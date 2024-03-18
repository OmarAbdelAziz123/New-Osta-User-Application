import 'package:osta_user_app/utils/constants/exports.dart';

class SecondButtonWidget extends StatelessWidget {
  const SecondButtonWidget({super.key, required this.bgColor, required this.widget});

  final Color bgColor;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 184.w,
      height: 58.h,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Center(child: widget),
    );
  }
}
