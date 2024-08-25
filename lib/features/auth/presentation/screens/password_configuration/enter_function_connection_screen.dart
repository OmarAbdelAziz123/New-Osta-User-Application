// import 'dart:developer';
//
// import 'package:osta/utils/constants/exports.dart';
//
// class EnterFunctionConnectionScreen extends StatefulWidget {
//   const EnterFunctionConnectionScreen({super.key, required this.viaConnection});
//
//   final bool viaConnection;
//
//   @override
//   State<EnterFunctionConnectionScreen> createState() => _EnterFunctionConnectionScreenState();
// }
//
// class _EnterFunctionConnectionScreenState extends State<EnterFunctionConnectionScreen> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   final FocusNode emailFocusNode = FocusNode();
//   final FocusNode phoneFocusNode = FocusNode();
//   bool isEmailFieldFocused = false;
//   bool isPhoneFieldFocused = false;
//
//   @override
//   void initState() {
//     super.initState();
//     /// Add listener to focus node
//     emailFocusNode.addListener(() => setState(() => isEmailFieldFocused = emailFocusNode.hasFocus));
//     phoneFocusNode.addListener(() => setState(() => isPhoneFieldFocused = phoneFocusNode.hasFocus));
//   }
//
//   @override
//   void dispose() {
//     /// Clean up the focus node and controller when the widget is disposed.
//     emailFocusNode.dispose();
//     phoneFocusNode.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//             padding:
//             EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
//             child: Column(
//               children: [
//                 /// Arrow Button
//                 TopRowInAllScreens(titleOfScreenWidget: Text('Forgot Password', style: OStyles.h4Bold)),
//
//                 /// Make Space
//                 SizedBox(height: 33.33.h),
//
//                 Center(child: SvgPicture.asset(OImages.forgetPasswordImage)),
//
//                 /// Make Space
//                 SizedBox(height: 33.33.h),
//
//                 /// Phone Number
//                 widget.viaConnection ?
//                 TextFormFieldWidget(
//                   controller: phoneController,
//                   textInputType: TextInputType.phone,
//                   focusNode: phoneFocusNode,
//                   hintText: 'Phone Number',
//                   hintColor: isPhoneFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
//                   prefixIcon: SvgPicture.asset(OImages.phoneIcon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isPhoneFieldFocused ? OColors.primaryColor500 : phoneController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
//                   fillColor: isPhoneFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
//                   borderSide: isPhoneFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
//                   obscureText: false,
//                 ) :
//                 TextFormFieldWidget(
//                   controller: emailController,
//                   textInputType: TextInputType.emailAddress,
//                   focusNode: emailFocusNode,
//                   hintText: 'Email',
//                   hintColor: isEmailFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
//                   prefixIcon: SvgPicture.asset(OImages.emailIcon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isEmailFieldFocused ? OColors.primaryColor500 : emailController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
//                   fillColor: isEmailFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
//                   borderSide: isEmailFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
//                   obscureText: false,
//                 ),
//
//                 /// Make Space
//                 SizedBox(height: 64.h),
//
//                 /// Continue Button
//                 MainButtonWidget(
//                   buttonText: 'Continue',
//                   onTap: () => context.pushNamed(ORoutesName.otpInForgetPasswordRoute, arguments: {
//                     'viaConnection': widget.viaConnection,
//                     'controller': widget.viaConnection ? phoneController.text : emailController.text,
//                   }),
//                   // onTap: () => log(widget.viaConnection ? phoneController.text : emailController.text),
//                   margin: EdgeInsets.zero,
//                   buttonColor: widget.viaConnection ? phoneController.text.isEmpty ? OColors.disabledButton : OColors.primaryColor500 : emailController.text.isEmpty ?  OColors.disabledButton : OColors.primaryColor500,
//                   boxShadow: widget.viaConnection ? phoneController.text.isEmpty ? [] : [AppBoxShadows.buttonShadowOne] :  emailController.text.isEmpty ? [] : [AppBoxShadows.buttonShadowOne],
//                 ),
//               ],
//             ),
//         ),
//       ),
//     );
//   }
// }
