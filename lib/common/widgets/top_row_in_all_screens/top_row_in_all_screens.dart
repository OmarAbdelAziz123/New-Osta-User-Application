import 'package:osta_user_app/utils/constants/exports.dart';

class TopRowInAllScreens extends StatelessWidget {
  const TopRowInAllScreens({super.key, this.titleOfScreenWidget});

  final Widget? titleOfScreenWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 38.h,
      child: Row(
        children: [
          InkWellWidget(onTap: () => context.pop(), child: const Icon((Icons.arrow_back))),
          SizedBox(width: 16.w),
          titleOfScreenWidget ?? Container(),
        ],
      ),
    );
  }
}

