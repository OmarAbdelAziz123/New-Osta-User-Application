import 'package:osta/features/inbox/inbox_for_delivery/presentation/widgets/text/text_of_details_price_widget.dart';

import '../../../../../../utils/constants/exports.dart';

class ContainerForTotalWidget extends StatelessWidget {
  const ContainerForTotalWidget({Key? key, required this.totalAmount}) : super(key: key);
  final int totalAmount;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(15.r),topLeft: Radius.circular(15.r)),
        color: OColors.greyScale100
      ),
      child: Column(
        children: [
          TextOfDetailsPriceWidget(type: "Service value", price: "100",top: 13.h,right: 30,left: 0,bottom: 13.h),
          const Divider(thickness: 0.5),
          TextOfDetailsPriceWidget(type: "Other purchases", price: "200",top: 13.h,right: 30,left: 0,bottom: 13.h),
          const Divider(thickness: 0.5),
          TextOfDetailsPriceWidget(type: "Additional value", price: "20",top: 13.h,right: 30,left: 0,bottom: 13.h),
          const Divider(thickness: 0.5),
          TextOfDetailsPriceWidget(type: "Tax", price: "15",top: 13.h,right: 30,left: 0,bottom: 13.h),
          const Divider(thickness: 0.5),
          SizedBox(height: 13.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total",style: OStyles.bodyLargeRegular),
              Text("$totalAmount",style: OStyles.bodyLargeSemiBold.copyWith(color: OColors.primaryColor500)),
              ThirdButtonWidget(
                  onTap: () {},
                  widgetInButton: Text('Buy', style: OStyles.bodyLargeRegular.copyWith(color: OColors.whiteColor)),
                  isRejected: false, textStyle: OStyles.bodyLargeRegular.copyWith(color: OColors.whiteColor), containerColor: OColors.primaryColor500, width: 90.w, height: 50.h, borderRadius: 12.r),

            ],
          ),

        ],
      ),
    );
  }
}
