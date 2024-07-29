import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/common/widgets/what_happened_with_us/what_happened_with_us_widget.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/features/home/presentation/screens/services_details/electricity_plumbing_aircondition_carpentry/one_time/one_time_screen_in_electricity.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class ElectricityPlumbingAirConditionCarpentryScreen extends StatefulWidget {
  const ElectricityPlumbingAirConditionCarpentryScreen({super.key, required this.data});

  // final int serviceId;
  final Map data;

  @override
  State<ElectricityPlumbingAirConditionCarpentryScreen> createState() => _ElectricityPlumbingAirConditionCarpentryScreenState();
}

class _ElectricityPlumbingAirConditionCarpentryScreenState extends State<ElectricityPlumbingAirConditionCarpentryScreen> with SingleTickerProviderStateMixin{
  TabController? _tabController;
  bool isExtended = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    // if(HomeCubit.get(context).subServiceModel.result == null) HomeCubit.get(context).getSubServicesFunction(serviceId: widget.data['serviceId']);
    // if(HomeCubit.get(context).getAllAddressesModel.result == null) HomeCubit.get(context).getAllAddressesFunction();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.greyScale50,
      body: BlocProvider(
        create: (context) => HomeCubit()..getSubServicesFunction(serviceId: widget.data['serviceId'])..getAllAddressesFunction(),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {

          },
          builder: (context, state) {
            var subServiceCubit = HomeCubit.get(context);
            var subServicesList = subServiceCubit.subServiceModel.result;
            var addressList = subServiceCubit.getAllAddressesModel.result;

            return Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h, bottom: 0.h),
              child: Column(
                children: [
                  /// App Bar
                  AppBarWidget(
                    leading: InkWellWidget(onTap: () => context.pop(), child: const Icon((Icons.arrow_back))),
                    // title: ODeviceUtils.capitalizeFirstLetter('${widget.data['name']} (${widget.data['category']})'),
                    title: '',
                    actions: Row(
                      children: [
                        Text(ODeviceUtils.capitalizeFirstLetter('${widget.data['name']}'), style: OStyles.h4Bold, overflow: TextOverflow.ellipsis),
                        // ContainerIconsInServicesWidget(serviceIcon: widget.data['serviceIcon'], onTap: () {}, servicesBgColors: widget.data['serviceColor'])
                        SizedBox(width: 20.w),
                        Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            // color: OColors.purpleTransparent.withOpacity(.08),
                            color: widget.data['serviceColor'],
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Center(
                            child: SvgPicture.asset(widget.data['serviceIcon']),
                        ))
                      ],
                    ),
                    widthOfText: ODeviceUtils.getScreenWidth(context) / 3,
                  ),
                  /// TabBar
                  // TabBar(
                  //   indicatorColor: OColors.primaryColor500,
                  //   controller: _tabController,
                  //   labelColor: OColors.primaryColor500,
                  //   unselectedLabelColor: OColors.greyScale500,
                  //   tabs: const [
                  //     Tab(text:  "One time service"),
                  //     Tab(text:  "Subscriptions"),
                  //   ],
                  // ),
                  //
                  // Expanded(
                  //   child: TabBarView(
                  //     controller: _tabController,
                  //     children:  [
                  //       /// One Time Screen
                  //       OneTimeScreenInElectricity(subServicesList: subServicesList, serviceId: widget.data['serviceId'], category: widget.data['category'], addressList: addressList),
                  //       /// Subscriptions Screen
                  //       Container(),
                  //     ],
                  //   ),
                  // ),

                  /// Make Space
                  SizedBox(height: 24.h),

                  SizedBox(
                    height: 41.h,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('One Time Service', style: OStyles.bodyXLargeSemiBold.copyWith(color: OColors.primaryColor500)),
                        Container(
                          height: 4.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: OColors.primaryColor500,
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Make Space
                  SizedBox(height: 24.h),

                  const WhatHappenedWithUsWidget(),

                  /// Make Size
                  SizedBox(height: 14.h),

                  /// Divider
                  Divider(color: OColors.greyScale200, thickness: 1.w),

                  /// Make Size
                  SizedBox(height: 14.h),

                  InkWellWidget(
                    onTap: () => setState(() => isExtended = !isExtended),
                    child: Container(
                      width: double.infinity,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: isExtended ? OColors.primaryColor500 : OColors.greyScale50,
                          gradient: isExtended ? AppGradients.purpleGradient : null,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [AppBoxShadows.cardShadowFour]
                      ),
                      child: Center(child: Text('Osta extended warranty', style: OStyles.bodyLargeSemiBold.copyWith(color: isExtended ? OColors.whiteColor : OColors.greyScale600))),
                    ),
                  ),

                  /// Make Size
                  SizedBox(height: isExtended ? 24.h : 0),

                ],
              ),
            );
          },
        ),
      ),

      // bottomNavigationBar: ContinueButtonInBottomWidget(onTap: () {}),
    );
  }
}


