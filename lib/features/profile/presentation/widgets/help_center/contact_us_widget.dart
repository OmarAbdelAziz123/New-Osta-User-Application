import 'package:osta/features/profile/managers/profile_cubit.dart';

import '../../../../../utils/constants/exports.dart';
import 'contact_us_container_widget.dart';

class ContactUsWidget extends StatelessWidget {
  const ContactUsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context , index){
          return ContactUsContainerWidget(contactUsText: OConstants.contactUsText[index], contactUsIcon: OConstants.contactUsIcon[index], onTab: () => navigateBasedOnIndex(context, index),
          );
        },
      ),
    );
  }
  Future<void> navigateBasedOnIndex(BuildContext context, int index) async {
    switch (index) {
      case 0:
        await ProfileCubit.get(context).createTicketFunc(title: 'test').then((value) {
          context.pushNamed(ORoutesName.customerServicesRoute, arguments: {
            'title': ProfileCubit.get(context).sendTicketResponseModel.result!.id!,
          });
        });
        break;
      case 1:
        context.pushNamed(ORoutesName.paymentRoute);
        break;
      case 2:
        context.pushNamed(ORoutesName.changePasswordRoute);
        break;
      case 4:
        context.pushNamed(ORoutesName.privacyPolicyRoute);
        break;
      case 5:
        context.pushNamed(ORoutesName.helpCenterRoute);
        break;
      default:
        break;
    }
  }

}
