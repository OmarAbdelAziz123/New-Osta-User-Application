// import 'package:osta_user_app/features/inbox/presentation/widget/inbox_container_widget/container_chats_widget.dart';
//
// import '../../../../../../utils/constants/exports.dart';
//
// class ChatsWidget extends StatelessWidget {
//   const ChatsWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: ListView.builder(
//           itemCount: OConstants.inboxProfileImage.length,
//           itemBuilder: (context,index){
//             return ContainerChatsWidget(profileImage: OConstants.inboxProfileImage[index], profileName: OConstants.inboxProfileName[index], profileMessage: "I have booked your house ...", onTap: (){context.pushNamed(ORoutesName.chatForUserRoute,arguments:OConstants.inboxProfileName[index]);}, numOfMessage: "2", date: '13.29',);
//           }),
//
//     );
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/features/inbox/inbox_for_delivery/managers/inbox_cubit.dart';
import 'package:osta_user_app/features/inbox/presentation/widget/inbox_container_widget/container_chats_widget.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';

import '../../../../../../utils/constants/exports.dart';

class ChatsWidget extends StatefulWidget {
  const ChatsWidget({super.key});

  @override
  State<ChatsWidget> createState() => _ChatsWidgetState();
}

class _ChatsWidgetState extends State<ChatsWidget> {

  @override
  void initState() {
    // InboxCubit.get(context).getAllConversationsFunction();
    InboxCubit.get(context).getAllConversationsFunction().then((_) {
      logSuccess('Conversations List Loaded: ${InboxCubit.get(context).conversationsList.length}');
    }).catchError((error) {
      logError('Failed to load conversations: $error');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<InboxCubit, InboxState>(
        builder: (context, state) {
          var inboxCubit = InboxCubit.get(context);
          logSuccess(inboxCubit.conversationsList.length.toString());

          return inboxCubit.conversationsList.isEmpty
              ? Center(child: LoadingWidget(iconColor: OColors.primaryColor500))
              : ListView.builder(
            itemCount: inboxCubit.conversationsList.length,
            itemBuilder: (context, index) {
              var conversation = inboxCubit.conversationsList[index];

              var userShortInfo = conversation.userShortInfo;
              var profileImage = '';
              var userName = '';
              var userPhone = '';
              if (userShortInfo != null && userShortInfo.isNotEmpty) {
                var firstUser = userShortInfo[0];
                profileImage = firstUser.personalMediaUrl?.toString() ?? '';
                userName = firstUser.name ?? '';
                userPhone = firstUser.phone ?? '';
              }

              return ContainerChatsWidget(
                // profileImage: OConstants.inboxProfileImage[index],
                profileImage: profileImage.toString(),
                profileName: userName,
                profileMessage: conversation.lastMessage!.content == null ? '' : conversation.lastMessage!.content.toString(),
                // profileMessage: "I have booked your house ...",
                onTap: () {
                  context.pushNamed(
                    ORoutesName.chatForUserRoute,
                    arguments: {
                      // '': OConstants.inboxProfileName[index],
                      'conversationId': conversation.id,
                    },
                  );
                },
                numOfMessage: conversation.lastMessage!.content == null
                    ? ''
                    : conversation.lastMessage!.isRead == true ? conversation.lastMessage!.id.toString() : '' ,
                // date: '13.29',
                date: ODeviceUtils.formatTime(conversation.lastMessage!.createdAt!),
                // date: conversation.lastMessage!.createdAt!,
              );
            },
          );
        },
      ),
    );
  }
}
