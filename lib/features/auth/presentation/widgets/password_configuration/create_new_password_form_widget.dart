import 'package:osta_user_app/utils/constants/exports.dart';

class CreateNewPasswordFormWidget extends StatefulWidget {
  const CreateNewPasswordFormWidget({super.key});

  @override
  State<CreateNewPasswordFormWidget> createState() => _CreateNewPasswordFormWidgetState();
}

class _CreateNewPasswordFormWidgetState extends State<CreateNewPasswordFormWidget> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode confirmNewPasswordFocusNode = FocusNode();
  bool isNewPasswordFieldFocused = false;
  bool isConfirmNewPasswordFieldFocused = false;
  bool isShownNewPassword = false;
  bool isShownConfirmNewPassword = false;

  @override
  void initState() {
    super.initState();
    /// Add listener to focus node
    newPasswordFocusNode.addListener(() => setState(() => isNewPasswordFieldFocused = newPasswordFocusNode.hasFocus));
    confirmNewPasswordFocusNode.addListener(() => setState(() => isConfirmNewPasswordFieldFocused = confirmNewPasswordFocusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    newPasswordFocusNode.dispose();
    confirmNewPasswordFocusNode.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// New Password
        TextFormFieldWidget(
          controller: newPasswordController,
          textInputType: TextInputType.visiblePassword,
          focusNode: newPasswordFocusNode,
          hintText: 'New Password',
          hintColor: isNewPasswordFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
          prefixIcon: SvgPicture.asset(OImages.passwordIcon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isNewPasswordFieldFocused ? OColors.primaryColor500 : confirmNewPasswordController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
          suffixIcon: IconButton(
            onPressed: () => setState(() => isShownNewPassword = !isShownNewPassword),
            icon: SvgPicture.asset(!isShownNewPassword ? OImages.hideEyeIcon : OImages.showEyeIcon , fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isNewPasswordFieldFocused ? OColors.primaryColor500 : confirmNewPasswordController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
          ),
          fillColor: isNewPasswordFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
          borderSide: isNewPasswordFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
          obscureText: !isShownNewPassword,
        ),

        /// Make Space
        SizedBox(height: 24.h),

        /// Confirm New Password
        TextFormFieldWidget(
          controller: confirmNewPasswordController,
          textInputType: TextInputType.visiblePassword,
          focusNode: confirmNewPasswordFocusNode,
          hintText: 'Confirm New Password',
          hintColor: isConfirmNewPasswordFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
          prefixIcon: SvgPicture.asset(OImages.passwordIcon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isConfirmNewPasswordFieldFocused ? OColors.primaryColor500 : confirmNewPasswordController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
          suffixIcon: IconButton(
            onPressed: () => setState(() => isShownConfirmNewPassword = !isShownConfirmNewPassword),
            icon: SvgPicture.asset(!isShownConfirmNewPassword ? OImages.hideEyeIcon : OImages.showEyeIcon , fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isConfirmNewPasswordFieldFocused ? OColors.primaryColor500 : confirmNewPasswordController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
          ),
          fillColor: isConfirmNewPasswordFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
          borderSide: isConfirmNewPasswordFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
          obscureText: !isShownConfirmNewPassword,
        ),

        /// Make Space
        SizedBox(height: 71.h),

        /// Continue Button
        MainButtonWidget(
          buttonText: 'Continue',
          onTap: () => ODeviceUtils.showDialogFunction(context: context, imagePath: OImages.congratulationUpdatePassword),
          margin: EdgeInsets.zero,
          buttonColor: newPasswordController.text.isEmpty || confirmNewPasswordController.text.isEmpty ? OColors.disabledButton : OColors.primaryColor500,
          boxShadow: newPasswordController.text.isEmpty || confirmNewPasswordController.text.isEmpty ? [] : [AppBoxShadows.buttonShadowOne],
        ),
      ],
    );
  }
}
