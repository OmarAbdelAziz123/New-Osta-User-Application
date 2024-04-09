import 'package:osta_user_app/utils/constants/exports.dart';

class AdvancedServicesWidget extends StatelessWidget {
  AdvancedServicesWidget({super.key, required this.image, required this.title, this.onTap});

  final String image, title;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 190.w,
        height: 90.h,
        decoration: BoxDecoration(
            color: OColors.whiteColor,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [AppBoxShadows.cardShadowTwo]
        ),
        child: Row(
          children: [
            SvgPicture.asset(image),
            SizedBox(width: 10.w),
            Expanded(child: Text(title, style: OStyles.h6Bold, overflow: TextOverflow.clip)),
          ],
        ),
      ),
    );
  }
}
