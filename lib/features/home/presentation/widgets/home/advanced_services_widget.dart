import 'package:osta/utils/constants/exports.dart';

class AdvancedServicesWidget extends StatelessWidget {
  AdvancedServicesWidget({super.key, required this.image, required this.title, this.onTap, this.border});

  final String image, title;
  void Function()? onTap;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // width: 175.w,
        height: 90.h,
        decoration: BoxDecoration(
          border: border,
          color: OColors.whiteColor,
          // color: Colors.red,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [AppBoxShadows.cardShadowTwo],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 6.w, top: 12.h, bottom: 12.h),
              child: SvgPicture.asset(image, fit: BoxFit.scaleDown),
            ),
            SizedBox(width: 6.w),
            Expanded(child: Text(title, style: OStyles.h6Bold, overflow: TextOverflow.clip)),
            SizedBox(width: 5.w),
          ],
        ),
      ),
    );
  }
}
