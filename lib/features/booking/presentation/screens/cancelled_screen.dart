import 'package:osta_user_app/features/booking/presentation/widgets/my_booking_container_widget/my_booking_container_widget.dart';

import '../../../../utils/constants/exports.dart';

class CancelledScreen extends StatelessWidget {
  const CancelledScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        // child:
        // ListView.builder(
        //     itemCount: 3,
        //     itemBuilder: (context,index){
        //       return  MyBookingContainerWidget(bookingImage: OConstants.bookingImage[index],bookingJob: OConstants.bookingJobs[index], bookingName: OConstants.bookingName[index], containerColor: OColors.error, buttonText: 'Cancelled',);
        //     })
      // Column(
      //   children:
      //     List.generate(
      //       OConstants.bookingImage.length, (index) {
      //         return  MyBookingContainerWidget(bookingImage: OConstants.bookingImage[index],bookingJob: OConstants.bookingJobs[index], bookingName: OConstants.bookingName[index], containerColor: OColors.error);
      //       },
      //     ),
      // ),
    );
  }
}
