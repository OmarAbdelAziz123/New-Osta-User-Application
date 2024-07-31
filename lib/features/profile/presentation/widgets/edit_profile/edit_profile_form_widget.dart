import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:osta_user_app/common/widgets/drop_down/drop_down_widget.dart';
import 'package:osta_user_app/features/auth/managers/auth_cubit.dart';
import 'package:osta_user_app/features/profile/managers/profile_cubit.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';

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

  String selectCountry = 'Select Country';
  String selectedGender = 'Male';

  @override
  void initState() {
    // ProfileCubit.get(context).getAllProfileDataFunc();
    super.initState();
    /// Add listener to focus node
    fullNameFocusNode.addListener(() => setState(() => isFullNameFieldFocused = fullNameFocusNode.hasFocus));
    dateOfBirthFocusNode.addListener(() => setState(() => isDateOfBirthFieldFocused = dateOfBirthFocusNode.hasFocus));
    emailFocusNode.addListener(() => setState(() => isEmailFieldFocused = emailFocusNode.hasFocus));
    phoneFocusNode.addListener(() => setState(() => isPhoneFieldFocused = phoneFocusNode.hasFocus));
    addressFocusNode.addListener(() => setState(() => isAddressFieldFocused = addressFocusNode.hasFocus));

    if(ProfileCubit.get(context).getProfileDataModel.result != null) {
      selectCountry = ProfileCubit.get(context).getProfileDataModel.result!.country!.name!;
      selectedGender = OConstants.genders.firstWhere((element) => element == ProfileCubit.get(context).getProfileDataModel.result!.gender!);
      fullNameController.text = ProfileCubit.get(context).getProfileDataModel.result!.name!;
      dateOfBirthController.text = ProfileCubit.get(context).getProfileDataModel.result!.dateOfBirth ?? '';
      emailController.text = ProfileCubit.get(context).getProfileDataModel.result!.email!;
      phoneController.text = ProfileCubit.get(context).getProfileDataModel.result!.phone!;
    }
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

  List<String> uniqueCountries = [];
  int? idSelectedForCountry;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if(state is UpdateProfileDataSuccessState) {
          OCacheHelper.putString(key: CacheKeys.fullName, value: ProfileCubit.get(context).getProfileDataModel.result!.name!);
          OCacheHelper.putString(key: CacheKeys.email, value: ProfileCubit.get(context).getProfileDataModel.result!.email!);
          selectCountry = ProfileCubit.get(context).getProfileDataModel.result!.country!.name!;
          selectedGender = OConstants.genders.firstWhere((element) => element == ProfileCubit.get(context).getProfileDataModel.result!.gender!);
          // selectedGender = ProfileCubit.get(context).getProfileDataModel.result!.gender!;
          // context.pushNamedAndRemoveUntil(ORoutesName.navigationMenuRoute, arguments: 3, predicate: (route) => false);
          ODeviceUtils.showSnackBar(context: context, message: AppLocalizations.of(context)!.translate('updateProfileDateSuccessfully')!, textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.success);
        }
        else if(state is UpdateProfileDataErrorState) {
          ODeviceUtils.showSnackBar(context: context, message: AppLocalizations.of(context)!.translate('updateProfileDateSuccessfully')!, textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.error);
        }
        if(state is GetProfileDataSuccessState) {
          selectCountry = ProfileCubit.get(context).getProfileDataModel.result!.country!.name!;
          selectedGender = OConstants.genders.firstWhere((element) => element == ProfileCubit.get(context).getProfileDataModel.result!.gender!);
          fullNameController.text = ProfileCubit.get(context).getProfileDataModel.result!.name!;
          dateOfBirthController.text = ProfileCubit.get(context).getProfileDataModel.result!.dateOfBirth!;
          emailController.text = ProfileCubit.get(context).getProfileDataModel.result!.email!;
          phoneController.text = ProfileCubit.get(context).getProfileDataModel.result!.phone!;
        }
      },
      builder: (context, state) {
        var profileCubit = ProfileCubit.get(context);

        return profileCubit.getProfileDataModel.result == null
        ? Center(child: LoadingWidget(iconColor: OColors.primaryColor500))
        : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Full Name
            TextFormFieldWidget(
              controller: fullNameController,
              textInputType: TextInputType.name,
              focusNode: fullNameFocusNode,
              hintText: profileCubit.getProfileDataModel.result == null ? '...' : profileCubit.getProfileDataModel.result!.name!,
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
              readOnly: true,
              hintText: profileCubit.getProfileDataModel.result!.dateOfBirth == null  ? AppLocalizations.of(context)!.translate('enterDateOfBirth')! : profileCubit.getProfileDataModel.result!.dateOfBirth!,
              hintColor: isDateOfBirthFieldFocused ? OColors.primaryColor500 : OColors.greyScale900,
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
              isEdit: true,
            ),

            /// Make Space
            SizedBox(height: 24.h),

            /// Email
            TextFormFieldWidget(
              controller: emailController,
              textInputType: TextInputType.emailAddress,
              focusNode: emailFocusNode,
              // hintText: '3omar@gmail.com',
              hintText: profileCubit.getProfileDataModel.result == null ? '...' : profileCubit.getProfileDataModel.result!.email!,
              hintColor: isEmailFieldFocused ? OColors.primaryColor500 : OColors.greyScale900,
              prefixIcon: SvgPicture.asset(OImages.email2Icon, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(OColors.greyScale900, BlendMode.srcIn)),
              fillColor: isEmailFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
              borderSide: isEmailFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
              obscureText: false,
              isEdit: true,
            ),

            /// Make Space
            SizedBox(height: 24.h),

            // DropDownWidget(selectedItem: OConstants.selectedState!, items: OConstants.states, isInFillProfile: false),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if(state is CountryIndexSuccessState) {

                }
              },
              builder: (context, state) {
                var countryIndex = AuthCubit.get(context);

                uniqueCountries = countryIndex.countries.toSet().toList();

                if (!uniqueCountries.contains(selectCountry)) {
                  uniqueCountries.insert(0, selectCountry);
                }

                return Column(
                  children: [
                    DropDownWidget(
                      selectedItem: selectCountry,
                      items: uniqueCountries,
                      isInFillProfile: true,
                      onItemSelected: (selected) {
                        idSelectedForCountry = countryIndex.countryNameToIdMap[selected];
                        AuthCubit.get(context).getAllCountriesFunction();
                        selectCountry = selected!;
                        logSuccess(idSelectedForCountry.toString());
                        // idSelectedForCountry = 0;
                      },
                    ),
                  ],
                );
              },
            ),

            /// Make Space
            SizedBox(height: 24.h),

            /// Phone Number
            TextFormFieldWidget(
              controller: phoneController,
              textInputType: TextInputType.phone,
              focusNode:  phoneFocusNode,
              // hintText: 'Phone Number',
              hintText: profileCubit.getProfileDataModel.result == null ? '...' : profileCubit.getProfileDataModel.result!.phone!,
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
            // DropDownWidget(selectedItem: OConstants.selectedGender!, items: OConstants.genders, isInFillProfile: false),
            // DropDownWidget(selectedItem: profileCubit.getProfileDataModel.result!.gender!, items: OConstants.genders, isInFillProfile: false),
            DropDownWidget(
              selectedItem: selectedGender,
              items: OConstants.genders,
              isInFillProfile: false,
              onItemSelected: (gender) {
                setState(() {
                  selectedGender = gender!;
                });
              },
            ),

            /// Make Space
            SizedBox(height: 24.h),

            Align(
              alignment: Alignment.bottomCenter,
              child: MainButtonWidget(
                centerWidgetInButton: state is UpdateProfileDataLoadingState
                  ? LoadingWidget(iconColor: OColors.whiteColor)
                  : Text(AppLocalizations.of(context)!.translate('update')!, style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)),
                onTap: state is UpdateProfileDataLoadingState ? null : () {
                  String? profileDateOfBirth = profileCubit.getProfileDataModel.result?.dateOfBirth;

                  String finalDateOfBirth = (dateOfBirthController.text.isEmpty && profileDateOfBirth != null)
                      ? profileDateOfBirth
                      : dateOfBirthController.text;
                  profileCubit.updateProfileDataFunc(
                    name: fullNameController.text.isEmpty ? profileCubit.getProfileDataModel.result!.name! : fullNameController.text,
                    dateOfBirth: finalDateOfBirth,
                    email: emailController.text.isEmpty ? profileCubit.getProfileDataModel.result!.email! : emailController.text,
                    countryId: idSelectedForCountry.toString().isEmpty || idSelectedForCountry == null ? profileCubit.getProfileDataModel.result!.countryId!.toString() : idSelectedForCountry.toString(),
                    phone: phoneController.text.isEmpty ? profileCubit.getProfileDataModel.result!.phone! : phoneController.text,
                    gender: selectedGender == 'Male' || selectedGender == 'male' ? AppLocalizations.of(context)!.translate('male')! : selectedGender == 'Female' || selectedGender == 'female' ? AppLocalizations.of(context)!.translate('female')! : AppLocalizations.of(context)!.translate('other')!,
                  );
                },
                margin: EdgeInsets.zero,
                buttonColor: fullNameController.text.isEmpty || addressController.text.isEmpty || dateOfBirthController.text.isEmpty || addressController.text.isEmpty ? OColors.disabledButton : OColors.primaryColor500,
                boxShadow: fullNameController.text.isEmpty || addressController.text.isEmpty || dateOfBirthController.text.isEmpty || addressController.text.isEmpty ? [] : [AppBoxShadows.buttonShadowOne],
              ),
            ),
          ],
        );
      },
    );
  }
}