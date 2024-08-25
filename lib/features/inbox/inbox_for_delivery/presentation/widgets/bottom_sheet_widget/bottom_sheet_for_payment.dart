import 'package:osta/common/widgets/buttons/close_button_widget.dart';

import '../../../../../../utils/constants/exports.dart';

class BottomSheetForPayment extends StatefulWidget {
  const BottomSheetForPayment({Key? key}) : super(key: key);

  @override
  State<BottomSheetForPayment> createState() => _BottomSheetForPaymentState();
}

class _BottomSheetForPaymentState extends State<BottomSheetForPayment> {
  @override
  Widget build(BuildContext context) {
    bool electronicWallet=false;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.only(left: 8.w,right: 8.w,top:16.h),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CloseButtonWidget(),
            Text("Payment"),
            Text("Choose payment method"),
            SizedBox(height: 16.h),
            Container(
              width: width / 2.5,
              padding: EdgeInsets.all(4.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: OColors.error
              ),
              child:  Center(
                child: Text("Total 125 pounds"),
              ),
            ),
            SizedBox(height: 16.h),
            // const CustomRadioButtonInChat(),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  // void showBottomSheet() {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return const CustomBottomSheetInElectronicWallet();
  //       });
  // }
}
