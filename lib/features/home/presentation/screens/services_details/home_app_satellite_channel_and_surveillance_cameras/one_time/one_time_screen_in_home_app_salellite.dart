import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/common/widgets/bottom_sheet/show_location_bottom_sheet.dart';
import 'package:osta_user_app/common/widgets/checkbox/remember_me_widget.dart';
import 'package:osta_user_app/common/widgets/what_happened_with_us/what_happened_with_us_widget.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/features/home/models/address/get_all_addresses_model.dart';
import 'package:osta_user_app/features/home/presentation/widgets/home/electricity_widgets/sub_services_widget.dart';
import 'package:osta_user_app/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';

class OneTimeScreenInHomeApp extends StatefulWidget {
  OneTimeScreenInHomeApp({super.key, required this.serviceId, required this.addressList, required this.category, required this.subServicesList});

  var subServicesList;
  var addressList;
  final int serviceId;
  final String category;

  @override
  State<OneTimeScreenInHomeApp> createState() => _OneTimeScreenInHomeAppState();
}

class _OneTimeScreenInHomeAppState extends State<OneTimeScreenInHomeApp> {
  int selectedIndex = -1;
  int selectWarranty = 0;
  int selectedSpecificService = -1;

  TextEditingController textInServicesController = TextEditingController();
  final FocusNode textInServicesFocusNode = FocusNode();
  bool isTextInServicesFieldFocused = false;
  bool iNeedWrite = false;

  bool isExtended = false;
  bool isSpecificService = false;
  bool isChecked = false;

  String selectedItem = 'Fix';

  int indexInSelectedSubService = 0;
  Map<String, String> keyValueMap = {};
  int numberOfSelectedFromOne = 1;

