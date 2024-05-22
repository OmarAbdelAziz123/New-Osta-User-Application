import 'package:osta_user_app/utils/constants/exports.dart';

class WhatHappenedWithUsWidget extends StatelessWidget {
  const WhatHappenedWithUsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Make Size
        SizedBox(height: 18.h),

        Text('What happened with us?', style: OStyles.h5Bold),

        /// Make Size
        SizedBox(height: 17.h),

        /// Services
        /// Row One
        SizedBox(
          height: 94.h,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              OConstants.servicesIcons1.length,
                  (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Services Icons
                  ContainerIconsInServicesWidget(serviceIcon: OConstants.servicesIcons1[index], onTap: () {  },),

                  /// Make Space
                  SizedBox(height: 12.h),

                  /// Services Texts
                  Text(OConstants.servicesTexts1[index], style: OStyles.bodyLargeBold),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
