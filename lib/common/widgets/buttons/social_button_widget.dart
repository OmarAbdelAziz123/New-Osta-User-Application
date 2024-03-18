import 'package:osta_user_app/utils/constants/exports.dart';

class SocialButtonWidget extends StatelessWidget {
  const SocialButtonWidget({super.key, required this.companyIcon, required this.textButton});

  final String companyIcon;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.h,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(width: 1.w, color: OColors.greyScale200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Icon
          SvgPicture.asset(companyIcon),
          /// Make Space
          SizedBox(width: 12.h),
          /// Text Button
          Text(textButton, style: OStyles.bodyLargeSemiBold),
        ],
      ),
    );
  }
}
