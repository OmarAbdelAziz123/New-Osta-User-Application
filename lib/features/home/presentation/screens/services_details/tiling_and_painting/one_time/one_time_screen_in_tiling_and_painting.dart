import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/common/widgets/bottom_sheet/show_location_bottom_sheet.dart';
import 'package:osta_user_app/common/widgets/checkbox/remember_me_widget.dart';
import 'package:osta_user_app/common/widgets/what_happened_with_us/what_happened_with_us_widget.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class OneTimeScreenInTilingAndPainting extends StatefulWidget {
  OneTimeScreenInTilingAndPainting({super.key, required this.subServicesList, required this.serviceId, required this.category});

  var subServicesList;
  int serviceId;
  String category;

  @override
  State<OneTimeScreenInTilingAndPainting> createState() => _OneTimeScreenInTilingAndPaintingState();
}

class _OneTimeScreenInTilingAndPaintingState extends State<OneTimeScreenInTilingAndPainting> {
  int selectedIndex = -1;
  int selectedSpace = -1;
  int selectedSpecificService = -1;
  int selectedDays = 0;

  TextEditingController textInServicesController = TextEditingController();
  final FocusNode textInServicesFocusNode = FocusNode();
  bool isTextInServicesFieldFocused = false;
  bool iNeedWrite = false;
  bool isChecked = false;

  bool isExtended = false;
  bool isSpecificService = false;

  int indexInSelectedSubService = 0;

  Map<String, String> keyValueMap = {};
  String? selectedSpaceToPutInApi;


  int numberOfSelectedFromOne = 1;

  Set<int> selectedIndices = {};

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
        var subServiceCubit = HomeCubit.get(context);
        int? idInSelectedSubService;
        String? subServiceName;

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
                          onTap: () => setState(() => selectedSpace = index+1),
                          child: AnimatedContainer(
                            curve: Curves.easeInOut,
                            height: 35.h,
                            width: 97.w,
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: selectedSpace == index+1 ? OColors.primaryColor500 : OColors.whiteColor,
                              border: Border.all(color: OColors.primaryColor500, width: 2.w),
                            ),
                            child: Center(
                              child: Text(OConstants.daysList[index], style: OStyles.bodyLargeBold.copyWith(color: selectedSpace == index+1 ?  OColors.whiteColor : OColors.primaryColor500)),
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
              RowSeeAllWidget(mainText: 'Space', seeAllText: 'See All', onTap: () => context.pushNamed(ORoutesName.specificServicesRoute)),

              /// Make Size
              SizedBox(height: 18.h),

              /// Specific Services
              SizedBox(
                height: 38.h,
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
                        selectedSpecificService = index;
                        selectedSpaceToPutInApi = spaces[index];
                      }),
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
                          child: Text(spaces[index], style: OStyles.bodyLargeBold.copyWith(color: selectedSpecificService == index ?  OColors.whiteColor : OColors.primaryColor500)),
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
                  selectedSpace == 0 ?
                  ODeviceUtils.showSnackBar(context: context, message: 'Please Choice Warranty', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning)
                  //     :  context.pushNamed(ORoutesName.choiceYourLocationRoute, arguments: {
                  //   'category':  widget.category,
                  //   'warrantyId':  selectedSpace,
                  //   'serviceId':  widget.serviceId,
                  //   'description':  textInServicesController.text,
                  //   'subServicesIds': [],
                  //   'subServiceQuantities': [] ,
                  //   'unknownProblem': isChecked ? 1 : 0,
                  //   'space': selectedSpecificService.toString(),
                  //   'isSpace': true,
                  //   'isSubServicesIds':  false,
                  //   'isSubServiceQuantities':  false,
                  //   'isWarrantyId':  true,
                  // });
                      : showLocationBottomSheet(
                      context: context,
                      map: {
                        'category':  widget.category,
                        'warrantyId':  selectedSpace,
                        'serviceId':  widget.serviceId,
                        'description':  textInServicesController.text,
                        'subServicesIds': [],
                        'subServiceQuantities': [] ,
                        'unknownProblem': isChecked ? 1 : 0,
                        'space': selectedSpecificService.toString(),
                        'isSpace': true,
                        'isSubServicesIds':  false,
                        'isSubServiceQuantities':  false,
                        'isWarrantyId':  true,
                      }
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
