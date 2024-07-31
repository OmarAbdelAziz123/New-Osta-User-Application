import '../../../../../utils/constants/exports.dart';

class ContactUsContainerWidget extends StatelessWidget {
  const ContactUsContainerWidget({Key? key, required this.contactUsText, required this.contactUsIcon, required this.onTab}) : super(key: key);
 final String contactUsText, contactUsIcon;
 final  VoidCallback onTab;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: GestureDetector(
        onTap: onTab,
        child: Container(
          padding: EdgeInsets.all(24.sp),
          decoration: BoxDecoration(
              color: OColors.whiteColor,
              borderRadius: BorderRadius.circular(20.h),
              boxShadow: [AppBoxShadows.cardShadowTwo]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(contactUsIcon),
              SizedBox(width: 16.w),
              Text(contactUsText,style: OStyles.h6Bold),
            ],
          ),
        ),
      ),
    );
  }
}
