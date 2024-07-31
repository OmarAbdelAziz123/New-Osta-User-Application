import 'package:osta_user_app/features/home/presentation/widgets/notifications/notification_container_widget.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          /// App Bar
          Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h, bottom: 0.h),
            child: AppBarWidget(
              leading: InkWellWidget(onTap: () => context.pop(), child: const Icon((Icons.arrow_back))),
              title: AppLocalizations.of(context)!.translate('notification')!,
              actions: SvgPicture.asset(OImages.moreIcon),
              widthOfText: 282.w,
            ),
          ),

          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 0.h, bottom: 42.h),
              child: Column(
                children: [


                  /// Make Space
                  SizedBox(height: 33.5.h),

                  SizedBox(
                    height: ODeviceUtils.getScreenHeight(context).h / .8,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Today', style: OStyles.h6Bold),

                        /// Make Space
                        SizedBox(height: 24.h),

                        /// Notification Container Component
                        NotificationContainerWidget(image: OImages.waleetImage, title: AppLocalizations.of(context)!.translate('paymentSuccessful')!, description: AppLocalizations.of(context)!.translate('youHaveModeAServicesPayment')!),

                        /// Make Space
                        SizedBox(height: 24.h),

                        /// Notification Container Component
                        NotificationContainerWidget(image: OImages.newCategoryIcon, title: AppLocalizations.of(context)!.translate('newCategoryServices')!, description: AppLocalizations.of(context)!.translate('nowThePlumingServiceIsAvailable')!),

                        /// Make Space
                        SizedBox(height: 24.h),

                        Text('Yesterday', style: OStyles.h6Bold),

                        /// Make Space
                        SizedBox(height: 24.h),

                        /// Notification Container Component
                        const NotificationContainerWidget(image: OImages.todayIcon, title: 'Today’s Special Offers', description: 'You get a special promo today!'),

                        /// Make Space
                        SizedBox(height: 24.h),

                        Text('December 22, 2024', style: OStyles.h6Bold),

                        /// Make Space
                        SizedBox(height: 24.h),

                        /// Notification Container Component
                        const NotificationContainerWidget(image: OImages.waleetImage, title: 'Credit Card Connected!', description: 'Credit Card has been linked!'),

                        /// Make Space
                        SizedBox(height: 24.h),

                        /// Notification Container Component
                        const NotificationContainerWidget(image: OImages.accountImage, title: 'Account Setup Successful!', description: 'Your account has been created!'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}