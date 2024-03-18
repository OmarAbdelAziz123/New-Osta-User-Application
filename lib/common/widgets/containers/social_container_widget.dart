import 'package:osta_user_app/utils/constants/exports.dart';

class SocialContainerWidget extends StatelessWidget {
  const SocialContainerWidget({super.key, required this.companyIcon});

  final String companyIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 88.w,
            height: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: OColors.greyScale200, width: 1.w),
            ),
            child: Center(
              child: SvgPicture.asset(companyIcon, fit: BoxFit.scaleDown),
            ),
          ),
        ],
      ),
    );
  }
}
