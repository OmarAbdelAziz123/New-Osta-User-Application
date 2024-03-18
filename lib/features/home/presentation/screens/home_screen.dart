import 'package:osta_user_app/utils/constants/exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
        child: Column(
          children: [
            SizedBox(
              height: 52.h,
              width: double.infinity,
              child: Row(
                children: [
                  /// Profile Image
                  const CircleAvatar(backgroundImage: AssetImage(OImages.profileImage)),

                  /// Make Space
                  SizedBox(width: 16.w),

                  /// Text (Good Morning - User Name)
                  SizedBox(
                    width: 230.w,
                    height: 52.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Good Morning 👋', style: OStyles.bodyLargeRegular.copyWith(color: OColors.greyScale600)),
                        Text('Andrew Ainsley', style: OStyles.h5Bold),
                      ],
                    ),
                  ),

                  /// Notification Icon
                  InkWellWidget(onTap: () => context.pushNamed(ORoutesName.notificationsRoute), child: SvgPicture.asset(OImages.notificationIcon)),

                  /// Make Space
                  SizedBox(width: 16.w),

                  /// BookMark Icon
                  SvgPicture.asset(OImages.bookMarkIcon),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
