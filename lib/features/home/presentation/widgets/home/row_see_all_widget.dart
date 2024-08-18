import 'package:osta_user_app/utils/constants/exports.dart';

class RowSeeAllWidget extends StatelessWidget {
  const RowSeeAllWidget(
      {super.key,
      required this.mainText,
      required this.seeAllText,
      required this.onTap,
      this.isOpen,
      this.iconWidget});

  final String mainText, seeAllText;
  final void Function() onTap;
  final bool? isOpen;
  final Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 24.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(mainText, style: OStyles.bodyLargeBold.copyWith(height: 0.9)),
          if (isOpen != null && isOpen! == false)
            InkWellWidget(
              onTap: onTap,
              child: Text(
                seeAllText,
                style: OStyles.bodySmallBold.copyWith(
                  color: OColors.primaryColor500,
                  height: 2.3.h,
                ),
              ),
            )
          else if (iconWidget != null)
            iconWidget!,
        ],
      ),
    );
  }
}
