import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/formatters/formatter.dart';

class UpdateNewPasswordWidget extends StatefulWidget {
  const UpdateNewPasswordWidget({super.key});

  @override
  State<UpdateNewPasswordWidget> createState() => _UpdateNewPasswordWidgetState();
}

class _UpdateNewPasswordWidgetState extends State<UpdateNewPasswordWidget> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  final FocusNode oldPasswordFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode confirmNewPasswordFocusNode = FocusNode();
  bool isOldPasswordFieldFocused = false;
  bool isNewPasswordFieldFocused = false;
  bool isConfirmNewPasswordFieldFocused = false;
  bool isShownOldPassword = false;
  bool isShownNewPassword = false;
  bool isShownConfirmNewPassword = false;

  @override
  void initState() {
    super.initState();
    /// Add listener to focus node
    oldPasswordFocusNode.addListener(() => setState(() => isOldPasswordFieldFocused = oldPasswordFocusNode.hasFocus));
    newPasswordFocusNode.addListener(() => setState(() => isNewPasswordFieldFocused = newPasswordFocusNode.hasFocus));
    confirmNewPasswordFocusNode.addListener(() => setState(() => isConfirmNewPasswordFieldFocused = confirmNewPasswordFocusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    oldPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    confirmNewPasswordFocusNode.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Old Password
        TextFormFieldWidget(
          controller: oldPasswordController,
          textInputType: TextInputType.visiblePassword,
          focusNode: oldPasswordFocusNode,
          hintText: 'Old Password',
          hintColor: isOldPasswordFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
          prefixIcon: SvgPicture.asset(OImages.passwordIcon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isOldPasswordFieldFocused ? OColors.primaryColor500 : confirmNewPasswordController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
          suffixIcon: IconButton(
            onPressed: () => setState(() => isShownOldPassword = !isShownOldPassword),
            icon: SvgPicture.asset(!isShownOldPassword ? OImages.hideEyeIcon : OImages.showEyeIcon , fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isOldPasswordFieldFocused ? OColors.primaryColor500 : confirmNewPasswordController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
          ),
          fillColor: isOldPasswordFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
          borderSide: isOldPasswordFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
          obscureText: !isShownOldPassword,
        ),

        /// Make Space
        SizedBox(height: 24.h),

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
        SizedBox(height: 24.h),

        /// Continue Button
        MainButtonWidget(
          centerWidgetInButton: Text('Update', style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)),
          onTap: () => ODeviceUtils.showDialogFunction(context: context, imagePath: OImages.congratulationUpdatePassword),
          margin: EdgeInsets.zero,
          buttonColor: newPasswordController.text.isEmpty || confirmNewPasswordController.text.isEmpty ? OColors.disabledButton : OColors.primaryColor500,
          boxShadow: newPasswordController.text.isEmpty || confirmNewPasswordController.text.isEmpty ? [] : [AppBoxShadows.buttonShadowOne],
        ),
      ],
    );
  }
}
