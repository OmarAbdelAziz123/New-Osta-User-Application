import 'package:osta_user_app/features/inbox/inbox_for_delivery/presentation/widgets/text/text_of_details_price_widget.dart';
import 'package:osta_user_app/features/inbox/inbox_for_delivery/presentation/widgets/text/text_of_time.dart';

import '../../../../../../utils/constants/exports.dart';

class ContainerDetailsPriceWidget extends StatelessWidget {
  const ContainerDetailsPriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 150.h,
          width: 280.w,
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
              border: Border.all(
                color: OColors.greyScale500,
                width: 0.4.w
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                bottomLeft: Radius.circular(15.r),
                bottomRight: Radius.circular(15.r),
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextOfDetailsPriceWidget(type: "The Price",price: "100 EGB", top: 0,right: 0,left: 0,bottom: 0),
              SizedBox(height: 8.h),
              TextOfDetailsPriceWidget(type: "Osta fees",price: "20 EGB",top: 0,right: 0,left: 0,bottom: 0),
              SizedBox(height:8.h),
              TextOfDetailsPriceWidget(type: "Tax",price: "5 EGB",top: 0,right: 0,left: 0,bottom: 0),
              SizedBox(height: 8.h),
              TextOfDetailsPriceWidget(type: "Total", price: "125 EGB",top: 0,right: 0,left: 0,bottom: 0)
            ],
          ),
        ),
        const TextOfTime(time: "4:30PM")
      ],
    );
  }
}
