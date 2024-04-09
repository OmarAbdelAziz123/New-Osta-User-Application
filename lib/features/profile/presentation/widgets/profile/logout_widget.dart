import 'package:osta_user_app/utils/constants/exports.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 266.h,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40.r), topRight: Radius.circular(40.r))),
        child: Column(
          children: [
            /// Make Space
            SizedBox(height: 35.h),

            SizedBox(width: double.infinity, height: 29.h, child: Text('Logout', style: OStyles.h4Bold.copyWith(color: OColors.alertsAndStatusError), textAlign: TextAlign.center)),

            /// Make Space
            SizedBox(height: 24.h),

            Container(width: double.infinity, height: 1.w, color: OColors.greyScale200,),

            /// Make Space
            SizedBox(height: 24.h),

            SizedBox(width: double.infinity, height: 24.h, child: Text('Are you sure you want to log out?', style: OStyles.h5Bold.copyWith(color: OColors.greyScale800), textAlign: TextAlign.center)),

            /// Make Space
            SizedBox(height: 24.h),

            /// Two Buttons (Cancel - Yes)
            SizedBox(
              width: double.infinity,
              height: 58.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SecondButtonWidget(bgColor: OColors.primaryColor100, widget: Text('Cancel', style: OStyles.bodyLargeBold.copyWith(color: OColors.primaryColor500)), onTap: () => context.pop()),
                  SecondButtonWidget(bgColor: OColors.primaryColor500, widget: Text('Yes, Logout', style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)), onTap: () {
                    OCacheHelper.removeFromShared(key: CacheKeys.token);
                    context.pushNamedAndRemoveUntil(ORoutesName.onBoardingRoute, predicate: (Route<dynamic> route) => false);
                  }),
                ],
              ),
            ),
          ],
        )
    );
  }
}
