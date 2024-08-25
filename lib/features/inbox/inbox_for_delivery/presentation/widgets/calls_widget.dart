
import 'package:osta/features/inbox/presentation/widget/inbox_container_widget/container_calls_widget.dart';

import '../../../../../../utils/constants/exports.dart';

class CallsWidget extends StatelessWidget {
  const CallsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
          itemCount: OConstants.inboxProfileImage.length,
          itemBuilder: (context,index){
            return ContainerCallsWidget(profileImage:OConstants.inboxProfileImage[index], profileName: OConstants.inboxProfileName[index], profileDes: OConstants.inboxProfileDes[index], date: " | Dec 19, 2024", onTap: (){});
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
