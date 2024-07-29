import 'package:osta_user_app/utils/constants/exports.dart';

class LoadingServicesWidget extends StatelessWidget {
  const LoadingServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ODeviceUtils.getScreenHeight(context) / 3.4,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 7,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 24.w,
                crossAxisSpacing: ODeviceUtils.getScreenHeight(context) / 90,
                childAspectRatio: ODeviceUtils.getScreenHeight(context) / 1000,
              ),
              itemBuilder: (context, index) {

                return Shimmer.fromColors(
                  baseColor: OColors.primaryColor100,
                  highlightColor: Colors.transparent,
                  child: Column(
                    children: [
                      ContainerIconsInServicesWidget(
                        serviceIcon: OConstants.servicesIcons2[index],
                        onTap: () {},
                        servicesBgColors: OColors.purpleTransparent.withOpacity(.08),
                      ),
                      SizedBox(height: 12.h),
                      Text('', style: OStyles.bodyLargeBold, overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
