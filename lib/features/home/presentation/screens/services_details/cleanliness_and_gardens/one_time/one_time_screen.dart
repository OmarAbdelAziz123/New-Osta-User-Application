import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/common/widgets/bottom_sheet/show_location_bottom_sheet.dart';
import 'package:osta_user_app/common/widgets/checkbox/remember_me_widget.dart';
import 'package:osta_user_app/common/widgets/what_happened_with_us/what_happened_with_us_widget.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/features/home/models/address/get_all_addresses_model.dart';
import 'package:osta_user_app/features/home/presentation/widgets/home/cleanliness_and_gardens_widgets/sub_services_in_clean_widget.dart';
import 'package:osta_user_app/features/home/presentation/widgets/home/electricity_widgets/sub_services_widget.dart';
import 'package:osta_user_app/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';

class OneTimeScreen extends StatefulWidget {
  OneTimeScreen({super.key, required this.subServicesList, required this.addressList, required this.serviceId, required this.category});

  var subServicesList;
  var addressList;
  int serviceId;
  String category;

  @override
  State<OneTimeScreen> createState() => _OneTimeScreenState();
}

class _OneTimeScreenState extends State<OneTimeScreen> {
  int selectedIndex = -1;
  int selectedSpace = -1;
  int selectedDays = 0;

  bool isMakeOrder = false;

  TextEditingController textInServicesController = TextEditingController();
  final FocusNode textInServicesFocusNode = FocusNode();
  bool isTextInServicesFieldFocused = false;
  bool iNeedWrite = false;
  bool isChecked = false;

  String? selectedSpaceToPutInApi;

  int indexInSelectedSubService = 0;

  Map<String, String> keyValueMap = {};
  List<File> _selectedImages = [];

  // int numberOfSelectedFromOne = 1;

  // Set<int> selectedIndices = {};

