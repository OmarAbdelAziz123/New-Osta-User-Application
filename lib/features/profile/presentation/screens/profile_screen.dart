import 'package:osta_user_app/utils/constants/exports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkModeEnabled = false;
    bool isOnNotificationEnabled = false;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
        child: Column(
          children: [

            /// App Bar
            AppBarWidget(leading: SvgPicture.asset(OImages.profileLogo, fit: BoxFit.scaleDown), title: 'Profile', actions: SvgPicture.asset(OImages.moreIcon2), widthOfText: 280.w),

            /// Make Space
            SizedBox(height: 24.h),

            SizedBox(
              width: double.infinity,
              height: ODeviceUtils.getScreenHeight(context).h / 3.8,

              child: Column(
                children: [
                  Stack(
                    children: [

                      /// Image Profile
                      CircleAvatar(radius: 60.r, backgroundImage: const AssetImage(OImages.profileImage), backgroundColor: Colors.transparent,),

                      /// Edite Icon
                      Positioned(bottom: 0, right: 0, child: SvgPicture.asset(OImages.editIcon)),
                    ],
                  ),

                  /// Make Space
                  SizedBox(height: 12.h),

                  Container(margin: EdgeInsets.only(bottom: 2.h), width: double.infinity, height: 29.h, child: Text(OCacheHelper.getString(key: CacheKeys.fullName).toString(), style: OStyles.h4Bold, textAlign: TextAlign.center)),

                  SizedBox(width: double.infinity, height: 29.h, child: Text(OCacheHelper.getString(key: CacheKeys.email).toString(), style: OStyles.bodyMediumSemiBold, textAlign: TextAlign.center)),
                ],
              ),
            ),

            /// Make Space
            SizedBox(height: 24.h),

            /// Divider
            Container(width: double.infinity, height: 1.h, color: OColors.greyScale200),

            /// Make Space
            SizedBox(height: 24.h),

            /// ListTil
            SizedBox(
              width: double.infinity,
              child: Column(
                children: List.generate(
                  OConstants.listTilIconsInProfile.length,
                      (index) {
                    return ListTile(
                      onTap: index == 5 || index == 1 ? null : () =>
                          navigateBasedOnIndex(context, index),
                      contentPadding: EdgeInsets.zero,
                      leading: SvgPicture.asset(
                          OConstants.listTilIconsInProfile[index], width: 28.w,
                          height: 28.h,
                          fit: BoxFit.scaleDown),
                      title: Text(OConstants.listTilTextInProfile[index],
                          style: OStyles.bodyXLargeSemiBold),
                      trailing: index == 5 ?
                      SwitchWidget(valueData: isDarkModeEnabled) :
                      index == 1 ?
                      SwitchWidget(valueData: isOnNotificationEnabled) :
                      SizedBox(
                        width: 160.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            index == 4
                                ? Text('English (US)',
                                style: OStyles.bodyXLargeSemiBold)
                                : const SizedBox.shrink(),
                            index == 4 ? SizedBox(width: 20.w) : const SizedBox
                                .shrink(),
                            SvgPicture.asset(OImages.arrowRightIOS, width: 20.w,
                                height: 20.h),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateBasedOnIndex(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.pushNamed(ORoutesName.editProfileRoute);
        break;
      case 2:
        context.pushNamed(ORoutesName.paymentRoute);
        break;
      case 3:
        context.pushNamed(ORoutesName.changePasswordRoute);
        break;
      case 6:
        context.pushNamed(ORoutesName.privacyPolicyRoute);
        break;
      case 7:
        context.pushNamed(ORoutesName.helpCenterRoute);
        break;
      case 8:
        context.pushNamed(ORoutesName.inviteFriendsRoute);
      case 9:
        ODeviceUtils.showCustomBottomSheet(context: context, widget: const LogoutWidget());
        break;
      default:
        break;
    }
  }
}