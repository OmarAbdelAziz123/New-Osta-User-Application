import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osta_user_app/common/widgets/drop_down/drop_down_widget.dart';
import 'package:osta_user_app/features/auth/managers/auth_cubit.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';

class FillYourProfileFormWidget extends StatefulWidget {
  const FillYourProfileFormWidget({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<FillYourProfileFormWidget> createState() => _FillYourProfileFormWidgetState();
}

class _FillYourProfileFormWidgetState extends State<FillYourProfileFormWidget> {
  XFile? _selectedImageToPerson;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController invitationController = TextEditingController();
  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode dateOfBirthFocusNode = FocusNode();
  final FocusNode addressFocusNode = FocusNode();
  final FocusNode countryFocusNode = FocusNode();
  final FocusNode invitationFocusNode = FocusNode();
  bool isFullNameFieldFocused = false;
  bool isEmailFieldFocused = false;
  bool isDateOfBirthFieldFocused = false;
  bool isAddressFieldFocused = false;
  bool isCountryFieldFocused = false;
  bool isInvitationFieldFocused = false;

  @override
  void initState() {
    super.initState();
    /// Add listener to focus node
    fullNameFocusNode.addListener(() => setState(() => isFullNameFieldFocused = fullNameFocusNode.hasFocus));
    emailFocusNode.addListener(() => setState(() => isEmailFieldFocused = emailFocusNode.hasFocus));
    dateOfBirthFocusNode.addListener(() => setState(() => isDateOfBirthFieldFocused = dateOfBirthFocusNode.hasFocus));
    addressFocusNode.addListener(() => setState(() => isAddressFieldFocused = addressFocusNode.hasFocus));
    countryFocusNode.addListener(() => setState(() => isCountryFieldFocused = countryFocusNode.hasFocus));
    invitationFocusNode.addListener(() => setState(() => isInvitationFieldFocused = invitationFocusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    dateOfBirthFocusNode.dispose();
    addressFocusNode.dispose();
    countryFocusNode.dispose();
    fullNameController.dispose();
    emailController.dispose();
    dateOfBirthController.dispose();
    addressController.dispose();
    countryController.dispose();
    invitationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is FillYourAccountLoadingState) {
          } else if (state is FillYourAccountSuccessState) {
            if (state.message == 'registered successfully, and otp sent') {
              context.pushNamed(ORoutesName.otpRoute, arguments: widget.phoneNumber);
            } else {
              ODeviceUtils.showSnackBar(
                context: context,
                message: state.message!,
                textStyle: OStyles.bodyLargeRegular,
                textColor: OColors.whiteColor,
                bgColor: OColors.success,
              );
            }
          } else if (state is FillYourAccountErrorState) {
            ODeviceUtils.showSnackBar(
              context: context,
              message: state.message!,
              textStyle: OStyles.bodyLargeRegular,
              textColor: OColors.whiteColor,
              bgColor: OColors.error,
            );
          }
        },
      builder: (context, state) {
        // var fillYourAccountCubit = AuthCubit.get(context);
        var countryIndex = AuthCubit.get(context);
        String selectedCountry = countryIndex.countryIndexModel.result![0].name!;
        String selectedGender = AppLocalizations.of(context)!.translate('male')!;
        int? idSelected;

        int defaultCountryId = countryIndex.countryIndexModel.result![0].id!;

        return Container(
            width: double.infinity,
            // height: MediaQuery.of(context).size.height * 2,
            child: Column(
              children: [
                Stack(
                  children: [
                    /// Image Profile
                    CircleAvatar(
                      radius: 60.r,
                      backgroundImage: _selectedImageToPerson != null ? null : const AssetImage(OImages.avatarIcon),
                      backgroundColor: Colors.transparent,
                      // child: SvgPicture.asset(OImages.avatarIcon),
                      child: _selectedImageToPerson != null ? ClipRRect(
                        borderRadius: BorderRadius.circular(60.r),
                        child: Image.file(
                          File(_selectedImageToPerson!.path),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ) : null,
                    ),
                    /// Edite Icon
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWellWidget(onTap: _openImageGalleryToPerson, child: SvgPicture.asset(OImages.editIcon))),
                  ],
                ),

                /// Make Space
                SizedBox(height: 24.h),

                /// Full Name
                TextFormFieldWidget(
                  controller: fullNameController,
                  textInputType: TextInputType.name,
                  focusNode: fullNameFocusNode,
                  hintText: AppLocalizations.of(context)!.translate('fullName')!,
                  hintColor: isFullNameFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
                  fillColor: isFullNameFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
                  borderSide: isFullNameFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                  obscureText: false,
                ),

                /// Make Space
                SizedBox(height: 20.h),

                /// Email
                TextFormFieldWidget(
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  focusNode: emailFocusNode,
                  hintText: AppLocalizations.of(context)!.translate('email')!,
                  hintColor: isEmailFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
                  prefixIcon: SvgPicture.asset(OImages.email2Icon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isEmailFieldFocused ? OColors.primaryColor500 : emailController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
                  fillColor: isEmailFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
                  borderSide: isEmailFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                  obscureText: false,
                ),

                /// Make Space
                SizedBox(height: 20.h),

                /// Date Of Birth
                TextFormFieldWidget(
                  controller: dateOfBirthController,
                  textInputType: TextInputType.datetime,
                  focusNode: dateOfBirthFocusNode,
                  readOnly: true,
                  hintText: AppLocalizations.of(context)!.translate('dateOfBirth')!,
                  hintColor: isDateOfBirthFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
                  suffixIcon: InkWellWidget(
                      onTap: () {
                        showDatePicker(context: context, firstDate: DateTime(1900), lastDate: DateTime.now()).then((date) {
                          if(date != null) {
                            setState(() {
                              dateOfBirthController.text = ODeviceUtils.formatDateString(date: date, dateFormat: 'yyyy-MM-dd', context: context);
                            });
                          }
                        });
                      },
                      child: SvgPicture.asset(OImages.calendarIconNotSelected, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(OColors.greyScale900, BlendMode.srcIn))),
                  fillColor: isDateOfBirthFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
                  borderSide: isDateOfBirthFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                  obscureText: false,
                  inputFormatters: [DateInputFormatter()],
                ),

                /// Make Space
                SizedBox(height: 20.h),

                /// Address
                // TextFormFieldWidget(
                //   controller: addressController,
                //   textInputType: TextInputType.streetAddress,
                //   focusNode: addressFocusNode,
                //   hintText: 'Address',
                //   hintColor: isAddressFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
                //   suffixIcon: SvgPicture.asset(OImages.addressIcon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isAddressFieldFocused ? OColors.primaryColor500 : addressController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
                //   fillColor: isAddressFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
                //   borderSide: isAddressFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                //   obscureText: false,
                // ),

                /// Make Space
                // SizedBox(height: 20.h),

                /// Address
                DropDownWidget(
                  selectedItem: countryIndex.countryIndexModel.result![0].name!,
                  items: countryIndex.countries,
                  isInFillProfile: true,
                  onItemSelected: (selected) {
                    selectedCountry = selected!;
                    idSelected = countryIndex.countryNameToIdMap[selected];
                  },
                ),
                // DropDownWidget(selectedItem: OConstants.states[0], items: OConstants.states, isInFillProfile: true),

                /// Make Space
                SizedBox(height: 20.h),

                /// Check for Male or Female
                DropDownWidget(
                    selectedItem: OConstants.selectedGender!,
                    items: OConstants.genders,
                    isInFillProfile: true,
                  onItemSelected: (selected) => selectedGender = selected!,

                ),

                /// Make Space
                SizedBox(height: 20.h),

                TextFormFieldWidget(
                  controller: invitationController,
                  textInputType: TextInputType.streetAddress,
                  focusNode: invitationFocusNode,
                  hintText: 'Invitation code',
                  hintColor: isInvitationFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
                  suffixIcon: SvgPicture.asset(OImages.invitationCodeIcon, fit: BoxFit.scaleDown, height: 22.h, width: 22.w, colorFilter: ColorFilter.mode(isInvitationFieldFocused ? OColors.primaryColor500 : addressController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
                  fillColor: isInvitationFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
                  borderSide: isInvitationFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                  obscureText: false,
                ),

                /// Make Space
                SizedBox(height: 46.h),

                MainButtonWidget(
                  centerWidgetInButton: state is FillYourAccountLoadingState ? Padding(padding: EdgeInsets.all(3.sp), child: LoadingWidget(iconColor: OColors.whiteColor)) : Text(AppLocalizations.of(context)!.translate('continue')!, style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)),
                  margin: EdgeInsets.zero,
                  onTap: state is FillYourAccountLoadingState ? null : () {
                    File? _selectedFile = _selectedImageToPerson != null ? File(_selectedImageToPerson!.path) : null;

                    if(_selectedImageToPerson != null) {
                      countryIndex.fillYourAccountFunction(
                        name: fullNameController.text,
                        email: emailController.text,
                        countryId: idSelected == null ||
                            idSelected.toString() == '' || idSelected
                            .toString()
                            .isEmpty ? defaultCountryId.toString() : idSelected
                            .toString(),
                        phone: widget.phoneNumber,
                        gender: OConstants.selectedGender == 'Male'
                            ? AppLocalizations.of(context)!.translate('male')!
                            : AppLocalizations.of(context)!.translate('female')!,
                        dateOfBirth: dateOfBirthController.text,
                        personal: _selectedImageToPerson!.path,
                      );
                      logSuccess(fullNameController.text);
                      logSuccess(emailController.text);
                      logSuccess(idSelected.toString());
                      logSuccess(widget.phoneNumber.toString());
                      logSuccess(_selectedImageToPerson!.path.toString());

                    } else {
                      ODeviceUtils.showSnackBar(context: context, message: AppLocalizations.of(context)!.translate('mustChoiceProfilePhoto')!, textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning);
                    }
                  },
                  // onTap: () => log(idSelected.toString() + ' ' + defaultCountryId.toString()),
                  buttonColor: fullNameController.text.isEmpty || emailController.text.isEmpty ? OColors.disabledButton : OColors.primaryColor500,
                  boxShadow: fullNameController.text.isEmpty || emailController.text.isEmpty ? [] : [AppBoxShadows.buttonShadowOne],
                ),
              ],
            ),
          );
      },
    );
  }

  Future<void> _openImageGalleryToPerson() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImageToPerson = image;
      });
    } else {
      print('No image selected');
    }
  }

}