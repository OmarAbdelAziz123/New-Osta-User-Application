import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/features/home/presentation/screens/services_details/home_app_satellite_channel_and_surveillance_cameras/one_time/one_time_screen_in_home_app_salellite.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class HomeAppSatelliteChannelAndSurveillanceCameras extends StatefulWidget {
  const HomeAppSatelliteChannelAndSurveillanceCameras({super.key, required this.data});

  // final int serviceId;
  final Map data;

  @override
  State<HomeAppSatelliteChannelAndSurveillanceCameras> createState() => _HomeAppSatelliteChannelAndSurveillanceCamerasState();
}

class _HomeAppSatelliteChannelAndSurveillanceCamerasState extends State<HomeAppSatelliteChannelAndSurveillanceCameras> with SingleTickerProviderStateMixin {
  TabController? _tabController;

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
        create: (context) => HomeCubit()..getSubServicesInIdThreeFunction(serviceId: widget.data['serviceId'])..getAllAddressesFunction(),
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
                    title: ODeviceUtils.capitalizeFirstLetter('${widget.data['name']} (${widget.data['category']})'),
                    actions: Container(),
                    widthOfText: 282.w,
                  ),

                  /// TabBar
                  TabBar(
                    indicatorColor: OColors.primaryColor500,
                    controller: _tabController,
                    labelColor: OColors.primaryColor500,
                    unselectedLabelColor: OColors.greyScale500,
                    tabs: const [
                      Tab(text:  "One time service"),
                      Tab(text:  "Subscriptions"),
                    ],
                  ),

                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children:  [
                        /// One Time Screen
                        OneTimeScreenInHomeApp(serviceId: widget.data['serviceId'], category: widget.data['category'], subServicesList: subServicesList, addressList: addressList),
                        /// Subscriptions Screen
                        Container(),
                      ],
                    ),
                  ),
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