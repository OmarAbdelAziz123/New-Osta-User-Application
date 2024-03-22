import 'package:osta_user_app/utils/constants/exports.dart';

class AllServicesScreen extends StatelessWidget {
  const AllServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
          child: Column(
            children: [
              /// App Bar
              AppBarWidget(leading: InkWellWidget(onTap: () => context.pop(), child: const Icon((Icons.arrow_back))), title: 'All Services', actions: SvgPicture.asset(OImages.moreIcon2), widthOfText: 280.w),

              /// mAKE Space
              SizedBox(height: 24.h),

              Container(
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: OConstants.allServicesIcons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 24.w, crossAxisSpacing: 23.h,  childAspectRatio: 3 / 4),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /// Services Icons
                        ContainerIconsInServicesWidget(serviceIcon: OConstants.allServicesIcons[index]),

                        /// Make Space
                        SizedBox(height: 12.h),

                        /// Services Texts
                        Text(OConstants.allServicesIconsTexts[index], style: OStyles.bodyLargeBold, overflow: TextOverflow.ellipsis),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
