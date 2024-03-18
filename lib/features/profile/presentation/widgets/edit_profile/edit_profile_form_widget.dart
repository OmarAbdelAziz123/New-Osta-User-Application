import 'package:osta_user_app/common/widgets/drop_down/drop_down_widget.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class EditProfileFormWidget extends StatefulWidget {
  const EditProfileFormWidget({super.key});

  @override
  State<EditProfileFormWidget> createState() => _EditProfileFormWidgetState();
}

class _EditProfileFormWidgetState extends State<EditProfileFormWidget> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode dateOfBirthFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();

  bool isFullNameFieldFocused = false;
  bool isDateOfBirthFieldFocused = false;
  bool isEmailFieldFocused = false;
  bool isPhoneFieldFocused = false;
  bool isAddressFieldFocused = false;



  @override
  void initState() {
    super.initState();
    /// Add listener to focus node
    fullNameFocusNode.addListener(() => setState(() => isFullNameFieldFocused = fullNameFocusNode.hasFocus));
    dateOfBirthFocusNode.addListener(() => setState(() => isDateOfBirthFieldFocused = dateOfBirthFocusNode.hasFocus));
    emailFocusNode.addListener(() => setState(() => isEmailFieldFocused = emailFocusNode.hasFocus));
    phoneFocusNode.addListener(() => setState(() => isPhoneFieldFocused = phoneFocusNode.hasFocus));
    addressFocusNode.addListener(() => setState(() => isAddressFieldFocused = addressFocusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    dateOfBirthFocusNode.dispose();
    addressFocusNode.dispose();
    fullNameController.dispose();
    dateOfBirthController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Full Name
        TextFormFieldWidget(
          controller: fullNameController,
          textInputType: TextInputType.name,
          focusNode: fullNameFocusNode,
          hintText: 'Omar AbdelAziz',
          hintColor: isFullNameFieldFocused ? OColors.primaryColor500 : OColors.greyScale900,
          fillColor: isFullNameFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
          borderSide: isFullNameFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
          obscureText: false,
          isEdit: true,
        ),

        /// Make Space
        SizedBox(height: 24.h),

        /// Date Of Birth
        TextFormFieldWidget(
          controller: dateOfBirthController,
          textInputType: TextInputType.datetime,
          focusNode: dateOfBirthFocusNode,
          hintText: '20/5/1990',
          hintColor: isDateOfBirthFieldFocused ? OColors.primaryColor500 : OColors.greyScale900,
          suffixIcon: SvgPicture.asset(OImages.calendarIconNotSelected, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(OColors.greyScale900, BlendMode.srcIn)),
          fillColor: isDateOfBirthFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
          borderSide: isDateOfBirthFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
          obscureText: false,
          inputFormatters: [DateInputFormatter()],
          isEdit: true,
        ),

        /// Make Space
        SizedBox(height: 24.h),

        /// Email
        TextFormFieldWidget(
          controller: emailController,
          textInputType: TextInputType.emailAddress,
          focusNode: emailFocusNode,
          hintText: '3omar@gmail.com',
          hintColor: isEmailFieldFocused ? OColors.primaryColor500 : OColors.greyScale900,
          prefixIcon: SvgPicture.asset(OImages.email2Icon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(OColors.greyScale900, BlendMode.srcIn)),
          fillColor: isEmailFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
          borderSide: isEmailFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
          obscureText: false,
          isEdit: true,
        ),

        /// Make Space
        SizedBox(height: 24.h),

        DropDownWidget(selectedItem: OConstants.selectedState!, items: OConstants.states),

        /// Make Space
        SizedBox(height: 24.h),

        /// Phone Number
        TextFormFieldWidget(
          controller: phoneController,
          textInputType: TextInputType.phone,
          focusNode: phoneFocusNode,
          hintText: 'Phone Number',
          hintColor: isPhoneFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
          prefixIcon: SvgPicture.asset(OImages.phone2Icon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(OColors.greyScale900, BlendMode.srcIn)),
          fillColor: isPhoneFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
          borderSide: isPhoneFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
          obscureText: false,
          isEdit: true,
        ),

        /// Make Space
        SizedBox(height: 24.h),

        /// Check for Male or Female
        DropDownWidget(selectedItem: OConstants.selectedGender!, items: OConstants.genders),

        /// Make Space
        SizedBox(height: 24.h),

        /// Address
        TextFormFieldWidget(
          controller: addressController,
          textInputType: TextInputType.streetAddress,
          focusNode: addressFocusNode,
          hintText: 'Cairo',
          hintColor: isAddressFieldFocused ? OColors.primaryColor500 : OColors.greyScale900,
          suffixIcon: SvgPicture.asset(OImages.addressIcon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(OColors.greyScale900, BlendMode.srcIn)),
          fillColor: isAddressFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
          borderSide: isAddressFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
          obscureText: false,
          isEdit: true,
        ),

        /// Make Space
        SizedBox(height: 24.h),

        Align(
          alignment: Alignment.bottomCenter,
          child: MainButtonWidget(
            buttonText: 'Update',
            onTap: () => {},
            margin: EdgeInsets.zero,
            buttonColor: fullNameController.text.isEmpty || addressController.text.isEmpty || dateOfBirthController.text.isEmpty || addressController.text.isEmpty ? OColors.disabledButton : OColors.primaryColor500,
            boxShadow: fullNameController.text.isEmpty || addressController.text.isEmpty || dateOfBirthController.text.isEmpty || addressController.text.isEmpty ? [] : [AppBoxShadows.buttonShadowOne],
          ),
        ),
      ],
    );
  }
}