import 'package:osta_user_app/common/widgets/what_happened_with_us/what_happened_with_us_widget.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController spaceController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController toWriteController = TextEditingController();
  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode spaceFocusNode = FocusNode();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode toWriteFocusNode = FocusNode();
  bool isFullNameFieldFocused = false;
  bool isSpaceFieldFocused = false;
  bool isPhoneFocused = false;
  bool isToWriteFocused = false;

  bool isRemoteVisible = true;

  String toggleBetweenTwoItems = 'remote';

  @override
  void initState() {
    super.initState();
    /// Add listener to focus node
    fullNameFocusNode.addListener(() => setState(() => isFullNameFieldFocused = fullNameFocusNode.hasFocus));
    spaceFocusNode.addListener(() => setState(() => isSpaceFieldFocused = spaceFocusNode.hasFocus));
    phoneFocusNode.addListener(() => setState(() => isPhoneFocused = phoneFocusNode.hasFocus));
    toWriteFocusNode.addListener(() => setState(() => isToWriteFocused = toWriteFocusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    fullNameFocusNode.dispose();
    spaceFocusNode.dispose();
    phoneFocusNode.dispose();
    fullNameController.dispose();
    spaceController.dispose();
    phoneController.dispose();
    toWriteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.whiteColor,
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h, bottom: 0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// App Bar
            AppBarWidget(
              leading: InkWellWidget(onTap: () => context.pop(), child: const Icon((Icons.arrow_back))),
              title: '',
              actions: Container(),
              widthOfText: 282.w,
            ),
            /// Make Size
            SizedBox(height: 23.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Order details', style: OStyles.bodyXLargeSemiBold.copyWith(color: OColors.primaryColor500)),
              ],
            ),
            /// Make Size
            SizedBox(height: 12.h),

            /// Divider
            Container(width: double.infinity, height: 4.h, decoration: BoxDecoration(color: OColors.primaryColor500, borderRadius: BorderRadius.circular(100.r))),

            /// Make Size
            SizedBox(height: 18.h),

            Expanded(child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WhatHappenedWithUsWidget(),

                  /// Make Size
                  SizedBox(height: 18.h),

                  /// Divider
                  Container(
                    width: double.infinity,
                    color: OColors.greyScale200,
                    height: 1.h,
                  ),

                  /// Make Size
                  SizedBox(height: 36.h),

                  Row(
                    children: [
                      /// Full Name
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: fullNameController,
                          textInputType: TextInputType.name,
                          focusNode: fullNameFocusNode,
                          hintText: 'Full Name',
                          hintColor: isFullNameFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
                          fillColor: isFullNameFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
                          borderSide: isFullNameFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                          obscureText: false,
                        ),
                      ),
                      /// Make Size
                      SizedBox(width: 24.w),
                      /// Full Name
                      Expanded(
                        child: TextFormFieldWidget(
                          controller: spaceController,
                          textInputType: TextInputType.number,
                          focusNode: spaceFocusNode,
                          hintText: 'The space M',
                          hintColor: isSpaceFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
                          fillColor: isSpaceFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
                          borderSide: isSpaceFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                          obscureText: false,
                        ),
                      ),
                    ],
                  ),

                  /// Make Size
                  SizedBox(height: 23.h),

                  /// Phone Number
                  TextFormFieldWidget(
                    controller: phoneController,
                    textInputType: TextInputType.phone,
                    focusNode: phoneFocusNode,
                    hintText: 'Phone Number',
                    hintColor: isPhoneFocused ? OColors.primaryColor500 : OColors.greyScale500,
                    fillColor: isPhoneFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
                    borderSide: isPhoneFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                    obscureText: false,
                  ),

                  /// Make Size
                  SizedBox(height: 32.h),

                  Text('Preview preference', style: OStyles.h5Bold),

                  /// Make Size
                  SizedBox(height: 25.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              toggleBetweenTwoItems = 'remote';
                            });
                          },
                          child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          // width: 161.w,
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                          decoration: BoxDecoration(
                            color: OColors.whiteColor,
                            boxShadow: [AppBoxShadows.cardShadowTwo],
                            borderRadius: BorderRadius.circular(16.r),
                            border: toggleBetweenTwoItems == 'remote'
                                ? Border.all(
                              color: OColors.primaryColor500,
                              width: 3.w,
                            )
                                : null,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(OImages.remoteIcon),
                              SizedBox(width: 20.w),
                              Text('Remote', style: OStyles.bodyXLargeSemiBold),
                            ],
                          ),
                        ),
                        ),
                      ),
                      const Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                        flex: 3,
                        child: InkWell(
                        onTap: () {
                          setState(() {
                            toggleBetweenTwoItems = 'in fact';
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          // width: 161.w,
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                          decoration: BoxDecoration(
                            color: OColors.whiteColor,
                            boxShadow: [AppBoxShadows.cardShadowTwo],
                            borderRadius: BorderRadius.circular(16.r),
                            border: toggleBetweenTwoItems == 'in fact'
                                ? Border.all(
                              color: OColors.primaryColor500,
                              width: 3.w,
                            )
                                : null,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(OImages.inFactIcon),
                              SizedBox(width: 20.w),
                              Text('In Fact', style: OStyles.bodyXLargeSemiBold),
                            ],
                          ),
                        ),
                      ),
                      ),
                    ],
                  ),

                  /// Make Size
                  SizedBox(height: 32.h),

                  TextFormFieldWidget(
                    controller: toWriteController,
                    textInputType: TextInputType.text,
                    focusNode: toWriteFocusNode,
                    hintText: 'To write more details',
                    maxLines: 1,
                    hintColor: isToWriteFocused ? OColors.primaryColor500 : OColors.hintColor,
                    fillColor: isToWriteFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
                    borderSide: isToWriteFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                    obscureText: false,
                    textAlign: TextAlign.center,
                  ),

                  ContinueButtonInBottomWidget(
                    centerWidget: Text('Continue', style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)),
                    onTap: () {},
                  ),
                ],
              ),
            ),),
          ],
        ),
      ),
    );
  }
}
