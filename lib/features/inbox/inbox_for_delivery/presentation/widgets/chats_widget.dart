import 'package:osta_user_app/features/inbox/presentation/widget/inbox_container_widget/container_chats_widget.dart';

import '../../../../../../utils/constants/exports.dart';

class ChatsWidget extends StatelessWidget {
  const ChatsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ListView.builder(
          itemCount: OConstants.inboxProfileImage.length,
          itemBuilder: (context,index){
            return ContainerChatsWidget(profileImage: OConstants.inboxProfileImage[index], profileName: OConstants.inboxProfileName[index], profileMessage: "I have booked your house ...", onTap: (){context.pushNamed(ORoutesName.chatForUserRoute,arguments:OConstants.inboxProfileName[index]);}, numOfMessage: "2", date: '13.29',);
          }),

    );
  }
}
