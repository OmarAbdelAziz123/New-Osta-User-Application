
import 'package:osta/features/inbox/inbox_for_delivery/presentation/widgets/text/text_of_time.dart';

import '../../../../../../utils/constants/exports.dart';


class ContainerProblemDescriptionWidget extends StatelessWidget {
  const ContainerProblemDescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 330.h,
         width: 280.w,
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15.r),
              bottomLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
            ),
            color: OColors.primaryColor100,
            border: Border.all(
              color: OColors.greyScale500,
              width: 0.4.w
            ),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Description of the problem",style: OStyles.h6Bold),
               SizedBox(height: 8.h),
              Text("Lorem Ipsum is a method of writing texts in Graphic design is commonly used",
                style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale500),
              ),
              SizedBox(height: 16.h),
              /// Images
              Row(
                children: [
                  Container(
                    height: 55.h,
                    width: 55.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: OColors.greyScale300,
                    ),
                    child: Image.asset(OImages.zoomIn),

                  ),
                  SizedBox(width: 16.w),
                  Container(
                    height: 55.h,
                    width: 55.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: OColors.greyScale300,
                    ),
                    child: Image.asset(OImages.zoomIn),

                  ),
                  SizedBox(width: 16.w),
                  Container(
                    height: 55.h,
                    width: 55.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: OColors.greyScale300,
                    ),
                    child: Image.asset(OImages.zoomIn),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
               Text("The Address",style: OStyles.bodyLargeBold),
              SizedBox(height: 8.h),
               Text("Home",style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale500)),
              SizedBox(height: 8.h),
               Text("Next to the metro, Maadi 7 St",style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale500)),
              SizedBox(height: 8.h),
               Text("payment method",style: OStyles.bodyLargeBold),
              SizedBox(height: 8.h),
               Text("cash",style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale500)),
            ],
          ),
        ),
        const TextOfTime(time: "4:30PM")

      ],
    );
  }
}
