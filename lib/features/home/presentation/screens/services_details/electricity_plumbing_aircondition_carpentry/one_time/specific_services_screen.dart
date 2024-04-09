import 'package:lottie/lottie.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class SpecificServicesScreen extends StatefulWidget {
  const SpecificServicesScreen({super.key});

  @override
  State<SpecificServicesScreen> createState() => _SpecificServicesScreenState();
}

class _SpecificServicesScreenState extends State<SpecificServicesScreen> {
  int selectedSpecificService = -1;
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

            /// Divider
            Divider(color: OColors.greyScale200, thickness: 1.w),

            Text('Specific services', style: OStyles.h5Bold),

            /// Make Size
            SizedBox(height: 23.h),

            SizedBox(
              height: 38.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: OConstants.servicesTexts1.length,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 14.w);
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => setState(() {
                      selectedSpecificService = index;
                      isClicked = !isClicked;
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
                        child: Text(OConstants.servicesTexts1[index], style: OStyles.bodyLargeBold.copyWith(color: selectedSpecificService == index ?  OColors.whiteColor : OColors.primaryColor500)),
                      ),
                    ),
                  );
                },
              ),
            ),

            /// Make Size
            SizedBox(height: 18.h),

            SizedBox(
              height: 38.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: OConstants.servicesTexts1.length,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 14.w);
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => setState(() {
                      selectedSpecificService = index;
                      isClicked = !isClicked;
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
                        child: Text(OConstants.servicesTexts1[index], style: OStyles.bodyLargeBold.copyWith(color: selectedSpecificService == index ?  OColors.whiteColor : OColors.primaryColor500)),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ********************************* \\
            /// Make Size
            SizedBox(height: 23.h),

            /// Divider
            Divider(color: OColors.greyScale200, thickness: 1.w),

            Text('Specific services', style: OStyles.h5Bold),

            /// Make Size
            SizedBox(height: 23.h),

            SizedBox(
              height: 38.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: OConstants.servicesTexts1.length,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 14.w);
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => setState(() {
                      selectedSpecificService = index;
                      isClicked = !isClicked;
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
                        child: Text(OConstants.servicesTexts1[index], style: OStyles.bodyLargeBold.copyWith(color: selectedSpecificService == index ?  OColors.whiteColor : OColors.primaryColor500)),
                      ),
                    ),
                  );
                },
              ),
            ),

            /// Make Size
            SizedBox(height: 18.h),

            SizedBox(
              height: 38.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: OConstants.servicesTexts1.length,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 14.w);
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => setState(() {
                      selectedSpecificService = index;
                      isClicked = !isClicked;
                    }),                    child: AnimatedContainer(
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
                        child: Text(OConstants.servicesTexts1[index], style: OStyles.bodyLargeBold.copyWith(color: selectedSpecificService == index ?  OColors.whiteColor : OColors.primaryColor500)),
                      ),
                    ),
                  );
                },
              ),
            ),

            const Spacer(),

            isClicked ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(OImages.pressHere),
                  ],
                ),

                InkWellWidget(
                  onTap: () {
                    showDialog(
                      context: context, // You need to pass the BuildContext here
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Your choices', style: OStyles.h5Bold.copyWith(fontSize: 24.sp)),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Row(
                                  children: [
                                    Text('Cleaning: ', style: OStyles.bodyLargeBold.copyWith(color: OColors.primaryColor500)),
                                    Text('3 times', style: OStyles.bodyLargeBold),
                                  ],
                                ),
                                /// Make Size
                                SizedBox(height: 14.h),
                                Row(
                                  children: [
                                    Text('Repairing: ', style: OStyles.bodyLargeBold.copyWith(color: OColors.primaryColor500)),
                                    Text('6 times', style: OStyles.bodyLargeBold),
                                  ],
                                ),
                                /// Make Size
                                SizedBox(height: 14.h),
                                Row(
                                  children: [
                                    Text('Laundry: ', style: OStyles.bodyLargeBold.copyWith(color: OColors.primaryColor500)),
                                    Text('3 times', style: OStyles.bodyLargeBold),
                                  ],
                                ),
                                /// Make Size
                                SizedBox(height: 14.h),
                                Row(
                                  children: [
                                    Text('Painting: ', style: OStyles.bodyLargeBold.copyWith(color: OColors.primaryColor500)),
                                    Text('6 times', style: OStyles.bodyLargeBold),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Ok', style: OStyles.h5Bold),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Show All Your Specific Services', textAlign: TextAlign.center, style: OStyles.bodyLargeBold.copyWith(color: OColors.primaryColor500)),
                    ],
                  ),
                ),
              ],
            ) : Container(),
          ],
        ),
      ),
      bottomNavigationBar: ContinueButtonInBottomWidget(onTap: () {}),
    );
  }
}
