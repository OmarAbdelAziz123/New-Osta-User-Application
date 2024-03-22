import 'package:osta_user_app/utils/constants/exports.dart';

class ContainerIconsInServicesWidget extends StatelessWidget {
  const ContainerIconsInServicesWidget({super.key, required this.serviceIcon});

  final String serviceIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: OColors.purpleTransparent.withOpacity(.08),
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Center(
        child: SvgPicture.asset(serviceIcon),
      ),
    );
  }
}
