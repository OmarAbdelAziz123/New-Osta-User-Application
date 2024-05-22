import 'package:osta_user_app/common/widgets/what_happened_with_us/what_happened_with_us_widget.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class OneTimeServiceInHomeScreen extends StatelessWidget {
  const OneTimeServiceInHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h, bottom: 105.h),
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
              SizedBox(height: 23.h),

              /// Divider
              Divider(color: OColors.greyScale200, thickness: 1.w),

              /// Make Size
              SizedBox(height: 14.h),

              Container(
                width: double.infinity,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: OColors.greyScale50,
                  boxShadow: [AppBoxShadows.cardShadowFour]
                ),
                child: Center(child: Text('Sections', style: OStyles.bodyMediumRegular)),
              ),

              /// Make Size
              SizedBox(height: 23.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AdvancedServicesWidget(
                      image: OImages.svg, title: 'Contractor request', onTap: () => context.pushNamed(ORoutesName.orderDetailsRoute)),
                  AdvancedServicesWidget(
                      image: OImages.marketIcon, title: 'Market'),
                ],
              ),

              /// Make Size
              SizedBox(height: 18.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AdvancedServicesWidget(image: OImages.contractorRequestIcon, title: 'Contractor request', onTap: () => context.pushNamed(ORoutesName.orderDetailsRoute)),
                  AdvancedServicesWidget(image: OImages.waleetIcon, title: 'Market'),
                ],
              ),

              /// Make Size
              SizedBox(height: 18.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AdvancedServicesWidget(image: OImages.marketIcon, title: 'Market'),
                  AdvancedServicesWidget(image: OImages.waleetIcon, title: 'Contractor request'),
                ],
              ),

              /// Make Size
              SizedBox(height: 18.h),



            ],
          ),
        ),
      ),
      bottomNavigationBar: ContinueButtonInBottomWidget(
          centerWidget: Text('Continue', style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)),
          onTap: () {}),
    );
  }
}
