import 'package:osta_user_app/utils/constants/exports.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  PageController? controller;

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// OnBoarding Body
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: OConstants.onBoardingImage.length,
              onPageChanged: (int index) => setState(() => currentIndex = index),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    /// Make Space
                    SizedBox(height: 22.h),

                    /// OnBoarding Logos
                    Padding(
                      padding: EdgeInsets.only(left: 36.w, right: 36.w, top: 82.h),
                      child: SvgPicture.asset(OConstants.onBoardingImage[index], height: 356.h, width: 270.w),
                    ),

                    /// OnBoarding Texts
                    SizedBox(
                      height: 250.h,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            width: 380.w,
                            margin: EdgeInsets.only(left: 24.w, right: 24.w, top: 48.h),
                            child: Text(
                              OConstants.onBoardingTexts[index],
                              style: OStyles.h2Bold,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          /// Dot Generator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                OConstants.onBoardingTexts.length,
                (index) => ODeviceUtils.buildDotWidget(index, currentIndex, context, BoxDecoration(gradient: AppGradients.purpleGradient, borderRadius: BorderRadius.circular(100.r))),
              ),
          ),

          /// Make Space
          SizedBox(height: 50.h),

          /// Next Button
          MainButtonWidget(
            centerWidgetInButton: Text(currentIndex == OConstants.onBoardingImage.length-1 ? 'Continue' : 'Next', style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)),
            onTap: () {
              if(currentIndex == OConstants.onBoardingImage.length - 1) {
                /// Navigate to Check Screen
                context.pushReplacementNamed(ORoutesName.loginAccountRoute);
              }
              controller!.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
            },
            margin: EdgeInsets.only(bottom: 48.h, left: 24.w, right: 24.w),
            buttonColor: OColors.primaryColor500,
            boxShadow: [AppBoxShadows.buttonShadowOne],
          ),
        ],
      ),
    );
  }
}


