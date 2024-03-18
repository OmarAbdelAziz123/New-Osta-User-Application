import 'package:osta_user_app/utils/constants/exports.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
          child: Column(
            children: [
              /// Arrow Button
              TopRowInAllScreens(titleOfScreenWidget: Text('Edit Profile', style: OStyles.h4Bold)),

              /// Make Space
              SizedBox(height: 33.5.h),

              const EditProfileFormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}