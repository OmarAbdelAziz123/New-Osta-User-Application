import 'package:osta/utils/constants/exports.dart';

class NotificationContainerWidget extends StatelessWidget {
  const NotificationContainerWidget({super.key, required this.image, required this.title, required this.description});

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: OColors.whiteColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [AppBoxShadows.cardShadowTwo]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(image, height: 80.h, width: 83.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: OStyles.h6Bold),
              Text(description, style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale700)),
            ],
          ),
        ],
      ),
    );
  }
}