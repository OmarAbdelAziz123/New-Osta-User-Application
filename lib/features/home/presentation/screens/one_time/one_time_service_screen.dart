import 'package:osta_user_app/common/widgets/what_happened_with_us/what_happened_with_us_widget.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class OneTimeServiceInHomeScreen extends StatelessWidget {
  const OneTimeServiceInHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.greyScale50,
      // backgroundColor: const Color(0xfffdfdfd),
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h, bottom: 0.h),
        child: Column(
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

            Text('One time service', style: OStyles.bodyXLargeSemiBold.copyWith(color: OColors.primaryColor500)),
            /// Make Size
            SizedBox(height: 12.h),

            /// Divider
            Container(width: double.infinity, height: 4.h, decoration: BoxDecoration(color: OColors.primaryColor500, borderRadius: BorderRadius.circular(100.r))),

            /// Make Size
            SizedBox(height: 18.h),

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

            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: OColors.greyScale50,
                  boxShadow: [AppBoxShadows.cardShadowFour]
              ),
              child: Center(child: Text('Sections', style: OStyles.bodyMediumRegular.copyWith(color: const Color(0xff757575)))),
            ),

            /// Make Size
            SizedBox(height: 23.h),

            Expanded(
                child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemCount: OConstants.contractorImages.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: ODeviceUtils.getScreenWidth(context) / 20,
                crossAxisSpacing: ODeviceUtils.getScreenHeight(context) / 100,
                childAspectRatio: ODeviceUtils.getScreenWidth(context) / 180,
              ),
              itemBuilder: (context, index) {
                return AdvancedServicesWidget(
                  image: OConstants.contractorImages[index],
                  title: OConstants.contractorTexts[index],
                  onTap: () {
                    context.pushNamed(ORoutesName.orderDetailsRoute);
                  },
                );
              },
            )),

            ContinueButtonInBottomWidget(
              centerWidget: Text('Continue', style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)),
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
