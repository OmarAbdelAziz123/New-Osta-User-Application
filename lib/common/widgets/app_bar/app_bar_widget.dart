import 'package:osta/utils/constants/exports.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.leading, required this.actions, required this.title, required this.widthOfText});

  final Widget leading, actions;
  final String title;
  final double widthOfText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: Row(
        children: [
          leading,

          /// Make Space
          SizedBox(width: 16.w),

          SizedBox(width: widthOfText, child: Text(title, style: OStyles.h4Bold.copyWith(color: Theme.of(context).colorScheme.primary), overflow: TextOverflow.ellipsis)),

          /// Make Space
          SizedBox(width: 12.w),

          actions,
        ],
      ),
    );
  }
}
