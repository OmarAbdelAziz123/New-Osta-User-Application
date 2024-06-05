import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/common/widgets/bottom_sheet/show_location_bottom_sheet.dart';
import 'package:osta_user_app/common/widgets/checkbox/remember_me_widget.dart';
import 'package:osta_user_app/common/widgets/what_happened_with_us/what_happened_with_us_widget.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class OneTimeScreenInHomeApp extends StatefulWidget {
  OneTimeScreenInHomeApp({super.key, required this.serviceId, required this.category, required this.subServicesList});

  var subServicesList;
  final int serviceId;
  final String category;

  @override
  State<OneTimeScreenInHomeApp> createState() => _OneTimeScreenInHomeAppState();
}

class _OneTimeScreenInHomeAppState extends State<OneTimeScreenInHomeApp> {
  int selectedIndex = -1;
  int selectedSpace = 0;
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
                          onTap: () => setState(() {
                            selectedSpace = index + 1;
                            print(selectedSpace);
                          }),
                          child: AnimatedContainer(
                            curve: Curves.easeInOut,
                            height: 35.h,
                            width: 97.w,
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: selectedSpace == index + 1 ? OColors.primaryColor500 : OColors.whiteColor,
                              border: Border.all(color: OColors.primaryColor500, width: 2.w),
                            ),
                            child: Center(
                              child: Text(OConstants.daysList[index], style: OStyles.bodyLargeBold.copyWith(color: selectedSpace == index + 1 ?  OColors.whiteColor : OColors.primaryColor500)),
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AdvancedServicesWidget(
                    image: OImages.contractorRequestIcon,
                    title: 'Fix',
                    border: Border.all(
                      width: 1.w,
                      color: selectedItem == 'Fix' ? OColors.primaryColor500 : OColors.whiteColor,
                    ),
                    onTap: () {
                      setState(() {
                        selectedItem = 'Fix';
                      });
                      print(selectedItem);
                    },
                  ),
                  AdvancedServicesWidget(
                    image: OImages.marketIcon,
                    title: 'New',
                    border: Border.all(
                      width: 1.w,
                      color: selectedItem == 'New' ? OColors.primaryColor500 : OColors.whiteColor,
                    ),
                    onTap: () {
                      setState(() {
                        selectedItem = 'New';
                      });
                      print(selectedItem);
                    },
                  ),
                ],
              ),

              SizedBox(height: 18.h),

              /// Specific Services
              result == null
                  ? LoadingWidget(iconColor: OColors.primaryColor500)
                  : SizedBox(
                height: 38.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: selectedItem == 'Fix' ? result.fixList.isEmpty ? 0 : result.fixList.length :  result.newList.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 14.w);
                  },
                  itemBuilder: (context, index) {
                    var fixList = result.fixList;
                    var newList = result.newList;

                    return GestureDetector(
                      onTap: () => setState(() => selectedSpecificService = index),
                      child: AnimatedContainer(
                        curve: Curves.easeInOut,
                        height: 35.h,
                        width: 97.w,
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: selectedSpecificService == index ? OColors.primaryColor500 : OColors.whiteColor,
                          border: Border.all(color: OColors.primaryColor500, width: 2.w),
                          boxShadow: [AppBoxShadows.cardShadowTwo],
                        ),
                        child: Center(
                          child: Text(selectedItem == 'Fix' ? fixList.isEmpty ? '' : fixList[index].name : newList[index].name, style: OStyles.bodyLargeBold.copyWith(color: selectedSpecificService == index ?  OColors.whiteColor : OColors.primaryColor500)),
                        ),
                      ),
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

                  technologyCubit.makeOrderFunction(
                    category: widget.category,
                    warrantyId: selectedSpace == 0 ? null : selectedSpace,
                    serviceId: widget.serviceId,
                    locationId: 2,
                    description: textInServicesController.text,
                    subServicesIds: subServiceIdsList,
                    subServiceQuantities: subServiceQuantitiesList,
                    unknownProblem: isChecked ? 1 : 0,
                    isSpace: false,
                    isSubServicesIds: true,
                    isSubServiceQuantities: true,
                    isWarrantyId: true,
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
  void showLocationBottomSheet({required BuildContext context, required Map map}) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return ShowLocationBottomSheet(map: map);
      },
    );
  }
}
