import 'package:osta_user_app/common/widgets/checkbox/remember_me_widget.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class CreateAccountFormWidget extends StatefulWidget {
  const CreateAccountFormWidget({super.key});

  @override
  State<CreateAccountFormWidget> createState() => _CreateAccountFormWidgetState();
}

class _CreateAccountFormWidgetState extends State<CreateAccountFormWidget> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  bool isPhoneFieldFocused = false;
  bool isPasswordFieldFocused = false;
  bool isChecked = false;
  bool isShown = false;

  @override
  void initState() {
    super.initState();
    /// Add listener to focus node
    phoneFocusNode.addListener(() => setState(() => isPhoneFieldFocused = phoneFocusNode.hasFocus));
    passwordFocusNode.addListener(() => setState(() => isPasswordFieldFocused = passwordFocusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        ),

        /// Make Space
        // SizedBox(height: 20.h),

        // /// Password
        // TextFormFieldWidget(
        //   controller: passwordController,
        //   textInputType: TextInputType.visiblePassword,
        //   focusNode: passwordFocusNode,
        //   hintText: 'Password',
        //   hintColor: isPasswordFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
        //   prefixIcon: SvgPicture.asset(OImages.passwordIcon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isPasswordFieldFocused ? OColors.primaryColor500 : phoneController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
        //   suffixIcon: IconButton(
        //     onPressed: () => setState(() => isShown = !isShown),
        //     icon: SvgPicture.asset(!isShown ? OImages.hideEyeIcon : OImages.showEyeIcon , fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isPasswordFieldFocused ? OColors.primaryColor500 : phoneController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
        //   ),
        //   fillColor: isPasswordFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
        //   borderSide: isPasswordFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
        //   obscureText: !isShown,
        // ),

        /// Make Space
        SizedBox(height: 40.h),

        /// Sign up Button
        MainButtonWidget(
          buttonText: 'Sign up',
          onTap: () => context.pushNamed(ORoutesName.fillYourRoute),
          margin: EdgeInsets.zero,
          buttonColor: phoneController.text.isEmpty || passwordController.text.isEmpty ? OColors.disabledButton : OColors.primaryColor500,
          boxShadow: phoneController.text.isEmpty || passwordController.text.isEmpty ? [] : [AppBoxShadows.buttonShadowOne],
        ),

      ],
    );
  }
}