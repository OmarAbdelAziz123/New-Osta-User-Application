import 'package:osta_user_app/utils/constants/exports.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
              TopRowInAllScreens(titleOfScreenWidget: Text('Privacy Policy', style: OStyles.h4Bold)),

              /// Make Space
              SizedBox(height: 33.5.h),
              
              Text('1. Types of Data We Collect', style: OStyles.h5Bold),
              /// Make Space
              SizedBox(height: 24.h),

              Text(OConstants.loremText1, style: OStyles.bodyMediumRegular),
              /// Make Space
              SizedBox(height: 24.h),

              Text('2. Use of Your Personal Data', style: OStyles.h5Bold),
              /// Make Space
              SizedBox(height: 24.h),

              Text(OConstants.loremText2, style: OStyles.bodyMediumRegular),
              /// Make Space
              SizedBox(height: 24.h),

              Text('3. Disclosure of Your Personal Data', style: OStyles.h5Bold),
              /// Make Space
              SizedBox(height: 24.h),

              Text(OConstants.loremText3, style: OStyles.bodyMediumRegular),
              /// Make Space
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
