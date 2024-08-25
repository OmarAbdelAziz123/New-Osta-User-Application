import 'package:osta/utils/constants/exports.dart';

class WhatHappenedWithUsWidget extends StatelessWidget {
  const WhatHappenedWithUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('What happened with us?', style: OStyles.h5Bold),

        /// Make Size
        SizedBox(height: 17.h),

        /// Services
        /// Row One
        Container(
          height: ODeviceUtils.getScreenHeight(context).h / 7.5,
          width: double.infinity,
          // color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              OConstants.servicesIcons1.length,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Services Icons
                  // ContainerIconsInServicesWidget(
                  //   serviceIcon: OConstants.servicesIcons1[index],
                  //   onTap: () {  },
                  //   servicesBgColors: OColors.purpleTransparent.withOpacity(.08),
                  // ),
                  WhatHappenedWidget(image: OConstants.servicesIcons1[index]),

                  /// Make Space
                  SizedBox(height: 12.h),

                  /// Services Texts
                  Text(OConstants.servicesTexts1[index],
                      style: OStyles.bodyLargeBold),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class WhatHappenedWidget extends StatelessWidget {
  const WhatHappenedWidget({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 70.h,
      decoration: BoxDecoration(
        color: OColors.purpleTransparent.withOpacity(.08),
        // color: servicesBgColors,
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(
          width: 1.w,
          color: OColors.primaryColor500,
        ),
      ),
      child: Center(
        child: SvgPicture.asset(image),
      ),
    );
  }
}
