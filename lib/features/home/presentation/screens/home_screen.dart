import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocProvider(
        create: (context) => HomeCubit()..getAllServicesFunction(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var homeCubit = HomeCubit.get(context);

            return Padding(
              padding: EdgeInsets.only(right: 0.w, top: 68.h),
              child: Column(
                children: [
                  /// Above of Most Popular Services
                  Padding(
                    padding: EdgeInsets.only(right: 24.w, left: 24.w),
                    child: Column(
                      children: [
                        /// App Bar
                        SizedBox(
                          height: ODeviceUtils.getScreenHeight(context).h / 10,
                          width: double.infinity,
                          child: Row(
                            children: [
                              /// Profile Image
                              const CircleAvatar(backgroundImage: AssetImage(OImages.profileImage)),

                              /// Make Space
                              SizedBox(width: 16.w),

                              /// Text (Good Morning - User Name)
                              SizedBox(
                                width: 230.w,
                                height: 56.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Good Morning 👋', style: OStyles.bodyLargeRegular.copyWith(color: OColors.greyScale600)),
                                    Text('Andrew Ainsley', style: OStyles.h5Bold),
                                  ],
                                ),
                              ),

                              /// Notification Icon
                              InkWellWidget(onTap: () => context.pushNamed(ORoutesName.notificationsRoute), child: SvgPicture.asset(OImages.notificationIcon)),

                              /// Make Space
                              SizedBox(width: 16.w),

                              /// BookMark Icon
                              SvgPicture.asset(OImages.bookMarkIcon),
                            ],
                          ),
                        ),

                        /// Make Space
                        SizedBox(height: 24.h),

                        /// Banner - Dot
                        Stack(
                          children: [
                            /// Banner
                            CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                viewportFraction: 1,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) => setState(() => currentIndex = index),
                              ),
                              items: OConstants.bannerImages.map((item) => Container(
                                decoration: BoxDecoration(
                                  boxShadow: [AppBoxShadows.cardShadowTwo],
                                  image: DecorationImage(
                                    image: AssetImage(item),
                                    fit: BoxFit.cover, // Changed to BoxFit.cover to fill the container
                                  ),
                                  borderRadius: BorderRadius.circular(32.r),
                                ),
                              )).toList(),
                            ),
                            // Positioned dots indicator
                            Positioned(
                              bottom: 12.h, // Position from bottom set as 12.h
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(OConstants.bannerImages.length, (index) => ODeviceUtils.buildDotWidget(index, currentIndex, context, BoxDecoration(color: OColors.whiteColor, borderRadius: BorderRadius.circular(100.r)))),
                              ),
                            ),
                          ],
                        ),

                        /// Make Space
                        SizedBox(height: 25.h),

                        /// Row (Services - See All)
                        RowSeeAllWidget(mainText: 'Daily services', seeAllText: 'See All', onTap: () => context.pushNamed(ORoutesName.allServicesRoute)),

                        /// Make Space
                        // SizedBox(height: 24.h),

                        /// Services
                        /// Row One
                        homeCubit.allServicesModel.result == null
                            ?  LoadingWidget(iconColor: OColors.primaryColor500) :
                        SizedBox(
                          height: ODeviceUtils.getScreenHeight(context) / 3.4,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 8,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 24.w, crossAxisSpacing: 24.h, childAspectRatio: ODeviceUtils.getScreenHeight(context) / 1000),
                            itemBuilder: (context, index) {
                              var servicesList = homeCubit.allServicesModel.result!.sublist(0, 8);

                              return Column(
                                children: [
                                  ContainerIconsInServicesWidget(
                                    serviceIcon: OConstants.servicesIcons2[index],
                                    onTap: () {
                                      if(servicesList[index].category == 'basic') {
                                        context.pushNamed(ORoutesName.electricityPlumbingAirConditionCarpentrySRoute, arguments: {
                                          'serviceId': servicesList[index].id,
                                          'category': servicesList[index].category,
                                        });
                                      } else if(servicesList[index].category == 'space_based') {
                                        context.pushNamed(ORoutesName.tilingAndPaintingRoute, arguments: {
                                          'serviceId': servicesList[index].id,
                                          'category': servicesList[index].category,
                                        });
                                      } else if(servicesList[index].category == 'technical') {
                                        context.pushNamed(ORoutesName.homeAppSatelliteChannelAndSurveillanceCamerasSRoute, arguments: {
                                          'serviceId': servicesList[index].id,
                                          'category': servicesList[index].category,
                                        });
                                      } else if(servicesList[index].category == 'other') {
                                        context.pushNamed(ORoutesName.cleanlinessAndGardensRoute,arguments: {
                                          'serviceId': servicesList[index].id,
                                          'category': servicesList[index].category,
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(servicesList[index].name.toString(), style: OStyles.bodyLargeBold, overflow: TextOverflow.ellipsis,),
                                ],
                              );
                            },
                          )),
                        ],
                            ),
                          ),
                        //     children: [
                        //       Column(
                        //         children: [
                        //           ContainerIconsInServicesWidget(serviceIcon: OImages.cleaningIcon, onTap: () => context.pushNamed(ORoutesName.cleanlinessAndGardensRoute)),
                        //           SizedBox(height: 12.h),
                        //           Text('Cleaning', style: OStyles.bodyLargeBold),
                        //         ],
                        //       ),
                        //
                        //       Column(
                        //         children: [
                        //           ContainerIconsInServicesWidget(serviceIcon: OImages.repairingIcon, onTap: () => context.pushNamed(ORoutesName.electricityPlumbingAirConditionCarpentrySRoute)),
                        //           SizedBox(height: 12.h),
                        //           Text('Repairing', style: OStyles.bodyLargeBold),
                        //         ],
                        //       ),
                        //
                        //       Column(
                        //         children: [
                        //           ContainerIconsInServicesWidget(serviceIcon: OImages.laundry, onTap: () => context.pushNamed(ORoutesName.tilingAndPaintingRoute)),
                        //           SizedBox(height: 12.h),
                        //           Text('Painting', style: OStyles.bodyLargeBold),
                        //         ],
                        //       ),
                        //
                        //       Column(
                        //         children: [
                        //           ContainerIconsInServicesWidget(serviceIcon: OImages.paintingIcon, onTap: () => context.pushNamed(ORoutesName.homeAppSatelliteChannelAndSurveillanceCamerasSRoute)),
                        //           SizedBox(height: 12.h),
                        //           Text('Laundry', style: OStyles.bodyLargeBold),
                        //         ],
                        //       ),
                        //     ],
                        //     children: List.generate(
                        //       OConstants.servicesIcons1.length,
                        //           (index) => Column(
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         children: [
                        //           /// Services Icons
                        //           ContainerIconsInServicesWidget(serviceIcon: OConstants.servicesIcons1[index], onTap: () {}),
                        //
                        //           /// Make Space
                        //           SizedBox(height: 12.h),
                        //
                        //           /// Services Texts
                        //           Text(OConstants.servicesTexts1[index], style: OStyles.bodyLargeBold),
                        //         ],
                        //       ),

                        // ),
                        // /// Make Space
                        // SizedBox(height: 24.h),
                        // /// Row Two
                        // SizedBox(
                        //   height: 94.h,
                        //   width: double.infinity,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: List.generate(
                        //       1,
                        //           (index) => Column(
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         children: [
                        //           /// Services Icons
                        //           ContainerIconsInServicesWidget(serviceIcon: OConstants.servicesIcons2[3], onTap: () {  },),
                        //
                        //           /// Make Space
                        //           SizedBox(height: 12.h),
                        //
                        //           /// Services Texts
                        //           Text(OConstants.servicesTexts2[3], style: OStyles.bodyLargeBold),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        /// Make Space
                        SizedBox(height: 24.h),

                        /// Divider
                        Divider(color: OColors.greyScale200, thickness: 1.w),

                        /// Make Space
                        SizedBox(height: 24.h),

                        /// Row (Advanced Services)
                        Row(
                          children: [
                            Text('Advanced services', style: OStyles.h5Bold),
                          ],
                        ),

                        /// Make Space
                        SizedBox(height: 11.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AdvancedServicesWidget(image: OImages.contractorRequestIcon, title: 'Contractor request', onTap: () => context.pushNamed(ORoutesName.oneTimeServiceInHomeScreenRoute)),
                            AdvancedServicesWidget(image: OImages.marketIcon, title: 'Market'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// Make Space
                  SizedBox(height: 24.h),

                  /// Filter
                  // SizedBox(
                  //   height: 38.h,
                  //   child: ListView.builder(
                  //     itemCount: OConstants.mostPopularList.length,
                  //     shrinkWrap: true,
                  //     padding: EdgeInsets.only(left: 24.w),
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) {
                  //       bool isSelected = selectedIndex == index;
                  //       return GestureDetector(
                  //         onTap: () => setState(() => selectedIndex = index),
                  //         child: AnimatedContainer(
                  //           duration: const Duration(milliseconds: 300),
                  //           curve: Curves.easeInOut,
                  //           height: 38.h,
                  //           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  //           margin: EdgeInsets.only(right: index != OConstants.mostPopularList.length - 1 ? 12.w : 12.w),
                  //           decoration: BoxDecoration(
                  //             color: isSelected ? OColors.primaryColor500 : Colors.transparent,
                  //             borderRadius: BorderRadius.circular(100.r),
                  //             border: Border.all(width: 2.w, color: OColors.primaryColor500),
                  //           ),
                  //           child: Text(
                  //             OConstants.mostPopularList[index],
                  //             style: OStyles.bodyLargeSemiBold.copyWith(color: isSelected ? OColors.whiteColor : OColors.primaryColor500, height: isSelected ? 0.h : 0.h),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),

                  /// Make Space
                  // SizedBox(height: 24.h),
                  //
                  // Container(
                  //   width: double.infinity,
                  //   height: 160.h,
                  //   margin: EdgeInsets.symmetric(horizontal: 24.w),
                  //   padding: EdgeInsets.all(20.sp),
                  //   decoration: BoxDecoration(
                  //     color: OColors.whiteColor,
                  //     borderRadius: BorderRadius.circular(32.r),
                  //     boxShadow: [AppBoxShadows.cardShadowTwo],
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Image.asset(OImages.osta1),
                  //       SizedBox(width: 16.w),
                  //       const ProductContainerWidget(ostaName: 'Kylee Danford', serviceName: 'House Cleaning', servicePrice: '\$25', serviceRate: '4.8', numberOfReviews: '8,289 reviews'),
                  //     ],
                  //   ),
                  // ),

                  /// Make Space
                  // SizedBox(height: 24.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}