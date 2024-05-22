import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:osta_user_app/common/widgets/drop_down/drop_down_widget.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class ChoiceYourLocationScreen extends StatefulWidget {
  const ChoiceYourLocationScreen({super.key, required this.data});

  final Map data;

  @override
  State<ChoiceYourLocationScreen> createState() => _ChoiceYourLocationScreenState();
}

class _ChoiceYourLocationScreenState extends State<ChoiceYourLocationScreen> {
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final FocusNode countryFocusNode = FocusNode();
  final FocusNode cityFocusNode = FocusNode();

  bool isCountryFieldFocused = false;
  bool isCityFieldFocused = false;

  String selectCountry = 'Select Country';
  String selectCity = 'Select City';

  List<String> uniqueCountries = [];

  List<String> uniqueCities = [];

  int? idSelectedForCountry;
  int? idSelectedForCity;

  bool isAddLocation = false;
  bool isChecked = false;
  int selectedAddress = 0;


  @override
  void initState() {
    // print(HomeCubit.get(context).getAllAddressesModel.result!.length);
    super.initState();
    refreshLists();
    /// Add listener to focus node
    countryFocusNode.addListener(() => setState(() => isCountryFieldFocused = countryFocusNode.hasFocus));
    cityFocusNode.addListener(() => setState(() => isCityFieldFocused = cityFocusNode.hasFocus));
}

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    countryFocusNode.dispose();
    cityFocusNode.dispose();
    countryController.dispose();
    cityController.dispose();
    super.dispose();
  }

  refreshLists() async {
    await HomeCubit.get(context).getAllAddressesFunction();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if(state is MakeOrderSuccessState) {
            OffersOrdersCubit.get(context).getAllOrdersByMeFunction();
            context.pushNamedAndRemoveUntil(ORoutesName.navigationMenuRoute, predicate: (route) => false);
            ODeviceUtils.showSnackBar(context: context, message: 'Successfully', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.success);
          } else if (state is MakeOrderErrorState) {
            ODeviceUtils.showSnackBar(context: context, message: 'You have an error in Make Order', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.error);
          } if(state is AddDataForNewAddressesSuccessState) {
            setState(() {});
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
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
            child: Column(
              children: [
                /// App Bar
                AppBarWidget(leading: InkWellWidget(onTap: () => context.pop(), child: const Icon((Icons.arrow_back))), title: 'My Location', actions: SvgPicture.asset(OImages.moreIcon2), widthOfText: 280.w),

                /// Make Space
                SizedBox(height: 24.h),

                RefreshIndicator(
                  onRefresh: () async {
                    await countryIndexToMakeOrder.getAllAddressesFunction();
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 41.h,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Choice Location for you', style: OStyles.bodyXLargeSemiBold.copyWith(color: OColors.primaryColor500)),
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

                      Column(
                        children: [
                          InkWellWidget(
                            onTap: () {
                              context.pushNamed(ORoutesName.addDataForNewAddressRoute);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              decoration: BoxDecoration(
                                color: OColors.greyScale100,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Add Location For You', style: OStyles.bodyXLargeSemiBold),
                                  /// Make Space
                                  SizedBox(width: 14.h),
                                  SvgPicture.asset(OImages.addNewAddress),
                                ],
                              ),
                            ),
                          ),

                          /// Make Space
                          SizedBox(height: 24.h),

                          /// Add Location For You
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: isAddLocation ? 1.0 : 0.0,
                            child: isAddLocation
                                ? Column(
                              children: [
                                /// County
                                DropDownWidget(
                                  selectedItem: selectCountry,
                                  items: uniqueCountries,
                                  isInFillProfile: true,
                                  onItemSelected: (selected) {
                                    idSelectedForCountry = countryIndexToMakeOrder.countryNameToIdMap[selected];
                                    HomeCubit.get(context).getAllCitiesFunction(countryId: idSelectedForCountry!);
                                    selectCountry = selected!;
                                    selectCity = 'Select City';
                                    idSelectedForCity = 0;
                                  },
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
                              ],
                            )
                                : const SizedBox(),
                          ),

                          /// Make Space
                          SizedBox(height: 34.h),

                          Divider(thickness: .5.w),

                          /// Make Space
                          SizedBox(height: 24.h),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('Your Addresses', style: OStyles.bodyXLargeSemiBold),
                                ],
                              ),

                              countryIndexToMakeOrder.getAllAddressesModel == null || countryIndexToMakeOrder.getAllAddressesModel.result == null ?
                              LoadingWidget(iconColor: OColors.primaryColor500)
                                  : countryIndexToMakeOrder.getAllAddressesModel.result!.isEmpty ?
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                                margin: EdgeInsets.symmetric(vertical: 24.h),
                                decoration: BoxDecoration(
                                  color: OColors.greyScale100,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: ODeviceUtils.getScreenHeight(context)/3.5,
                                      child: Text('Don\'t have any Addresses yet', style: OStyles.bodyLargeRegular),
                                    ),
                                  ],
                                ),
                              )
                                  : SizedBox(
                                width: double.infinity,
                                height: ODeviceUtils.getScreenHeight(context)/3,
                                // color: Colors.red,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: countryIndexToMakeOrder.getAllAddressesModel.result!.length,
                                  itemBuilder: (context, index) {
                                    var addressesList = countryIndexToMakeOrder.getAllAddressesModel.result;


                                    return Column(
                                      children: [
                                        InkWellWidget(
                                            onTap: () {
                                              setState(() {
                                                selectedAddress = index+1;
                                              });
                                              print(selectedAddress);
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                                              decoration: BoxDecoration(
                                                color: OColors.greyScale100,
                                                borderRadius: BorderRadius.circular(12.r),
                                                border: Border.all(
                                                  color: selectedAddress == index+1 ? OColors.primaryColor500 : Colors.transparent,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: ODeviceUtils.getScreenHeight(context)/3.5,
                                                    child: Text('${addressesList![index].apartmentNumber!}, ${addressesList![index].floorNumber}, ${addressesList![index].name!}, ${addressesList![index].street}, ${addressesList![index].city!.name!}', style: OStyles.bodyLargeRegular),
                                                  ),
                                                  /// Make Space
                                                  SizedBox(width: 14.h),
                                                  SvgPicture.asset(OImages.addressIcon, color: OColors.blackColor, width: 20.w),
                                                ],
                                              ),
                                            )),

                                        /// Make Space
                                        SizedBox(height: 24.h),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            InkWellWidget(
                                              onTap: () {},
                                              child: SvgPicture.asset(OImages.deleteIcon),
                                            ),
                                          ],
                                        ),

                                        /// Make Space
                                        SizedBox(height: 24.h),
                                      ],
                                    );
                                    // return AddressesWidget(
                                    //   addressText: '${addressesList![index].apartmentNumber!}, ${addressesList![index].floorNumber}, ${addressesList![index].name!}, ${addressesList![index].street}, ${addressesList![index].city!.name!}',
                                    //   onTap: () {
                                    //
                                    //   },
                                    // );
                                  },
                                ),
                              ),

                              // InkWellWidget(
                              //   onTap: () {},
                              //   child:
                              // ),
                              //
                              // /// Make Space
                              // SizedBox(height: 24.h),
                              //
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     InkWellWidget(
                              //       onTap: () {},
                              //       child: SvgPicture.asset(OImages.deleteIcon),
                              //     ),
                              //   ],
                              // ),

                              /// Make Space
                              SizedBox(height: 34.h),


                              ContinueButtonInBottomWidget(
                                onTap: () {
                                  // print(selectedAddress);
                                  countryIndexToMakeOrder.makeOrderFunction(
                                    category: widget.data['category'],
                                    warrantyId: widget.data['warrantyId'],
                                    serviceId: widget.data['serviceId'],
                                    locationId: selectedAddress,
                                    isSpace: widget.data['isSpace'],
                                    isSubServicesIds: widget.data['isSubServicesIds'],
                                    isSubServiceQuantities: widget.data['isSubServiceQuantities'],
                                    isWarrantyId: widget.data['isWarrantyId'],
                                    description: widget.data['description'],
                                    subServiceQuantities: widget.data['isSubServiceQuantities'] == false ? [] :  widget.data['subServiceQuantities'],
                                    subServicesIds: widget.data['isSubServicesIds'] == false ? [] : widget.data['subServicesIds'],
                                    unknownProblem: widget.data['unknownProblem'],
                                    space: widget.data['space'],
                                  );
                                },
                                centerWidget: state is MakeOrderLoadingState ? Padding(padding: EdgeInsets.all(3.sp), child: LoadingWidget(iconColor: OColors.whiteColor)) : Text('Continue', style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)),
                              ),

                            ],
                          ),

                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
