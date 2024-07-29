import 'package:osta_user_app/utils/constants/exports.dart';

class ContainerIconsInServicesWidget extends StatelessWidget {
  const ContainerIconsInServicesWidget({super.key, required this.serviceIcon, required this.onTap, required this.servicesBgColors});

  final String serviceIcon;
  final Color servicesBgColors;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWellWidget(onTap: onTap, child: Container(
      width: 60.w,
      height: 60.h,
      decoration: BoxDecoration(
        // color: OColors.purpleTransparent.withOpacity(.08),
        color: servicesBgColors,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Center(
        child: SvgPicture.asset(serviceIcon, width: 26.w, height: 26.h),
      ),
    ));
  }
}
