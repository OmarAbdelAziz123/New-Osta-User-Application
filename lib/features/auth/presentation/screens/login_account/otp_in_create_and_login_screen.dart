import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/common/widgets/texts_rich/text_rich2_widget.dart';
import 'package:osta_user_app/features/auth/managers/auth_cubit.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class OtpInCreateAndLoginScreen extends StatefulWidget {
  const OtpInCreateAndLoginScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<OtpInCreateAndLoginScreen> createState() => _OtpInCreateAndLoginScreenState();
}

class _OtpInCreateAndLoginScreenState extends State<OtpInCreateAndLoginScreen> {
  TextEditingController pinputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.whiteColor,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if(state is VerifyOTPErrorState) {
            ODeviceUtils.showSnackBar(context: context, message: AppLocalizations.of(context)!.translate('theOTPHaveAProblem')!, textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.error);
          } else if(state is VerifyOTPSuccessState) {
              if(state.message == 'login successfully') {
                ODeviceUtils.showDialogFunction(context: context, imagePath: OImages.congratulationProfile);
                Future.delayed(const Duration(seconds: 2), () {
                  if (context.mounted) context.pushNamedAndRemoveUntil(ORoutesName.navigationMenuRoute, arguments: 0, predicate: (route) => false);
                });
              } else {
                ODeviceUtils.showSnackBar(
                  context: context,
                  message: state.message,
                  textStyle: OStyles.bodyLargeRegular,
                  textColor: OColors.whiteColor,
                  bgColor: OColors.error,
                );
              }
          }
        },
        builder: (context, state) {
          var verifyOTPCubit = AuthCubit.get(context);

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w).copyWith(top: 75.h, bottom: 48.h),
                  child: Column(
                    children: [
                      /// Arrow Button
                      TopRowInAllScreens(titleOfScreenWidget: Text('', style: OStyles.h4Bold)),

                      /// Make Space
                      SizedBox(height: 125.h),

                      SizedBox(
                        height: 50.h,
                        width: double.infinity,
                        child: Text('${AppLocalizations.of(context)!.translate('codeHasBeenSentTo: ')!}${widget.phoneNumber}', style: OStyles.bodyXLargeRegular, textAlign: TextAlign.center),
                      ),

                      /// Make Space
                      SizedBox(height: 80.h),

                      /// OTP
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: SizedBox(
                          width: double.infinity,
                          child: Pinput(
                            // androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
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
                            onCompleted: (value) async => verifyOTPCubit.verifyOTPFunction(otp: pinputController.text, phoneNumber: widget.phoneNumber),
                          ),
                        ),
                      ),

                      /// Make Space
                      SizedBox(height: 50.h),

                      /// Counter Text
                      TextRich2Widget(
                        text1: '${AppLocalizations.of(context)!.translate('resendCodeIn')!} ',
                        style: OStyles.bodyXLargeMedium.copyWith(color: OColors.primaryColor500),
                      ),

                      /// Add Expanded to take up remaining space
                      Expanded(child: Container()),

                      /// Continue Button
                      MainButtonWidget(
                        centerWidgetInButton: state is VerifyOTPLoadingState
                            ? Padding(
                          padding: EdgeInsets.all(3.sp),
                          child: LoadingWidget(iconColor: OColors.whiteColor),
                        )
                            : Text(
                          AppLocalizations.of(context)!.translate('continue')!,
                          style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor),
                        ),
                        onTap: state is VerifyOTPLoadingState ? null : () => verifyOTPCubit.verifyOTPFunction(otp: pinputController.text, phoneNumber: widget.phoneNumber),
                        margin: EdgeInsets.zero,
                        buttonColor: OColors.primaryColor500,
                        boxShadow: [AppBoxShadows.buttonShadowOne],
                      ),

                      /// Make Space
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

