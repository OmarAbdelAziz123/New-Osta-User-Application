import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/common/widgets/bottom_sheet/show_location_bottom_sheet.dart';
import 'package:osta_user_app/common/widgets/checkbox/remember_me_widget.dart';
import 'package:osta_user_app/common/widgets/what_happened_with_us/what_happened_with_us_widget.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/features/home/presentation/widgets/home/electricity_widgets/sub_services_widget.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class OneTimeScreen extends StatefulWidget {
  OneTimeScreen({super.key, required this.subServicesList, required this.serviceId, required this.category});

  var subServicesList;
  int serviceId;
  String category;

  @override
  State<OneTimeScreen> createState() => _OneTimeScreenState();
}

class _OneTimeScreenState extends State<OneTimeScreen> {
  int selectedIndex = -1;
  int selectedSpace = -1;
  int selectedDays = 0;

  TextEditingController textInServicesController = TextEditingController();
  final FocusNode textInServicesFocusNode = FocusNode();
  bool isTextInServicesFieldFocused = false;
  bool iNeedWrite = false;
  bool isChecked = false;

  String? selectedSpaceToPutInApi;

  int indexInSelectedSubService = 0;

  Map<String, String> keyValueMap = {};

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
        count++;
        keyValueMap[key] = count.toString();
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

                    // return GestureDetector(
                    //   onTap: () => setState(() {
                    //     selectedIndex = index;
                    //     idInSelectedSubService = widget.subServicesList[index].id;
                    //     subServiceName = widget.subServicesList[index].name;
                    //     addButtonPressed(subServiceId: idInSelectedSubService);
                    //   }),
                    //   child: AnimatedContainer(
                    //     curve: Curves.easeInOut,
                    //     height: 90.h,
                    //     width: 120.w,
                    //     duration: const Duration(milliseconds: 300),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(16.r),
                    //       color: OColors.whiteColor,
                    //       // boxShadow: [AppBoxShadows.cardShadowTwo],
                    //       border: Border.all(color: selectedIndex == index ? OColors.primaryColor500 : OColors.whiteColor, width: selectedIndex == index ? 3.w : 0),
                    //     ),
                    //     child: Center(
                    //       child: Text(widget.subServicesList[index].name, style: OStyles.bodyLargeBold.copyWith(color:OColors.primaryColor500)),
                    //     ),
                    //   ),
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

                  selectedSpace == 0 ?
                  ODeviceUtils.showSnackBar(context: context, message: 'Please Choice Warranty', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning)
                      : keyValueMap.isEmpty ?
                  ODeviceUtils.showSnackBar(context: context, message: 'Please Choice Specific Service', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning)
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
                  : showLocationBottomSheet(
                    context: context,
                    map: {
                      'category':  widget.category,
                      'warrantyId':  null,
                      'serviceId':  widget.serviceId,
                      'description':  textInServicesController.text,
                      'subServicesIds': subServiceIdsList,
                      'subServiceQuantities': subServiceQuantitiesList ,
                      'unknownProblem': isChecked ? 1 : 0,
                      'isSpace': true,
                      'isSubServicesIds':  true,
                      'isSubServiceQuantities':  true,
                      'isWarrantyId':  false,
                    }
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

