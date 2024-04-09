import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/common/widgets/snack_bar/floating_snack_bar_widget.dart';
import 'package:osta_user_app/features/auth/managers/auth_cubit.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/formatters/formatter.dart';

class LoginAccountFormWidget extends StatefulWidget {
  const LoginAccountFormWidget({super.key});

  @override
  State<LoginAccountFormWidget> createState() => _LoginAccountFormWidgetState();
}

class _LoginAccountFormWidgetState extends State<LoginAccountFormWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  bool isEmailFieldFocused = false;
  bool isPhoneFieldFocused = false;
  bool isChecked = false;
  bool isShown = false;

  @override
  void initState() {
    super.initState();
    /// Add listener to focus node
    emailFocusNode.addListener(() => setState(() => isEmailFieldFocused = emailFocusNode.hasFocus));
    phoneFocusNode.addListener(() => setState(() => isPhoneFieldFocused = phoneFocusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(AuthCubit.get(context).checkPhoneModel.message == 'complete register process') {
          log('complete register process');
          context.pushReplacementNamed(ORoutesName.fillYourRoute, arguments: phoneController.text);
        } else if(AuthCubit.get(context).checkPhoneModel.message == 'OTP send') {
          log('OTP send');
          context.pushReplacementNamed(ORoutesName.otpRoute, arguments: phoneController.text);
        } else if(AuthCubit.get(context).checkPhoneModel.message == 'The phone field is required.') {
          ODeviceUtils.showSnackBar(context: context, message: 'The phone field is required', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.error);
        } else if(state is LoginErrorState) {
          ODeviceUtils.showSnackBar(context: context, message: 'Authentication have an error', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.error);
        }
      },
      builder: (context, state) {
        var loginCubit = AuthCubit.get(context);

        return SizedBox(
          width: double.infinity,
          height: 335.h,
          child: Column(
            children: [
              /// Phone Number
              TextFormFieldWidget(
                controller: phoneController,
                textInputType: TextInputType.phone,
                focusNode: phoneFocusNode,
                hintText: 'Phone Number',
                hintColor: isPhoneFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
                prefixIcon: SvgPicture.asset(OImages.phoneIcon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isPhoneFieldFocused ? OColors.primaryColor500 : phoneController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
                fillColor: isPhoneFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
                borderSide: isPhoneFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                obscureText: false,
                validator: (value) => OFormatter.formatPhoneNumber(value, '+2'),
              ),

              /// Make Space
              // SizedBox(height: 20.h),

              // /// Email
              // TextFormFieldWidget(
              //   controller: emailController,
              //   textInputType: TextInputType.emailAddress,
              //   focusNode: emailFocusNode,
              //   hintText: 'Email (Optional)',
              //   hintColor: isEmailFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
              //   prefixIcon: SvgPicture.asset(OImages.emailIcon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isEmailFieldFocused ? OColors.primaryColor500 : emailController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
              //   fillColor: isEmailFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
              //   borderSide: isEmailFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
              //   obscureText: false,
              // ),

              /// Make Space
              // SizedBox(height: 20.h),
              //
              // /// Password
              // TextFormFieldWidget(
              //   controller: phoneController,
              //   textInputType: TextInputType.visiblePassword,
              //   focusNode: phoneFocusNode,
              //   hintText: 'Password',
              //   hintColor: isPhoneFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
              //   prefixIcon: SvgPicture.asset(OImages.passwordIcon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isPhoneFieldFocused ? OColors.primaryColor500 : emailController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
              //   suffixIcon: IconButton(
              //     onPressed: () => setState(() => isShown = !isShown),
              //     icon: SvgPicture.asset(!isShown ? OImages.hideEyeIcon : OImages.showEyeIcon , fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isPhoneFieldFocused ? OColors.primaryColor500 : emailController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
              //   ),
              //   fillColor: isPhoneFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
              //   borderSide: isPhoneFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
              //   obscureText: !isShown,
              // ),

              /// Make Space
              SizedBox(height: 48.h),

              /// Sign in Button
              MainButtonWidget(
                centerWidgetInButton: state is LoginLoadingState ? Padding(padding: EdgeInsets.all(3.sp), child: LoadingWidget(iconColor: OColors.whiteColor)) : Text('Continue', style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)),
                onTap: () => loginCubit.loginFunction(phoneNumber: phoneController.text),
                margin: EdgeInsets.zero,
                // onTap: () => log(phoneController.text),
                buttonColor: emailController.text.isEmpty || phoneController.text.isEmpty ? OColors.disabledButton : OColors.primaryColor500,
                boxShadow: emailController.text.isEmpty || phoneController.text.isEmpty ? [] : [AppBoxShadows.buttonShadowOne],
              ),

              /// Make Space
              SizedBox(height: 24.h),

              // /// Forget Password
              // GestureDetector(
              //   onTap: () => context.pushNamed(ORoutesName.forgetPasswordRoute),
              //   child: Text('Forgot the password?', style: OStyles.bodyLargeSemiBold.copyWith(color: OColors.primaryColor500), textAlign: TextAlign.center),
              // ),
            ],
          ),
        );
      },
    );
  }
}