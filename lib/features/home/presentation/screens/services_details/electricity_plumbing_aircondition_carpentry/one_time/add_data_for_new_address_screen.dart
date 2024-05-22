import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:osta_user_app/common/widgets/drop_down/drop_down_widget.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/features/home/presentation/screens/services_details/electricity_plumbing_aircondition_carpentry/one_time/one_time_screen_in_electricity.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class AddDataForNewAddressScreen extends StatefulWidget {
  const AddDataForNewAddressScreen({super.key});

  @override
  State<AddDataForNewAddressScreen> createState() => _AddDataForNewAddressScreenState();
}

class _AddDataForNewAddressScreenState extends State<AddDataForNewAddressScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController apartmentNumberController = TextEditingController();
  TextEditingController floorNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController isDefaultController = TextEditingController();

  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode streetFocusNode = FocusNode();
  final FocusNode apartmentNumberFocusNode = FocusNode();
  final FocusNode floorNumberFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  final FocusNode isDefaultFocusNode = FocusNode();

  bool isFullNameFocused = false;
  bool isStreetFocused = false;
  bool isApartmentNumberFocused = false;
  bool isFloorNumberFocused = false;
  bool isDescriptionFocused = false;
  bool isDefaultFocused = false;

  bool isCountryFieldFocused = false;
  bool isCityFieldFocused = false;

  String selectCountry = 'Select Country';
  String selectCity = 'Select City';

  List<String> uniqueCountries = [];

  List<String> uniqueCities = [];

  int? idSelectedForCountry;
  int? idSelectedForCity;

  @override
  void initState() {
    super.initState();
    /// Add listener to focus node
    fullNameFocusNode.addListener(() => setState(() => isFullNameFocused = fullNameFocusNode.hasFocus));
    streetFocusNode.addListener(() => setState(() => isStreetFocused = streetFocusNode.hasFocus));
    apartmentNumberFocusNode.addListener(() => setState(() => isApartmentNumberFocused = apartmentNumberFocusNode.hasFocus));
    floorNumberFocusNode.addListener(() => setState(() => isFloorNumberFocused = floorNumberFocusNode.hasFocus));
    descriptionFocusNode.addListener(() => setState(() => isDescriptionFocused = descriptionFocusNode.hasFocus));
    isDefaultFocusNode.addListener(() => setState(() => isDefaultFocused = isDefaultFocusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    fullNameFocusNode.dispose();
    streetFocusNode.dispose();
    apartmentNumberFocusNode.dispose();
    floorNumberFocusNode.dispose();
    descriptionFocusNode.dispose();
    isDefaultFocusNode.dispose();
    fullNameController.dispose();
    streetController.dispose();
    apartmentNumberController.dispose();
    floorNumberController.dispose();
    descriptionController.dispose();
    isDefaultController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        // create: (context) => HomeCubit()..getAllCitiesFunction(countryId: 1),
        create: (context) => HomeCubit()..getAllCitiesFunction(countryId: int.parse(OCacheHelper.getString(key: CacheKeys.countryId)!)),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if(state is AddDataForNewAddressesSuccessState) {
              context.pop();
              setState(() {});
              ODeviceUtils.showSnackBar(context: context, message: 'Please Refresh This Page', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning);
              // Navigator.pop(context);
              // context.pushReplacementNamed(ORoutesName.choiceYourLocationRoute);
            } else if(state is AddDataForNewAddressesErrorState) {
              ODeviceUtils.showSnackBar(context: context, message: 'You have an error in Add Location', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.error);
            }
          },
          builder: (context, state) {
            var countryIndexToMakeOrder = HomeCubit.get(context);

            uniqueCountries = countryIndexToMakeOrder.countries.toSet().toList();

            if (!uniqueCountries.contains(selectCountry)) {
              uniqueCountries.insert(0, selectCountry);
            }

            uniqueCities = countryIndexToMakeOrder.cities.toSet().toList();

            if (!uniqueCities.contains(selectCity)) {
              uniqueCities.insert(0, selectCity);
            }

            return Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// App Bar
                    AppBarWidget(leading: InkWellWidget(onTap: () => context.pop(), child: const Icon((Icons.arrow_back))), title: 'Add Location', actions: SvgPicture.asset(OImages.moreIcon2), widthOfText: 280.w),

                    /// Make Space
                    SizedBox(height: 24.h),

                    SizedBox(
                      height: 41.h,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Add Addresses Details', style: OStyles.bodyXLargeSemiBold.copyWith(color: OColors.primaryColor500)),
                          Container(
                            height: 4.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: OColors.primaryColor500,
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Make Space
                    SizedBox(height: 34.h),

                    /// Full Name
                    TextFormFieldWidget(
                      controller: fullNameController,
                      textInputType: TextInputType.name,
                      focusNode: fullNameFocusNode,
                      hintText: 'Name',
                      hintColor: isFullNameFocused ? OColors.primaryColor500 : OColors.greyScale500,
                      fillColor: isFullNameFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
                      borderSide: isFullNameFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                      obscureText: false,
                    ),

                    /// Make Space
                    SizedBox(height: 20.h),

                    /// Street Name
                    TextFormFieldWidget(
                      controller: streetController,
                      textInputType: TextInputType.name,
                      focusNode: streetFocusNode,
                      hintText: 'Street Name',
                      hintColor: isStreetFocused ? OColors.primaryColor500 : OColors.greyScale500,
                      fillColor: isStreetFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
                      borderSide: isStreetFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                      obscureText: false,
                    ),

                    /// Make Space
                    SizedBox(height: 20.h),

                    /// Apartment Number
                    TextFormFieldWidget(
                      controller: apartmentNumberController,
                      textInputType: TextInputType.name,
                      focusNode: apartmentNumberFocusNode,
                      hintText: 'Apartment Number',
                      hintColor: isApartmentNumberFocused ? OColors.primaryColor500 : OColors.greyScale500,
                      fillColor: isApartmentNumberFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
                      borderSide: isApartmentNumberFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                      obscureText: false,
                    ),

                    /// Make Space
                    SizedBox(height: 20.h),

                    /// Floor Number
                    TextFormFieldWidget(
                      controller: floorNumberController,
                      textInputType: TextInputType.name,
                      focusNode: floorNumberFocusNode,
                      hintText: 'Floor Number',
                      hintColor: isFloorNumberFocused ? OColors.primaryColor500 : OColors.greyScale500,
                      fillColor: isFloorNumberFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
                      borderSide: isFloorNumberFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                      obscureText: false,
                    ),

                    /// Make Space
                    SizedBox(height: 20.h),

                    /// City
                    Row(
                      children: [
                        Expanded(
                          child: DropDownWidget(
                            selectedItem: selectCity,
                            items: uniqueCities,
                            isInFillProfile: true,
                            onItemSelected: (selected) {
                              selectCity = selected!;
                              idSelectedForCity = countryIndexToMakeOrder.cityNameToIdMap[selected];
                              log('Selected Country ID: $idSelectedForCountry');
                              log('Selected Country NAME: $selectCountry');
                              log('Selected City ID: $idSelectedForCity');
                              log('Selected City NAME: $selectCity');
                            },
                          ),
                        ),
                        state is CityIndexLoadingState
                            ? LoadingWidget(iconColor: OColors.primaryColor500)
                            : Lottie.asset(OImages.successImage, width: 50.w),
                      ],
                    ),

                    /// Make Space
                    SizedBox(height: 20.h),

                    /// Description
                    TextFormFieldWidget(
                      controller: descriptionController,
                      textInputType: TextInputType.name,
                      focusNode: descriptionFocusNode,
                      hintText: 'Description',
                      hintColor: isDescriptionFocused ? OColors.primaryColor500 : OColors.greyScale500,
                      fillColor: isDescriptionFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
                      borderSide: isDescriptionFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                      obscureText: false,
                    ),

                    /// Make Space
                    SizedBox(height: 34.h),

                    ContinueButtonInBottomWidget(
                      centerWidget: state is AddDataForNewAddressesLoadingState ? Padding(padding: EdgeInsets.all(3.sp), child: LoadingWidget(iconColor: OColors.whiteColor)) : Text('Continue', style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)),
                      onTap: () {
                        // log(fullNameController.text);
                        // log(streetController.text);
                        // log(apartmentNumberController.text);
                        // log(floorNumberController.text);
                        // log(idSelectedForCity.toString());
                        // log(descriptionController.text);
                        // log(selectCity);
                        countryIndexToMakeOrder.addDataForNewAddressesFunction(
                          name: fullNameController.text,
                          streetName: streetController.text,
                          apartmentNumber: int.parse(apartmentNumberController.text),
                          floorNumber: int.parse(floorNumberController.text),
                          cityId: idSelectedForCity!,
                          description: descriptionController.text,
                          latitude: '30.0510778',
                          longitude: '31.3655877',
                        );
                      },
                    ),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
