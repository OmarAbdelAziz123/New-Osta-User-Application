import '../../../../../../utils/constants/exports.dart';

class ContainerCallsWidget extends StatelessWidget {
  const ContainerCallsWidget({Key? key, required this.profileImage, required this.profileName, required this.date, required this.profileDes, required this.onTap}) : super(key: key);
  final String profileImage,profileName, profileDes, date;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h),
        width: double.infinity,
        height: 60.h,
        child: Row(
          children: [
            /// Profile Image
            SizedBox(
              height: 60.h,
              width: 60.w,
              child: Image.asset(profileImage,fit: BoxFit.scaleDown),
            ),
            /// Make Space
            SizedBox(width: 20.w),
            /// Profile Info
            SizedBox(
              width: 260.w,
              height: 48.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profileName,style: OStyles.h6Bold),
                  Row(
                    children: [
                      Container(
                        height: 16.h,
                        width: 16.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            color: profileDes == "Incoming" ? OColors.info : profileDes == "Outgoing" ? OColors.greenColor : profileDes == "Missed" ? OColors.error : OColors.primaryColor500

                        ),
                        child: Center(
                          child: Icon( profileDes == "Incoming" ? Icons.arrow_downward_outlined : profileDes == "Outgoing" ? Icons.arrow_upward :  Icons.close ,size: 11.sp,color: OColors.whiteColor),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(profileDes,style: OStyles.bodyMediumMedium),
                      Text(date,style: OStyles.bodyMediumMedium),
                    ],
                  )
                ],
              ),
            ),
           const Expanded(child: SizedBox()),
            SvgPicture.asset(OImages.callIcon,fit: BoxFit.scaleDown,width: 28.w,height: 28.h,)

          ],
        ),
      ),
    );
  }
}