  bool isMakeOrder = false;
  List<File> _selectedImages = [];

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
    });

    print(keyValueMap);
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
        if(state is MakeOrderSuccessState) {
          setState(() {
            isMakeOrder = false;
          });
          OffersOrdersCubit.get(context).getAllOrdersByMeFunction();
          context.pushNamedAndRemoveUntil(ORoutesName.navigationMenuRoute, arguments: 0, predicate: (route) => false);
          ODeviceUtils.showSnackBar(context: context, message: 'Successfully', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.success);
        } else if (state is MakeOrderErrorState) {
          setState(() {
            isMakeOrder = false;
          });
          ODeviceUtils.showSnackBar(context: context, message: 'You have an error in Make Order', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.error);
        }
      },
      builder: (context, state) {
        var technologyCubit = HomeCubit.get(context);
        var result = technologyCubit.subServiceInIdThreeModel.result;
        int? idInSelectedSubService;
        String? subServiceName;

        return technologyCubit.subServiceInIdThreeModel == null
            ? LoadingWidget(iconColor: OColors.primaryColor500)
            : SingleChildScrollView(
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
                          // onTap: () => setState(() {
                          //   selectWarranty = index + 1;
                          //   print(selectWarranty);
                          // }),
                          onTap: () {
                            if(selectWarranty == index + 1) {
                              setState(() {
                                selectWarranty = 0;
                              });
                            } else {
                              setState(() {
                                selectWarranty = index + 1;
                              });
                            }
                          },
                          child: AnimatedContainer(
                            curve: Curves.easeInOut,
                            height: 35.h,
                            width: 97.w,
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: selectWarranty == index + 1 ? OColors.primaryColor500 : OColors.whiteColor,
                              border: Border.all(color: OColors.primaryColor500, width: 2.w),
                            ),
                            child: Center(
                              child: Text(OConstants.daysList[index], style: OStyles.bodyLargeBold.copyWith(color: selectWarranty == index + 1 ?  OColors.whiteColor : OColors.primaryColor500)),
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
              RowSeeAllWidget(mainText: 'Specific services', seeAllText: 'See All', onTap: () => context.pushNamed(ORoutesName.specificServicesRoute)),

              /// Make Size
              SizedBox(height: 18.h),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     AdvancedServicesWidget(
              //       image: OImages.contractorRequestIcon,
              //       title: 'Fix',
              //       border: Border.all(
              //         width: 1.w,
              //         color: selectedItem == 'Fix' ? OColors.primaryColor500 : OColors.whiteColor,
              //       ),
              //       onTap: () {
              //         setState(() {
              //           selectedItem = 'Fix';
              //           // keyValueMap.clear();
              //         });
              //         print(selectedItem);
              //       },
              //     ),
              //     AdvancedServicesWidget(
              //       image: OImages.marketIcon,
              //       title: 'New',
              //       border: Border.all(
              //         width: 1.w,
              //         color: selectedItem == 'New' ? OColors.primaryColor500 : OColors.whiteColor,
              //       ),
              //       onTap: () {
              //         setState(() {
              //           selectedItem = 'New';
              //           // keyValueMap.clear();
              //         });
              //         print(selectedItem);
              //       },
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: AdvancedServicesWidget(
                      image: OImages.contractorRequestIcon,
                      title: 'Fix',
                      border: Border.all(
                        width: 1.w,
                        color: selectedItem == 'Fix' ? OColors.primaryColor500 : OColors.whiteColor,
                      ),
                      onTap: () {
                        setState(() {
                          selectedItem = 'Fix';
                          // keyValueMap.clear();
                        });
                        print(selectedItem);
                      },
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Expanded(
                    flex: 10,
                    child: AdvancedServicesWidget(
                      image: OImages.marketIcon,
                      title: 'New',
                      border: Border.all(
                        width: 1.w,
                        color: selectedItem == 'New' ? OColors.primaryColor500 : OColors.whiteColor,
                      ),
                      onTap: () {
                        setState(() {
                          selectedItem = 'New';
                          // keyValueMap.clear();
                        });
                        print(selectedItem);
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 18.h),

              /// Specific Services
            result == null
                ? LoadingWidget(iconColor: OColors.primaryColor500)
                : SizedBox(
              height: 50.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: selectedItem == 'Fix'
                    ? (result.fixList.isEmpty ? 0 : result.fixList.length)
                    : (result.newList.isEmpty ? 0 : result.newList.length),
                separatorBuilder: (context, index) {
                  return SizedBox(width: 14.w);
                },
                itemBuilder: (context, index) {
                  var fixList = result.fixList;
                  var newList = result.newList;

                  /// Check if the list is not empty and index is within bounds
                  if (selectedItem == 'Fix' && fixList.isNotEmpty && index < fixList.length) {
                    int idInSelectedSubServiceInFix = fixList[index].id;
                    String subServiceName = fixList[index].name;
                    return SubServicesWidget(
                      subServiceName: subServiceName,
                      onTap: () {
                        addButtonPressed(subServiceId: idInSelectedSubServiceInFix);
                      },
                      numberOfPieces: keyValueMap.containsKey(idInSelectedSubServiceInFix.toString())
                          ? keyValueMap[idInSelectedSubServiceInFix.toString()]!
                          : '0',
                      onPressed: () {
                        minuseButtonPressed(subServiceId: idInSelectedSubServiceInFix);
                      },
                    );
                  } else if (selectedItem != 'Fix' && newList.isNotEmpty && index < newList.length) {
                    int idInSelectedSubServiceInNew = newList[index].id;
                    String subServiceName = newList[index].name;
                    return SubServicesWidget(
                      subServiceName: subServiceName,
                      onTap: () {
                        addButtonPressed(subServiceId: idInSelectedSubServiceInNew);
                      },
                      numberOfPieces: keyValueMap.containsKey(idInSelectedSubServiceInNew.toString())
                          ? keyValueMap[idInSelectedSubServiceInNew.toString()]!
                          : '0',
                      onPressed: () {
                        minuseButtonPressed(subServiceId: idInSelectedSubServiceInNew);
                      },
                    );
                  } else {
                    return SizedBox(); /// Return an empty widget if the list is empty or index is out of range
                  }
                },
              ),
            ),
            // return GestureDetector(
              //   // onTap: () => setState(() {
              //   //   selectedSpecificService = index;
              //   // }),
              //   onTap: () {
              //     logError('lpk;dnjmafo');
              //     addButtonPressed(subServiceId: selectedItem == 'Fix' ? idInSelectedSubServiceInFix : idInSelectedSubServiceInNew);
              //   },
              //   child: AnimatedContainer(
              //     curve: Curves.easeInOut,
              //     height: 35.h,
              //     width: 97.w,
              //     duration: const Duration(milliseconds: 300),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(16.r),
              //       color: selectedSpecificService == index ? OColors.primaryColor500 : OColors.whiteColor,
              //       border: Border.all(color: OColors.primaryColor500, width: 2.w),
              //       boxShadow: [AppBoxShadows.cardShadowTwo],
              //     ),
              //     child: Center(
              //       child: Text(selectedItem == 'Fix' ? fixList.isEmpty ? '' : fixList[index].name : newList[index].name, style: OStyles.bodyLargeBold.copyWith(color: selectedSpecificService == index ?  OColors.whiteColor : OColors.primaryColor500)),
              //     ),
              //   ),
              // );

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
                  Expanded(child: RememberMeWidget(isChecked: isChecked, onChanged: (p0) => setState(() {isChecked = !isChecked; _selectedImages.clear();}), isRememberMe: false)),
                  Text('I don\'t know the problem', style: OStyles.bodyMediumSemiBold),
                ],
              ),

              /// Make Size
              SizedBox(height: 18.h),

              if (isChecked) ...[
                Stack(
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
                      textStyle: OStyles.bodyMediumSemiBold.copyWith(color: OColors.hintColor),
                      // suffixIcon: ,
                    ),
                    Positioned(
                      bottom: 12.h,
                      right: 12.w,
                      child: InkWellWidget(
                        onTap: () async {
                          final images  = await ODeviceUtils.pickImagesFromGallery();
                          if (images  != null) {
                            setState(() {
                              _selectedImages.addAll(images);
                            });
                          }
                        },
                        child: Image.asset(OImages.imagePicker, fit: BoxFit.scaleDown),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                if(iNeedWrite) ...[
                  Stack(
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
                        textStyle: OStyles.bodyMediumSemiBold.copyWith(color: OColors.hintColor),
                        // suffixIcon: ,
                      ),
                      Positioned(
                        bottom: 12.h,
                        right: 12.w,
                        child: InkWellWidget(
                          onTap: () async {
                            final images  = await ODeviceUtils.pickImagesFromGallery();
                            if (images  != null) {
                              setState(() {
                                _selectedImages.addAll(images);
                              });
                            }
                          },
                          child: Image.asset(OImages.imagePicker, fit: BoxFit.scaleDown),
                        ),
                      ),
                    ],
                  ),
                  /// Make Size
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: () {
                      setState(() => iNeedWrite = !iNeedWrite);
                      logError(iNeedWrite.toString());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Close this field',
                          textAlign: TextAlign.center,
                          style: OStyles.bodyLargeBold.copyWith(color: OColors.primaryColor500),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  GestureDetector(
                    onTap: () {
                      setState(() => iNeedWrite = !iNeedWrite);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Click here to write details',
                          textAlign: TextAlign.center,
                          style: OStyles.bodyLargeBold.copyWith(color: OColors.primaryColor500),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
              if (_selectedImages.isNotEmpty)
                SizedBox(
                  height: 100.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _selectedImages.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 8.w);
                    },
                    itemBuilder: (context, index) {
                      return Image.file(_selectedImages[index], width: 60.w, height: 60.h, fit: BoxFit.cover);
                    },
                  ),
                ),

              if (_selectedImages.isNotEmpty && isChecked)
              /// Make Size
                SizedBox(height: 12.h),

              if (_selectedImages.isNotEmpty && isChecked)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWellWidget(
                      onTap: () {
                        setState(() {
                          _selectedImages.clear();
                        });
                      },
                      child: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: OColors.primaryColor500,
                        child: Icon(Icons.close, color: Colors.white, size: 18.sp),
                      ),
                    ),
                  ],
                ),

              /// Make Size
              SizedBox(height: _selectedImages.isNotEmpty || !isChecked ? 12.h : 24.h),

              ContinueButtonInBottomWidget(
                centerWidget: state is MakeOrderLoadingState ? Center(child: LoadingWidget(iconColor: OColors.whiteColor)) : Text('Continue', style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)),
                onTap: () {
                  List<int> subServiceIdsList = keyValueMap.keys.map((key) => int.parse(key)).toList();
                  List<int> subServiceQuantitiesList = keyValueMap.values.map((value) => int.parse(value)).toList();


                  // selectWarranty == 0 ?
                  // ODeviceUtils.showSnackBar(context: context, message: 'Please Choice Warranty', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning)
                  // : keyValueMap.isEmpty ?
                  // ODeviceUtils.showSnackBar(context: context, message: 'Please Choice Specific Service', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning)
                  //     :
                  isChecked && textInServicesController.text.isEmpty ?
                  ODeviceUtils.showSnackBar(context: context, message: 'Please Click to write details', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning)
                      : state is MakeOrderLoadingState ? null : showLocationBottomSheet(
                    context: context,
                    map: {
                      'category':  widget.category,
                      'warrantyId':  selectWarranty == 0 ? null : selectWarranty,
                      'serviceId':  widget.serviceId,
                      'description':  textInServicesController.text,
                      'subServicesIds': subServiceIdsList,
                      'subServiceQuantities': subServiceQuantitiesList,
                      'unknownProblem': isChecked ? 1 : 0,
                      'isSpace': false,
                      'isSubServicesIds':  true,
                      'isSubServiceQuantities':  true,
                      'isWarrantyId':  true,
                      'isEdit': false,
                    },
                    historyAddressesWidget: widget.addressList == null
                        ? LoadingWidget(iconColor: OColors.primaryColor500)
                        : ListView.builder(
                      itemCount: widget.addressList.length,
                      itemBuilder:(context,index) {
                        return PreviousAddressesWidget(
                          icon: widget.addressList[index].name! == 'home' ? SvgPicture.asset(OImages.homeIcon) : widget.addressList[index].name! == 'work' ? SvgPicture.asset(OImages.workIcon) : widget.addressList[index].name! == 'friend' ? SvgPicture.asset(OImages.friendIcon, width: 32.w, height: 32.h) : SvgPicture.asset(OImages.resturantIcon),
                          addressName: widget.addressList[index].name! == 'home' ? 'Home' : widget.addressList[index].name! == 'work' ? 'Work' : widget.addressList[index].name! == 'friend' ? 'Friend' : 'Other',
                          location: widget.addressList[index].desc ?? '',
                          onTap: () {
                            if(!isMakeOrder) {
                              isMakeOrder = true;
                              technologyCubit.makeOrderFunction(
                                category: widget.category,
                                warrantyId: selectWarranty == 0 ? null : selectWarranty,
                                serviceId: widget.serviceId,
                                description:  textInServicesController.text,
                                subServicesIds: subServiceIdsList,
                                subServiceQuantities: subServiceQuantitiesList,
                                unknownProblem: isChecked ? 1 : 0,
                                isSpace: false,
                                isSubServicesIds: true,
                                isSubServiceQuantities: true,
                                isWarrantyId: true,
                                locationId: widget.addressList[index].id,
                                images: _selectedImages,
                              );
                              context.pop();
                            }
                          },
                          onTapInEdit: () {
                            context.pushNamed(ORoutesName.choiceYourLocationRoute, arguments: {
                              'category':  widget.category,
                              'warrantyId':  selectWarranty == 0 ? null : selectWarranty,
                              'serviceId':  widget.serviceId,
                              'description':  textInServicesController.text,
                              'subServicesIds': subServiceIdsList,
                              'subServiceQuantities': subServiceQuantitiesList ,
                              'unknownProblem': isChecked ? 1 : 0,
                              'isSpace': false,
                              'isSubServicesIds':  true,
                              'isSubServiceQuantities':  true,
                              'isWarrantyId':  true,
                              'locationId':  widget.addressList[index].id,
                              'isEdit': true,
                            });
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
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