  void addButtonPressed({required int subServiceId}) {
    // Generate a key based on the subServiceId
    String key = subServiceId.toString();

    setState(() {
      // Check if the key exists in the map
      if (keyValueMap.containsKey(key)) {
        // If the key exists, increment the count
        int count = int.parse(keyValueMap[key]!);
        if(count < 1) {
          count++;
          keyValueMap[key] = count.toString();
        }

      } else {
        // If the key does not exist, start with count 0
        keyValueMap[key] = '1';
      }

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
    List spaces = [
      '60 - 80',
      '80 - 90',
      '100 - 200',
      '200 - 300',
      '300 - 400',
      '400 - 500',
      '500 - 600',
      '600 - 700',
    ];

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
        var subServiceCubit = HomeCubit.get(context);
        int? idInSelectedSubService;
        String? subServiceName;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WhatHappenedWithUsWidget(),

              /// Make Size
              SizedBox(height: 23.h),

              /// Divider
              Divider(color: OColors.greyScale200, thickness: 1.w),

              /// Make Size
              SizedBox(height: 14.h),

              /// Row (Services type - See All)
              RowSeeAllWidget(mainText: 'Service Type', seeAllText: 'See All', onTap: () => context.pushNamed(ORoutesName.serviceTypeRoute)),

              /// Make Size
              SizedBox(height: 16.h),

              /// Services Type
              widget.subServicesList == null
                  ? LoadingWidget(iconColor: OColors.primaryColor500)
                  : SizedBox(
                height: 90.h,
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
                    // return SubServicesInCleanWidget(
                    //   subServiceName: widget.subServicesList[index].name, // Replace with your list item
                    //   isSelected: selectedIndex == index,
                    //   onTap: () {
                    //     setState(() {
                    //       selectedIndex = index;
                    //     });
                    //   },
                    //   numberOfPieces: '0', // Replace with your logic
                    //   onPressed: () {
                    //     // Your onPressed logic
                    //   },
                    // );

                  },
                ),
              ),

              /// Make Size
              // SizedBox(height: 29.h),

              /// Row (Space - See All)
              RowSeeAllWidget(mainText: 'Space', seeAllText: 'See All', onTap: () => context.pushNamed(ORoutesName.spaceRoute)),

              /// Make Size
              SizedBox(height: 18.h),

              /// Spaces
              SizedBox(
                height: 39.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: spaces.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 14.w);
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => setState(() {
                        selectedSpace = index + 1;
                        selectedSpaceToPutInApi = spaces[index];
                      }),
                      child: AnimatedContainer(
                        curve: Curves.easeInOut,
                        height: 35.h,
                        duration: const Duration(milliseconds: 300),
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: OColors.whiteColor,
                          boxShadow: [AppBoxShadows.cardShadowTwo],
                          border: Border.all(color: selectedSpace == index + 1 ? OColors.primaryColor500 : OColors.whiteColor, width: selectedSpace == index + 1 ? 3.w : 0),
                        ),
                        child: Center(
                          child: Text(spaces[index], style: OStyles.bodyLargeBold),
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// Make Size
              SizedBox(height: 34.h),

              /// Divider
              Divider(color: OColors.greyScale200, thickness: 1.w),

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
                ]
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

                  selectedSpace == -1 ?
                  ODeviceUtils.showSnackBar(context: context, message: 'Please Choice Space', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning)
                  //     :
                  // keyValueMap.isEmpty ?
                  // ODeviceUtils.showSnackBar(context: context, message: 'Please Choice Specific Service', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning)
                  //     : context.pushNamed(ORoutesName.choiceYourLocationRoute, arguments: {
                  //   'category':  widget.category,
                  //   'warrantyId':  null,
                  //   'serviceId':  widget.serviceId,
                  //   'description':  textInServicesController.text,
                  //   'subServicesIds': subServiceIdsList,
                  //   'subServiceQuantities': subServiceQuantitiesList ,
                  //   'unknownProblem': isChecked ? 1 : 0,
                  //   'isSpace': true,
                  //   'isSubServicesIds':  true,
                  //   'isSubServiceQuantities':  true,
                  //   'isWarrantyId':  false,
                  // });
                   : isChecked && textInServicesController.text.isEmpty ?
                  ODeviceUtils.showSnackBar(context: context, message: 'Please Click to write details', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning)
                    : state is MakeOrderLoadingState ? null : showLocationBottomSheet(
                    context: context,
                    map: {
                      'category':  widget.category,
                      'warrantyId':  null,
                      'serviceId':  widget.serviceId,
                      'description':  textInServicesController.text,
                      'subServicesIds': subServiceIdsList,
                      'subServiceQuantities': subServiceQuantitiesList ,
                      'unknownProblem': isChecked ? 1 : 0,
                      'space': selectedSpace.toString(),
                      'isSpace': true,
                      'isSubServicesIds':  true,
                      'isSubServiceQuantities':  true,
                      'isWarrantyId':  false,
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
                              subServiceCubit.makeOrderFunction(
                                category: widget.category,
                                warrantyId: null,
                                serviceId: widget.serviceId,
                                description:  textInServicesController.text,
                                subServicesIds: subServiceIdsList,
                                subServiceQuantities: subServiceQuantitiesList,
                                unknownProblem: isChecked ? 1 : 0,
                                space: selectedSpace.toString(),
                                isSpace: true,
                                isSubServicesIds: true,
                                isSubServiceQuantities: true,
                                isWarrantyId: false,
                                locationId: widget.addressList[index].id,
                                images: _selectedImages,
                              );
                              context.pop();
                            }
                          },
                          onTapInEdit: () {
                            context.pushNamed(ORoutesName.choiceYourLocationRoute, arguments: {
                              'category':  widget.category,
                              'warrantyId':  null,
                              'serviceId':  widget.serviceId,
                              'description':  textInServicesController.text,
                              'subServicesIds': subServiceIdsList,
                              'subServiceQuantities': subServiceQuantitiesList ,
                              'unknownProblem': isChecked ? 1 : 0,
                              'space': selectedSpace.toString(),
                              'isSpace': true,
                              'isSubServicesIds':  true,
                              'isSubServiceQuantities':  true,
                              'isWarrantyId':  false,
                              'locationId':  widget.addressList[index].id,
                              'isEdit': true,
                            });
                          },
                        );
                      },
                    ),
                  );

                  // subServiceCubit.makeOrderFunction(
                  //   category: widget.category,
                  //   serviceId: widget.serviceId,
                  //   locationId: 2,
                  //   description: textInServicesController.text,
                  //   subServicesIds: subServiceIdsList,
                  //   subServiceQuantities: subServiceQuantitiesList,
                  //   space: selectedSpaceToPutInApi,
                  //   unknownProblem: isChecked ? 1 : 0,
                  //   isSpace: true,
                  //   isSubServicesIds: false,
                  //   isSubServiceQuantities: false,
                  //   isWarrantyId: true,
                  // );
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

