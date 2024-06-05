
import 'package:osta_user_app/features/inbox/inbox_for_delivery/presentation/widgets/text/text_of_time.dart';

import '../../../../../../utils/constants/exports.dart';

class ContainerTextWidget extends StatelessWidget {
  ContainerTextWidget({Key? key,required this.text,required this.time}) : super(key: key);
  String text,time;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15.r),
                bottomLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r),
              ),
              color: OColors.primaryColor100,
              border: Border.all(color: OColors.greyScale500,width: 0.4.w),
            ),
            child: Text(text,style: OStyles.bodyLargeMedium.copyWith(color: OColors.primaryColor500)),
          ),
         TextOfTime(time: time)

        ],
      ),
    );
  }
}
