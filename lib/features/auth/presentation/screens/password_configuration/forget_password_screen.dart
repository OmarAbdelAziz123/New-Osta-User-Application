// import 'package:osta_user_app/features/auth/presentation/widgets/password_configuration/check_to_send_otp_container_widget.dart';
// import 'package:osta_user_app/utils/constants/exports.dart';
//
// class ForgetPasswordScreen extends StatefulWidget {
//   const ForgetPasswordScreen({super.key});
//
//   @override
//   State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
// }
//
// class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
//   bool viaSms = true;
//   bool viaEmail = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final List<String> connectionTypeTexts = [
//       'via SMS:',
//       'via Email:',
//     ];
//     final List<String> connectionTypeValue = [
//       '+20 115 3083387',
//       '3omar123@gmail.com',
//     ];
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
//           child: Column(
//             children: [
//               /// Arrow Button
//               TopRowInAllScreens(titleOfScreenWidget: Text('Forgot Password', style: OStyles.h4Bold)),
//
//               /// Make Space
//               SizedBox(height: 33.33.h),
//
//               Center(child: SvgPicture.asset(OImages.forgetPasswordImage)),
//
//               /// Make Space
//               SizedBox(height: 33.33.h),
//
//               /// Check Container (Phone - Email)
//               SizedBox(
//                 width: double.infinity,
//                 height: 355.h,
//                 child: Column(
//                   children: [
//                     Text('Select which contact details should we use to reset your password', style: OStyles.bodyXLargeMedium),
//                     SizedBox(height: 24.h),
//                     Column(
//                       children: [
//                         for (int index = 0; index < 2; index++) ...[
//                           CheckToSendOTPContainerWidget(
//                             logo: index == 0 ? OImages.smsLogo : OImages.emailLogo,
//                             connectionType: connectionTypeTexts[index],
//                             detailsText: connectionTypeValue[index],
//                             borderColor: (index == 0 && viaSms) || (index == 1 && viaEmail) ? OColors.gradientPurple1 : OColors.greyScale200,
//                             onTap: () {
//                               setState(() {
//                                 viaSms = index == 0;
//                                 viaEmail = index == 1;
//                               });
//                             },
//                           ),
//                           if (index < 1) SizedBox(height: 24.h), /// Add space between the widgets, but not after the last one
//                         ],
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               /// Make Space
//               SizedBox(height: 33.33.h),
//
//               /// Continue Button
//               MainButtonWidget(
//                 buttonText: 'Continue',
//                 onTap: () => context.pushNamed(ORoutesName.enterFunctionConnectionRoute, arguments: viaSms),
//                 margin: EdgeInsets.zero,
//                 buttonColor: OColors.primaryColor500,
//                 boxShadow: [AppBoxShadows.buttonShadowOne],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }