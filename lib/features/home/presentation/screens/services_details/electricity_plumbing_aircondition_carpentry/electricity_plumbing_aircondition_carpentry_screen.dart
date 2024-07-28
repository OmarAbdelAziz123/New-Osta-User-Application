import 'package:flutter_bloc/flutter_bloc.dart';
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
                        OneTimeScreenInElectricity(subServicesList: subServicesList, serviceId: widget.data['serviceId'], category: widget.data['category'], addressList: addressList),
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


