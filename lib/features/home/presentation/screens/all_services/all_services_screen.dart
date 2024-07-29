import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class AllServicesScreen extends StatelessWidget {
  const AllServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.whiteColor,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var homeCubit = HomeCubit.get(context);

          return homeCubit.allServicesModel.result == null
              ? SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.transparent,
                child: Column(
                  children: [
                  /// Make Space
                  SizedBox(height: 24.h),

                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 16,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 24.w, crossAxisSpacing: 23.h,  childAspectRatio: 3 / 4),
                      itemBuilder: (context, index) {

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// Services Icons
                            // ContainerIconsInServicesWidget(
                            //   serviceIcon: OConstants.allServicesIcons[index],
                            //   onTap: () {},
                            // ),

                            /// Make Space
                            SizedBox(height: 12.h),

                            /// Services Texts
                            // Text(OConstants.allServicesIconsTexts[index], style: OStyles.bodyLargeBold, overflow: TextOverflow.ellipsis),
                            Text('', style: OStyles.bodyLargeBold, overflow: TextOverflow.ellipsis),
                          ],
                        );
                      },
                    ),
                  ),
                ],
                ),
              ),
            ),
          )
              : Padding(
                padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 0.h),
                child: Column(
                  children: [
                    /// App Bar
                    AppBarWidget(leading: InkWellWidget(onTap: () => context.pop(), child: const Icon((Icons.arrow_back))), title: 'All Services', actions: SvgPicture.asset(OImages.moreIcon2), widthOfText: 280.w),

                    /// Make Space
                    SizedBox(height: 24.h),

                    Expanded(
                      // height: MediaQuery.of(context).size.height,
                      child: GridView.builder(
                        // physiccs: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: homeCubit.allServicesModel.result!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 24.w, crossAxisSpacing: 23.h,  childAspectRatio: 3 / 4),
                        itemBuilder: (context, index) {
                          var servicesList = homeCubit.allServicesModel.result![index];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              /// Services Icons
                              // ContainerIconsInServicesWidget(
                              //   serviceIcon: OConstants.allServicesIcons[index],
                              //   onTap: () {
                              //     if(servicesList.category == 'basic') {
                              //       context.pushNamed(ORoutesName.electricityPlumbingAirConditionCarpentrySRoute, arguments: {
                              //         'serviceId': servicesList.id,
                              //         'category': servicesList.category,
                              //         'name': servicesList.name,
                              //       });
                              //     } else if(servicesList.category == 'space_based') {
                              //       context.pushNamed(ORoutesName.tilingAndPaintingRoute, arguments: {
                              //         'serviceId': servicesList.id,
                              //         'category': servicesList.category,
                              //         'name': servicesList.name,
                              //       });
                              //     } else if(servicesList.category == 'technical') {
                              //       context.pushNamed(ORoutesName.homeAppSatelliteChannelAndSurveillanceCamerasSRoute, arguments: {
                              //         'serviceId': servicesList.id,
                              //         'category': servicesList.category,
                              //         'name': servicesList.name,
                              //       });
                              //     } else if(servicesList.category == 'other') {
                              //       context.pushNamed(ORoutesName.cleanlinessAndGardensRoute,arguments: {
                              //         'serviceId': servicesList.id,
                              //         'category': servicesList.category,
                              //         'name': servicesList.name,
                              //       });
                              //     }
                              //   },
                              // ),

                              /// Make Space
                              SizedBox(height: 12.h),

                              /// Services Texts
                              // Text(OConstants.allServicesIconsTexts[index], style: OStyles.bodyLargeBold, overflow: TextOverflow.ellipsis),
                              Text(ODeviceUtils.capitalizeFirstLetter(servicesList.name!), style: OStyles.bodyLargeBold, overflow: TextOverflow.ellipsis),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
        },
      ),
    );
  }
}
