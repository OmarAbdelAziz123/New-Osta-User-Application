import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/common/widgets/cach_network_images/cach_network_images.dart';
import 'package:osta_user_app/common/widgets/loading_widget/loading_services_widget.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/features/profile/managers/profile_cubit.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  int selectedIndex = 0;

  bool isLoadingPersonalImage = false;

  @override
  void initState() {
    if(HomeCubit.get(context).allServicesModel.result == null) HomeCubit.get(context).getAllServicesFunction();
    if(HomeCubit.get(context).getAllOffersToMeModel.result == null) HomeCubit.get(context).getAllOffersFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                /// Profile Image
                                CircleAvatar(
                                  radius: 33.r,
                                  backgroundColor: OColors.primaryColor100,
                                  child: CachNetworkImages(
                                    bottomLeftRadius: 100.r,
                                    bottomRightRadius: 100.r,
                                    topLeftRadius: 100.r,
                                    topRightRadius: 100.r,
                                    imageUrl: ProfileCubit.get(context).getProfileDataModel.result != null ? ProfileCubit.get(context).getProfileDataModel.result!.personalMediaUrl! : '',
                                    width: 200.w,
                                    height: 200.h,
                                  ),
                                ),

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
                                      Text(OCacheHelper.getString(key: CacheKeys.fullName).toString(), style: OStyles.h5Bold, overflow: TextOverflow.ellipsis),
                                      // Text('Andrew Ainsley', style: OStyles.h5Bold),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            /// Notification Icon
                            InkWellWidget(onTap: () => context.pushNamed(ORoutesName.notificationsRoute), child: SvgPicture.asset(OImages.notificationIcon)),

                            /// Make Space
                            // SizedBox(width: 16.w),
                            //
                            /// BookMark Icon
                            // SvgPicture.asset(OImages.bookMarkIcon),
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
                              height: ODeviceUtils.getScreenHeight(context) / 6,
                              autoPlay: true,
                              viewportFraction: 1,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) => setState(() => currentIndex = index),
                            ),
                            items: OConstants.bannerImages.map((item) => Container(
                              decoration: BoxDecoration(
                                // color: Colors.red,
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
                      homeCubit.allServicesModel.result == null
                          ?  const LoadingServicesWidget()
                          : SizedBox(
                        height: ODeviceUtils.getScreenHeight(context) / 3.4,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 8,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 24.w,
                                    crossAxisSpacing: ODeviceUtils.getScreenHeight(context) / 90,
                                    childAspectRatio: ODeviceUtils.getScreenHeight(context) / 1000,
                                ),
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
                                              'name': servicesList[index].name,
                                            });
                                          } else if(servicesList[index].category == 'space_based') {
                                            context.pushNamed(ORoutesName.tilingAndPaintingRoute, arguments: {
                                              'serviceId': servicesList[index].id,
                                              'category': servicesList[index].category,
                                              'name': servicesList[index].name,
                                            });
                                          } else if(servicesList[index].category == 'technical') {
                                            context.pushNamed(ORoutesName.homeAppSatelliteChannelAndSurveillanceCamerasSRoute, arguments: {
                                              'serviceId': servicesList[index].id,
                                              'category': servicesList[index].category,
                                              'name': servicesList[index].name,
                                            });
                                          } else if(servicesList[index].category == 'other') {
                                            context.pushNamed(ORoutesName.cleanlinessAndGardensRoute,arguments: {
                                              'serviceId': servicesList[index].id,
                                              'category': servicesList[index].category,
                                              'name': servicesList[index].name,
                                            });
                                          }
                                        },
                                      ),
                                      SizedBox(height: 12.h),
                                      Text(ODeviceUtils.capitalizeFirstLetter(servicesList[index].name!), style: OStyles.bodyLargeBold, overflow: TextOverflow.ellipsis,),
                                      // Text(servicesList[index].name.toString(), style: OStyles.bodyLargeBold, overflow: TextOverflow.ellipsis,),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

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
                          // Expanded(flex: 10, child: AdvancedServicesWidget(image: OImages.contractorRequestIcon, title: 'Contractor request', onTap: () => context.pushNamed(ORoutesName.contructorRequests))),
                          Expanded(flex: 10, child: AdvancedServicesWidget(image: OImages.contractorRequestIcon, title: 'Contractor request', onTap: () => context.pushNamed(ORoutesName.oneTimeServiceInHomeScreenRoute))),
                          const Expanded(child: SizedBox()),
                          Expanded(flex: 10, child: AdvancedServicesWidget(image: OImages.marketIcon, title: 'Market')),
                        ],
                      ),

                      /// Make Space
                      // SizedBox(height: 13.h),

                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical:8.h),
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //       color: OColors.primaryColor500,
                      //       width: 3.w,
                      //     ),
                      //     borderRadius: BorderRadius.circular(100.r),
                      //   ),
                      //   child: Text(state is GetAllOffersLoadingState || homeCubit.getAllOffersToMeModel.result == null ? 'Waiting for offers' : 'You have ${homeCubit.getAllOffersToMeModel.result!.length} offers', style: OStyles.bodyLargeSemiBold.copyWith(color: OColors.primaryColor500)),
                      // )
                    ],
                  ),
                ),

                /// Make Space
                SizedBox(height: 18.h),
              ],
            ),
          );
        },
      ),
    );
  }
}