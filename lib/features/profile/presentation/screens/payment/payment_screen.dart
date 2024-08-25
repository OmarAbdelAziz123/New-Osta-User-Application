import 'package:osta/utils/constants/exports.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.greyScale50,
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
        child: Column(
          children: [
            /// App Bar
            AppBarWidget(
              leading: InkWellWidget(onTap: () => context.pop(), child: const Icon((Icons.arrow_back))),
              title: 'Payment',
              actions: SvgPicture.asset(OImages.moreIcon),
              widthOfText: 282.w,
            ),

            /// Make Space
            SizedBox(height: 33.5.h),

            Column(
              children: List.generate(OConstants.paymentIcons.length, (index) => PaymentContainerWidget(paymentIcon: OConstants.paymentIcons[index], paymentName: OConstants.paymentNames[index], iconHeight: index == 3 ? 44.h : 32.h,)),
            ),

            const Spacer(),

            /// Add New Card Button
            MainButtonWidget(
              centerWidgetInButton: Text('Add New Card', style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)),
              onTap: () => context.pushNamed(ORoutesName.addNewCardRoute),
              margin: EdgeInsets.zero,
              buttonColor: OColors.primaryColor500,
              boxShadow: [AppBoxShadows.buttonShadowOne],
            ),
          ],
        ),
      ),
    );
  }
}