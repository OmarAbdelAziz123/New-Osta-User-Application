import 'package:osta_user_app/features/booking/presentation/widgets/my_booking_container_widget/my_booking_container_widget2.dart';

import '../../../../utils/constants/exports.dart';

class UpcomingScreen extends StatelessWidget {
  const UpcomingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context,index){
          return MyBookingContainerWidget2(bookingImage: OConstants.bookingImage[index],bookingJob: OConstants.bookingJobs[index], bookingName: OConstants.bookingName[index], containerColor: OColors.primaryColor500, buttonText: 'Upcoming',);
        }),

     // child Column(
     //    children:
     //    List.generate(3, (index) {
     //      return  MyBookingContainerWidget(bookingImage: OConstants.bookingImage[index],bookingJob: OConstants.bookingJobs[index], bookingName: OConstants.bookingName[index], containerColor: OColors.primaryColor500, buttonText: 'Upcoming',);
     //    },
     //    ),
     //  ),
    );
  }
}
