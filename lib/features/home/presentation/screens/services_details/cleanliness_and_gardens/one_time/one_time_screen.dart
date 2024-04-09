import 'package:osta_user_app/common/widgets/checkbox/remember_me_widget.dart';
import 'package:osta_user_app/common/widgets/what_happened_with_us/what_happened_with_us_widget.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class OneTimeScreen extends StatefulWidget {
  const OneTimeScreen({super.key});

  @override
  State<OneTimeScreen> createState() => _OneTimeScreenState();
}

class _OneTimeScreenState extends State<OneTimeScreen> {
  int selectedIndex = -1;
  int selectedSpace = -1;

  TextEditingController textInServicesController = TextEditingController();
  final FocusNode textInServicesFocusNode = FocusNode();
  bool isTextInServicesFieldFocused = false;
  bool iNeedWrite = false;

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
          SizedBox(
            height: 90.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              separatorBuilder: (context, index) {
                return SizedBox(width: 14.w);
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => setState(() => selectedIndex = index),
                  child: AnimatedContainer(
                    curve: Curves.easeInOut,
                    height: 90.h,
                    width: 120.w,
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: OColors.whiteColor,
                      boxShadow: [AppBoxShadows.cardShadowTwo],
                      border: Border.all(color: selectedIndex == index ? OColors.primaryColor500 : OColors.whiteColor, width: selectedIndex == index ? 3.w : 0),
                    ),
                  ),
                );
              },
            ),
          ),

          /// Make Size
          SizedBox(height: 29.h),

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
              itemCount: 5,
              separatorBuilder: (context, index) {
                return SizedBox(width: 14.w);
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => setState(() => selectedSpace = index),
                  child: AnimatedContainer(
                    curve: Curves.easeInOut,
                    height: 35.h,
                    width: 97.w,
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: OColors.whiteColor,
                      boxShadow: [AppBoxShadows.cardShadowTwo],
                      border: Border.all(color: selectedSpace == index ? OColors.primaryColor500 : OColors.whiteColor, width: selectedSpace == index ? 3.w : 0),
                    ),
                    child: Center(
                      child: Text('200 - 300 M', style: OStyles.bodyLargeBold),
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
              Expanded(child: RememberMeWidget(isChecked: true, onChanged: (p0) {}, isRememberMe: false)),
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
          SizedBox(height: 26.h),
        ],
      ),
    );
  }
}

