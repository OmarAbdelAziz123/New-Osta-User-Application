import 'package:osta_user_app/utils/constants/exports.dart';

class OtpInCreateAndLoginScreen extends StatefulWidget {
  const OtpInCreateAndLoginScreen({super.key});

  @override
  State<OtpInCreateAndLoginScreen> createState() => _OtpInCreateAndLoginScreenState();
}

class _OtpInCreateAndLoginScreenState extends State<OtpInCreateAndLoginScreen> {
  TextEditingController pinputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
            child: Column(
              children: [
                /// Arrow Button
                TopRowInAllScreens(titleOfScreenWidget: Text('Create New PIN', style: OStyles.h4Bold)),

                /// Make Space
                SizedBox(height: 125.h),

                SizedBox(height: 50.h, width: double.infinity, child: Text('Add a PIN number to make your account more secure.', style: OStyles.bodyXLargeRegular, textAlign: TextAlign.center)),

                /// Make Space
                SizedBox(height: 80.h),

                /// OTP
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: SizedBox(
                    width: double.infinity,
                    child: Pinput(
                      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                      controller: pinputController,
                      length: 4,
                      obscureText: true,
                      obscuringCharacter: '⚫',
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      focusedPinTheme: PinTheme(
                        height: 61.h,
                        width: 83.w,
                        textStyle: OStyles.h4Bold,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          border: Border.all(width: 1.w, color: OColors.primaryColor500),
                          color: OColors.purpleTransparent.withOpacity(.08),
                        ),
                      ),
                      defaultPinTheme: PinTheme(
                        height: 61.h,
                        width: 83.w,
                        textStyle: OStyles.h4Bold,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.sp),
                          color: OColors.greyScale50,
                          border: Border.all(width: 1.w, color: OColors.greyScale200),
                        ),
                      ),
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                      onCompleted: (value) async {},
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          /// Continue Button
          MainButtonWidget(
            buttonText: 'Continue',
            // onTap: () => ODeviceUtils.showDialogFunction(context: context, imagePath: OImages.congratulationProfile),
            onTap: () => context.pushNamed(ORoutesName.navigationMenuRoute),
            margin: EdgeInsets.zero,
            buttonColor: OColors.primaryColor500,
            boxShadow: [AppBoxShadows.buttonShadowOne],
          ),

          /// Make Space
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

