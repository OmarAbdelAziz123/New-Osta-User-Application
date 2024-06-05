import '../../../../../../utils/constants/exports.dart';


class ContainerChatsWidget extends StatelessWidget {
  const ContainerChatsWidget({Key? key, required this.profileImage, required this.profileName,required this.profileMessage, required this.onTap, required this.numOfMessage, required this.date}) : super(key: key);
  final String profileImage,profileName, profileMessage, numOfMessage, date;
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
              width: 250.w,
              height: 48.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profileName,style: OStyles.h6Bold),
                  Text(profileMessage,style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale500)),

                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            Column(
              children: [
                Container(
                  height: 25.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    gradient: AppGradients.purpleGradient
                  ),
                  child: Center(
                    child: Text(numOfMessage,style: OStyles.bodyXSmallRegular.copyWith(color: OColors.whiteColor)),
                  ),
                ),
                SizedBox(height: 9.5.h),
                Text(date),
              ],
            )

          ],
        ),
      ),
    );
  }
}
