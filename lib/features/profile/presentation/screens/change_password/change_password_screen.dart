import 'package:osta/utils/constants/exports.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Arrow Button
              TopRowInAllScreens(titleOfScreenWidget: Text('Change Password', style: OStyles.h4Bold)),

              /// Make Space
              SizedBox(height: 71.h),

              Padding(padding: EdgeInsets.symmetric(horizontal: 49.5.w), child: SvgPicture.asset(OImages.createNewPasswordLogo, fit: BoxFit.scaleDown, width: 329.w, height: 250.h)),

              /// Make Space
              SizedBox(height: 71.h),

              Text('Update Your Password', style: OStyles.bodyXLargeMedium),

              /// Make Space
              SizedBox(height: 24.h),

              const UpdateNewPasswordWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

