import 'package:osta_user_app/features/home/presentation/widgets/notifications/notification_container_widget.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h, bottom: 42.h),
          child: Column(
            children: [
              /// App Bar
              AppBarWidget(
                leading: InkWellWidget(onTap: () => context.pop(), child: const Icon((Icons.arrow_back))),
                title: 'Notification',
                actions: SvgPicture.asset(OImages.moreIcon),
                widthOfText: 282.w,
              ),

              /// Make Space
              SizedBox(height: 33.5.h),

              SizedBox(
                height: 810.h,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Today', style: OStyles.h6Bold),

                    /// Make Space
                    SizedBox(height: 24.h),

                    /// Notification Container Component
                    const NotificationContainerWidget(image: OImages.waleetImage, title: 'Payment Successful!', description: 'You have made a services payment'),

                    /// Make Space
                    SizedBox(height: 24.h),

                    /// Notification Container Component
                    const NotificationContainerWidget(image: OImages.newCategoryIcon, title: 'New Category Services!', description: 'Now the plumbing service is available'),

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
    );
  }
}