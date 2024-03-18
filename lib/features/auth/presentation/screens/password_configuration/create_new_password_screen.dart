import 'package:osta_user_app/features/auth/presentation/widgets/password_configuration/create_new_password_form_widget.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  const CreateNewPasswordScreen({super.key});

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
              TopRowInAllScreens(titleOfScreenWidget: Text('Create New Password', style: OStyles.h4Bold)),

              /// Make Space
              SizedBox(height: 71.h),
              
              Padding(padding: EdgeInsets.symmetric(horizontal: 49.5.w), child: SvgPicture.asset(OImages.createNewPasswordLogo, fit: BoxFit.scaleDown, width: 329.w, height: 250.h)),

              /// Make Space
              SizedBox(height: 71.h),

              Text('Create Your New Password', style: OStyles.bodyXLargeMedium),

              /// Make Space
              SizedBox(height: 24.h),

              const CreateNewPasswordFormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}