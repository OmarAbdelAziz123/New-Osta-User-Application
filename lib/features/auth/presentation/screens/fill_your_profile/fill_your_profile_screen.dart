import 'package:osta_user_app/common/widgets/date_input_formatter/date_input_formatter.dart';
import 'package:osta_user_app/features/auth/presentation/widgets/fill_your_profile/fill_your_profile_from_widget.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class FillYourProfileScreen extends StatelessWidget {
  const FillYourProfileScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
          child: Column(
            children: [
              /// Arrow Button
              TopRowInAllScreens(titleOfScreenWidget: Text('Fill Your Profile', style: OStyles.h4Bold)),

              /// Make Space
              SizedBox(height: 24.h),

              /// Profile Image
              SizedBox(
                width: double.infinity,
                // height: 622.h,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        /// Image Profile
                        CircleAvatar(
                          radius: 60.r,
                          backgroundImage: const AssetImage(OImages.avatarIcon),
                          backgroundColor: Colors.transparent,
                          // child: SvgPicture.asset(OImages.avatarIcon),
                        ),
                        /// Edite Icon
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: SvgPicture.asset(OImages.editIcon),
                        ),
                      ],
                    ),

                    /// Make Space
                    SizedBox(height: 24.h),

                    FillYourProfileFormWidget(phoneNumber: phoneNumber),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}