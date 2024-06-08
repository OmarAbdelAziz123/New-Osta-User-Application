import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/common/widgets/bottom_sheet/show_location_bottom_sheet.dart';
import 'package:osta_user_app/common/widgets/checkbox/remember_me_widget.dart';
import 'package:osta_user_app/common/widgets/what_happened_with_us/what_happened_with_us_widget.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/features/home/models/address/get_all_addresses_model.dart';
import 'package:osta_user_app/features/home/presentation/widgets/home/electricity_widgets/sub_services_widget.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

import '../../../../../../auth/models/address/country_index_model.dart';

class OneTimeScreenInElectricity extends StatefulWidget {
  OneTimeScreenInElectricity({super.key, required this.subServicesList, required this.addressList, required this.serviceId, required this.category});

  var subServicesList;
  var addressList;
  int serviceId;
  String category;

  @override
  State<OneTimeScreenInElectricity> createState() => _OneTimeScreenInElectricityState();
}

class _OneTimeScreenInElectricityState extends State<OneTimeScreenInElectricity> {
  int selectedIndex = -1;
  int selectedDays = 0;
  int selectedSpecificService = -1;

  TextEditingController textInServicesController = TextEditingController();
  final FocusNode textInServicesFocusNode = FocusNode();
  bool isTextInServicesFieldFocused = false;
  bool iNeedWrite = false;
  bool isChecked = false;

  bool isExtended = false;
  bool isSpecificService = false;

  int indexInSelectedSubService = 0;

  Map<String, String> keyValueMap = {};

  int numberOfSelectedFromOne = 1;

  Set<int> selectedIndices = {};

  void addButtonPressed({required int subServiceId}) {
    // Generate a key based on the subServiceId
    String key = subServiceId.toString();

    setState(() {
      // Check if the key exists in the map
      if (keyValueMap.containsKey(key)) {
        // If the key exists, increment the count
        int count = int.parse(keyValueMap[key]!);
        count++;
        keyValueMap[key] = count.toString();
      } else {
        // If the key does not exist, start with count 0
        keyValueMap[key] = '1';
      }

      print('Number Of One Item: $numberOfSelectedFromOne');

      print(keyValueMap);
    });
  }

  void minuseButtonPressed({required int subServiceId}) {
    // Generate a key based on the subServiceId
    String key = subServiceId.toString();

    setState(() {
      // Check if the key exists in the map
      if (keyValueMap.containsKey(key)) {
        // If the key exists, increment the count
        int count = int.parse(keyValueMap[key]!);
        count--;
        keyValueMap[key] = count.toString();
        if(count <= 0) {
          keyValueMap.remove(key);
        }
      }

      print('Number Of One Item: $numberOfSelectedFromOne');

      print(keyValueMap);
    });
  }

