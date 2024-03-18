import 'package:osta_user_app/common/widgets/date_input_formatter/date_input_formatter.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class FillYourProfileScreen extends StatelessWidget {
  const FillYourProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
          child: Column(
            children: [
              /// Arrow Button
              TopRowInAllScreens(titleOfScreenWidget: Text('Fill Your Profile', style: OStyles.h4Bold)),

              /// Make Space
              SizedBox(height: 24.h),

              /// Profile Image
              Container(
                width: double.infinity,
                height: 500.h,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        /// Image Profile
                        CircleAvatar(
                          radius: 60.r,
                          backgroundImage: const AssetImage(OImages.avatarIcon),
                          backgroundColor: Colors.transparent,
                          // child: SvgPicture.asset(OImages.avatarIcon),
                        ),
                        /// Edite Icon
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: SvgPicture.asset(OImages.editIcon),
                        ),
                      ],
                    ),

                    /// Make Space
                    SizedBox(height: 24.h),

                    FillYourProfileFormWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class FillYourProfileFormWidget extends StatefulWidget {
  const FillYourProfileFormWidget({super.key});

  @override
  State<FillYourProfileFormWidget> createState() => _FillYourProfileFormWidgetState();
}

class _FillYourProfileFormWidgetState extends State<FillYourProfileFormWidget> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode dateOfBirthFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  bool isFullNameFieldFocused = false;
  bool isDateOfBirthFieldFocused = false;
  bool isAddressFieldFocused = false;

  @override
  void initState() {
    super.initState();
    /// Add listener to focus node
    fullNameFocusNode.addListener(() => setState(() => isFullNameFieldFocused = fullNameFocusNode.hasFocus));
    dateOfBirthFocusNode.addListener(() => setState(() => isDateOfBirthFieldFocused = dateOfBirthFocusNode.hasFocus));
    addressFocusNode.addListener(() => setState(() => isAddressFieldFocused = addressFocusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    fullNameFocusNode.dispose();
    dateOfBirthFocusNode.dispose();
    addressFocusNode.dispose();
    fullNameController.dispose();
    dateOfBirthController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350.h,
      child: Column(
        children: [
          /// Full Name
          TextFormFieldWidget(
            controller: fullNameController,
            textInputType: TextInputType.name,
            focusNode: fullNameFocusNode,
            hintText: 'Full Name',
            hintColor: isFullNameFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
            fillColor: isFullNameFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
            borderSide: isFullNameFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
            obscureText: false,
          ),

          /// Make Space
          SizedBox(height: 20.h),

          /// Date Of Birth
          TextFormFieldWidget(
            controller: dateOfBirthController,
            textInputType: TextInputType.datetime,
            focusNode: dateOfBirthFocusNode,
            hintText: 'Date Of Birth (Optional)',
            hintColor: isDateOfBirthFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
            suffixIcon: SvgPicture.asset(OImages.calendarIconNotSelected, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isDateOfBirthFieldFocused ? OColors.primaryColor500 : dateOfBirthController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
            fillColor: isDateOfBirthFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
            borderSide: isDateOfBirthFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
            obscureText: false,
            inputFormatters: [DateInputFormatter()],
          ),

          /// Make Space
          SizedBox(height: 20.h),

          /// Address
          TextFormFieldWidget(
            controller: addressController,
            textInputType: TextInputType.streetAddress,
            focusNode: addressFocusNode,
            hintText: 'Address',
            hintColor: isAddressFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
            suffixIcon: SvgPicture.asset(OImages.addressIcon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isAddressFieldFocused ? OColors.primaryColor500 : addressController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
            fillColor: isAddressFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
            borderSide: isAddressFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
            obscureText: false,
          ),

          /// Make Space
          SizedBox(height: 46.h),

          MainButtonWidget(
            buttonText: 'Continue',
            onTap: () => context.pushNamed(ORoutesName.otpRoute),
            margin: EdgeInsets.zero,
            buttonColor: fullNameController.text.isEmpty || addressController.text.isEmpty ? OColors.disabledButton : OColors.primaryColor500,
            boxShadow: fullNameController.text.isEmpty || addressController.text.isEmpty ? [] : [AppBoxShadows.buttonShadowOne],
          ),
        ],
      ),
    );
  }
}


