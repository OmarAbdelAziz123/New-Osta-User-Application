import 'package:osta_user_app/features/booking/presentation/screens/upcoming_screen.dart';

import '../../../../utils/constants/exports.dart';

class EmptyUpcomingScreen extends StatefulWidget {
   const EmptyUpcomingScreen({super.key, required this.title, required this.description});
   final String title, description;

  @override
  State<EmptyUpcomingScreen> createState() => _EmptyUpcomingScreenState();
}

class _EmptyUpcomingScreenState extends State<EmptyUpcomingScreen> {

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        /// Make Size
        SizedBox(height: 104.h),
        /// Upcoming Image
        Image.asset(OImages.upcomingImage,fit: BoxFit.scaleDown,height: 250.h,width: 339.w,),
        /// Make Size
        SizedBox(height: 40.h),
        /// Text
        SizedBox(
          width: double.infinity,
          height: 105.h,
          child: Column(
            children: [
              Text(widget.title, style: OStyles.h4Bold),
              /// Make Size
              SizedBox(height: 12.h),
              Text(widget.description, style: OStyles.bodyXLargeRegular)
            ],
          ),
        ),
      ],
    );
  }
}