  @override
  void initState() {
    super.initState();
    /// Add listener to focus node
    textInServicesFocusNode.addListener(() => setState(() => isTextInServicesFieldFocused = textInServicesFocusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    textInServicesFocusNode.dispose();
    textInServicesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // if(selectedDays == 0) {
        //   ODeviceUtils.showSnackBar(context: context, message: 'Please Choice Warranty', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning);
        // }

        // if(keyValueMap.isEmpty) {
        //   ODeviceUtils.showSnackBar(context: context, message: 'Please Choice Specific Service', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning);
        // }

        // if(isChecked == true && textInServicesController.text.isEmpty) {
        //   ODeviceUtils.showSnackBar(context: context, message: 'Please Write Details', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning);
        // }
      },
      builder: (context, state) {
        var subServiceCubit = HomeCubit.get(context);

        return SingleChildScrollView(
          child: Column(
            children: [
              const WhatHappenedWithUsWidget(),

              /// Make Size
              SizedBox(height: 23.h),

              /// Divider
              Divider(color: OColors.greyScale200, thickness: 1.w),

              /// Make Size
              SizedBox(height: 24.h),

              /// Osta Extended Warranty
              InkWellWidget(
                onTap: () => setState(() => isExtended = !isExtended),
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                      color: isExtended ? OColors.primaryColor500 : OColors.greyScale50,
                      gradient: isExtended ? AppGradients.purpleGradient : null,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [AppBoxShadows.cardShadowFour]
                  ),
                  child: Center(child: Text('Osta extended warranty', style: OStyles.bodyLargeSemiBold.copyWith(color: isExtended ? OColors.whiteColor : OColors.greyScale600))),
                ),
              ),

              /// Make Size
              SizedBox(height: isExtended ? 24.h : 0),

              ///
              isExtended ? Column(
                children: [
                  SizedBox(
                    height: 38.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 3,
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 14.w);
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() => selectedDays = index+1);
                            print(selectedDays);
                          },
                          child: AnimatedContainer(
                            curve: Curves.easeInOut,
                            height: 35.h,
                            width: 97.w,
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: selectedDays == index+1 ? OColors.primaryColor500 : OColors.whiteColor,
                              border: Border.all(color: OColors.primaryColor500, width: 2.w),
                            ),
                            child: Center(
                              child: Text(OConstants.daysList[index], style: OStyles.bodyLargeBold.copyWith(color: selectedDays == index+1 ?  OColors.whiteColor : OColors.primaryColor500)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 38.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 3,
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 14.w);
                      },
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 97.w,
                          height: 35.h,
                          child: Center(child: Text(OConstants.pricesList[index], textAlign: TextAlign.center, style: OStyles.bodyXLargeSemiBold.copyWith(color: OColors.greyScale300))),
                        );
                      },
                    ),
                  ),
                ],
              )
                  : const SizedBox.shrink(),

              /// Make Size
              SizedBox(height: isExtended ? 20.h :  35.h),

              /// Divider
              Divider(color: OColors.greyScale200, thickness: 1.w),

              /// Make Size
              SizedBox(height: 12.h),

              /// Row (Specific services - See All)
              RowSeeAllWidget(
                mainText: 'Specific services',
                seeAllText: 'See All',
                onTap: () => context.pushNamed(ORoutesName.specificServicesRoute, arguments: widget.serviceId),
              ),

              /// Make Size
              SizedBox(height: 18.h),

              /// Specific Services
              widget.subServicesList == null
                  ? LoadingWidget(iconColor: OColors.primaryColor500)
                  : SizedBox(
                height: 50.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: widget.subServicesList.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 14.w);
                  },
                  itemBuilder: (context, index) {
                     int idInSelectedSubService = widget.subServicesList[index].id;
                     String subServiceName = widget.subServicesList[index].name;

                    return SubServicesWidget(
                      subServiceName: subServiceName,
                      onTap: () {
                        addButtonPressed(subServiceId: idInSelectedSubService);
                      },
                      numberOfPieces: keyValueMap.containsKey(idInSelectedSubService.toString()) ? keyValueMap[idInSelectedSubService.toString()]! : '0',
                      onPressed: () {
                          minuseButtonPressed(subServiceId: idInSelectedSubService);
                      },
                    );
                  },
                ),
              ),

              /// Make Size
              SizedBox(height: 24.h),

              /// Divider
              Divider(color: OColors.greyScale200, thickness: 1.w),

              /// Make Size
              SizedBox(height: 12.h),

              /// Row (اAnother service - See All)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 3, child: Text('Another service', style: OStyles.h5Bold)),
                  Expanded(child: RememberMeWidget(isChecked: isChecked, onChanged: (p0) => setState(() =>isChecked = !isChecked), isRememberMe: false)),
                  Text('I don\'t know the problem', style: OStyles.bodyMediumSemiBold),
                ],
              ),

              /// Make Size
              SizedBox(height: 18.h),

              iNeedWrite
                  ? Stack(
                children: [
                  TextFormFieldWidget(
                    controller: textInServicesController,
                    textInputType: TextInputType.text,
                    focusNode: textInServicesFocusNode,
                    hintText: 'Another Services',
                    hintColor: isTextInServicesFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
                    fillColor: isTextInServicesFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
                    borderSide: isTextInServicesFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                    obscureText: false,
                    maxLines: 4,
                    // suffixIcon: ,
                  ),
                  Positioned(
                    bottom: 12.h,
                    right: 12.w,
                    child: Image.asset(OImages.imagePicker, fit: BoxFit.scaleDown),
                  ),
                ],
              )
                  : GestureDetector(
                onTap: () {
                  setState(() => iNeedWrite = !iNeedWrite);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Click here to write details', textAlign: TextAlign.center, style: OStyles.bodyLargeBold.copyWith(color: OColors.primaryColor500)),
                  ],
                ),
              ),

              /// Make Size
              SizedBox(height: 24.h),

              ContinueButtonInBottomWidget(
                centerWidget: state is MakeOrderLoadingState ? Center(child: LoadingWidget(iconColor: OColors.whiteColor)) : Text('Continue', style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)),
                onTap: () {
                  List<int> subServiceIdsList = keyValueMap.keys.map((key) => int.parse(key)).toList();
                  List<int> subServiceQuantitiesList = keyValueMap.values.map((value) => int.parse(value)).toList();

                  // subServiceCubit.makeOrderFunction(
                  //   category: widget.category,
                  //   warrantyId: selectedDays,
                  //   serviceId: widget.serviceId,
                  //   locationId: 2,
                  //   description: textInServicesController.text,
                  //   subServicesIds: subServiceIdsList,
                  //   subServiceQuantities: subServiceQuantitiesList,
                  //   unknownProblem: isChecked ? 1 : 0,
                  //   isSpace: false,
                  //   isSubServicesIds: true,
                  //   isSubServiceQuantities: true,
                  //   isWarrantyId: true,
                  // );
                  selectedDays == 0 ?
                    ODeviceUtils.showSnackBar(context: context, message: 'Please Choice Warranty', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning)
                      : keyValueMap.isEmpty ?
                   ODeviceUtils.showSnackBar(context: context, message: 'Please Choice Specific Service', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning)
                  //     : context.pushNamed(ORoutesName.choiceYourLocationRoute, arguments: {
                  //       'category':  widget.category,
                  //       'warrantyId':  selectedDays,
                  //       'serviceId':  widget.serviceId,
                  //       'description':  textInServicesController.text,
                  //       'subServicesIds': subServiceIdsList,
                  //       'subServiceQuantities': subServiceQuantitiesList,
                  //       'unknownProblem': isChecked ? 1 : 0,
                  //       'isSpace': false,
                  //       'isSubServicesIds':  true,
                  //       'isSubServiceQuantities':  true,
                  //       'isWarrantyId':  true,
                  // });
                      : showLocationBottomSheet(
                      context: context,
                      map: {
                        'category':  widget.category,
                        'warrantyId':  selectedDays,
                        'serviceId':  widget.serviceId,
                        'description':  textInServicesController.text,
                        'subServicesIds': subServiceIdsList,
                        'subServiceQuantities': subServiceQuantitiesList,
                        'unknownProblem': isChecked ? 1 : 0,
                        'isSpace': false,
                        'isSubServicesIds':  true,
                        'isSubServiceQuantities':  true,
                        'isWarrantyId':  true,
                      },
                    historyAddressesWidget: widget.addressList == null
                        ? LoadingWidget(iconColor: OColors.primaryColor500)
                    : ListView.builder(
                      itemCount: widget.addressList.length,
                      itemBuilder:(context,index) {
                        return PreviousAddressesWidget(
                          icon: widget.addressList[index].name! == 'home' ? SvgPicture.asset(OImages.homeIcon) : widget.addressList[index].name! == 'work' ? Icon(Icons.work) : widget.addressList[index].name! == 'friend' ? Icon(Icons.person) : Icon(Icons.more_horiz),
                          addressName: widget.addressList[index].name! == 'home' ? 'Home' : widget.addressList[index].name! == 'work' ? 'Work' : widget.addressList[index].name! == 'friend' ? 'Friend' : 'Other',
                          location: widget.addressList[index].desc!,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }
    );
  }

  /// Bottom Sheet
  void showLocationBottomSheet({required BuildContext context, required Map map, required Widget historyAddressesWidget}) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return ShowLocationBottomSheet(map: map, historyAddressesWidget: historyAddressesWidget);
      },
    );
  }
}

