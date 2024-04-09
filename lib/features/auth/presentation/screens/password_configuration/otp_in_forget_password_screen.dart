// import 'package:osta_user_app/common/widgets/texts_rich/text_rich2_widget.dart';
// import 'package:osta_user_app/utils/constants/exports.dart';
//
// class OtpInForgetPasswordScreen extends StatefulWidget {
//   const OtpInForgetPasswordScreen({super.key, required this.map});
//   final Map<String, dynamic> map;
//
//   @override
//   State<OtpInForgetPasswordScreen> createState() => _OtpInForgetPasswordScreenState();
// }
//
// class _OtpInForgetPasswordScreenState extends State<OtpInForgetPasswordScreen> {
//   TextEditingController pinputController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
//             child: Column(
//               children: [
//                 /// Arrow Button
//                 TopRowInAllScreens(titleOfScreenWidget: Text('Create New PIN', style: OStyles.h4Bold)),
//
//                 /// Make Space
//                 SizedBox(height: 97.h),
//
//                 SizedBox(
//                   width: double.infinity,
//                   height: 231.h,
//                   child: Column(
//                     children: [
//                       Text('Code has been send to: ${widget.map['controller']}',style: OStyles.bodyXLargeMedium),
//                       /// Make Space
//                       SizedBox(height: 60.h),
//                       /// OTP
//                       Directionality(
//                         textDirection: TextDirection.ltr,
//                         child: SizedBox(
//                           width: double.infinity,
//                           child: Pinput(
//                             androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
//                             controller: pinputController,
//                             length: 4,
//                             obscureText: true,
//                             obscuringCharacter: '⚫',
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             focusedPinTheme: PinTheme(
//                               height: 61.h,
//                               width: 83.w,
//                               textStyle: OStyles.h4Bold,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10.sp),
//                                 border: Border.all(width: 1.w, color: OColors.primaryColor500),
//                                 color: OColors.purpleTransparent.withOpacity(.08),
//                               ),
//                             ),
//                             defaultPinTheme: PinTheme(
//                               height: 61.h,
//                               width: 83.w,
//                               textStyle: OStyles.h4Bold,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12.sp),
//                                 color: OColors.greyScale50,
//                                 border: Border.all(width: 1.w, color: OColors.greyScale200),
//                               ),
//                             ),
//                             pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
//                             onCompleted: (value) async {},
//                           ),
//                         ),
//                       ),
//                       /// Make Space
//                       SizedBox(height: 50.h),
//                       /// Counter Text
//                       TextRich2Widget(text1: 'Resend code in ', style: OStyles.bodyXLargeMedium.copyWith(color: OColors.primaryColor500)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           const Spacer(),
//
//           /// Continue Button
//           MainButtonWidget(
//             buttonText: 'Verify',
//             onTap: () => context.pushNamed(ORoutesName.createNewPasswordRoute),
//             margin: EdgeInsets.zero,
//             buttonColor: OColors.primaryColor500,
//             boxShadow: [AppBoxShadows.buttonShadowOne],
//           ),
//
//           /// Make Space
//           SizedBox(height: 48.h),
//         ],
//       ),
//     );
//   }
// }
