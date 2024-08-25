import 'package:osta/common/widgets/date_input_formatter/date_input_formatter.dart';
import 'package:osta/features/auth/presentation/widgets/fill_your_profile/fill_your_profile_from_widget.dart';
import 'package:osta/utils/constants/exports.dart';

class FillYourProfileScreen extends StatelessWidget {
  const FillYourProfileScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
          child: Column(
            children: [
              /// Arrow Button
              TopRowInAllScreens(titleOfScreenWidget: Text(AppLocalizations.of(context)!.translate('fillYourAccount')!, style: OStyles.h4Bold)),

              /// Make Space
              SizedBox(height: 24.h),

              /// Profile Image
              SizedBox(
                width: double.infinity,
                // height: 622.h,
                child: Column(
                  children: [
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