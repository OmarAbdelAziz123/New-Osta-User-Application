

import '../../../../../../utils/constants/exports.dart';

class TextOfTime extends StatelessWidget {
  const TextOfTime({Key? key, required this.time}) : super(key: key);
 final String time;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.only(left: 16.w,right: 16.w,top:16.h,bottom: 10.h),
      child: Text(time,style:  OStyles.bodySmallMedium),
    );
  }
}
