import 'package:osta_user_app/features/home/presentation/widgets/home/product_container_widget.dart';
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
      child: Padding(
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
                    height: 52.h,
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
                          height: 52.h,
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
                  SizedBox(height: 24.h),

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
                            ContainerIconsInServicesWidget(serviceIcon: OConstants.servicesIcons1[index]),

                            /// Make Space
                            SizedBox(height: 12.h),

                            /// Services Texts
                            Text(OConstants.servicesTexts1[index], style: OStyles.bodyLargeBold),
                          ],
                        ),
                      ),
                    ),
                  ),
                  /// Make Space
                  SizedBox(height: 24.h),
                  /// Row Two
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
                            ContainerIconsInServicesWidget(serviceIcon: OConstants.servicesIcons2[index]),

                            /// Make Space
                            SizedBox(height: 12.h),

                            /// Services Texts
                            Text(OConstants.servicesTexts2[index], style: OStyles.bodyLargeBold),
                          ],
                        ),
                      ),
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

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AdvancedServicesWidget(image: OImages.contractorRequestIcon, title: 'Contractor request'),
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
      ),
    );
  }
}

class AdvancedServicesWidget extends StatelessWidget {
  const AdvancedServicesWidget({super.key, required this.image, required this.title});

  final String image, title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190.w,
      height: 90.h,
      decoration: BoxDecoration(
          color: OColors.whiteColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [AppBoxShadows.cardShadowTwo]
      ),
      child: Row(
        children: [
          SvgPicture.asset(image),
          SizedBox(width: 10.w),
          Expanded(child: Text(title, style: OStyles.h6Bold, overflow: TextOverflow.clip)),
        ],
      ),
    );
  }
}
