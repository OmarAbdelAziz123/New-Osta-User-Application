import 'package:osta_user_app/common/widgets/app_bar/app_bar_widget2.dart';
import 'package:osta_user_app/features/inbox/inbox_for_delivery/presentation/widgets/chat_bottom_navigation_bar_widget/chat_bottom_navigation_bar_widget.dart';
import 'package:osta_user_app/features/inbox/inbox_for_user/presentation/widgets/container_for_total_widget/container_for_total_widget.dart';
import 'package:osta_user_app/features/inbox/inbox_for_user/presentation/widgets/container_message_widget/container_message_widget1.dart';
import 'package:osta_user_app/features/inbox/inbox_for_user/presentation/widgets/container_message_widget/container_message_widget2.dart';
import 'package:osta_user_app/features/inbox/inbox_for_user/presentation/widgets/container_message_widget/container_message_widget3.dart';
import 'package:osta_user_app/features/inbox/inbox_for_user/presentation/widgets/container_number_of_order_widget/container_number_of_order_widget.dart';
import '../../../../../utils/constants/exports.dart';

class ChatScreenForUser extends StatelessWidget {
  const ChatScreenForUser({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// App Bar
                  AppBarWidget2(
                      leading: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            context.pop();
                          }),
                      title: title,
                      actions: Row(
                        children: [
                          SvgPicture.asset(OImages.searchIcon,
                              fit: BoxFit.scaleDown, width: 25.w),
                          SizedBox(width: 20.w),
                          SvgPicture.asset(OImages.chatIcon,
                              fit: BoxFit.scaleDown, width: 25.w),
                        ],
                      ),
                      widthOfText: 215.w),

                  /// Make Space
                  SizedBox(height: 24.h),
                  /// Container Number Of Order
                  const ContainerNumberOfOrderWidget(numberOfOrder: 12345),
                  /// Make Space
                  SizedBox(height: 26.h),
                  /// Container Message
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ContainerMessage1(message: "Hello, I'm AliI am happy to serve you. Please confirm the request to start the service", timeOfMessage: "10.00",haveButton: true,haveOneButton: false)
                    ],
                  ),
                  /// Make Space
                  SizedBox(height: 27.h),
                  /// Container Message
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /// Container Message
                      ContainerMessageWidget2(message: "Sure", timeOfMessage: "10.00")
                    ],
                  ),
                  /// Make Space
                  SizedBox(height: 26.h),
                  /// Container Message
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ContainerMessage1(message: "Thank you for confirming. You can now track the Osta", timeOfMessage: "10.00",haveButton: false,haveOneButton: false)
                    ],
                  ),
                  /// Container Message
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /// Container Message
                      ContainerMessageWidget2(message: "Ali, I want some things from you. Bring them to me when you come", timeOfMessage: "10.00")
                    ],
                  ),
                  /// Make Space
                  SizedBox(height: 26.h),
                  /// Container Message
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ContainerMessage1(message: "Sure", timeOfMessage: "10.00",haveButton: false,haveOneButton: false)
                    ],
                  ),
                  /// Make Space
                  SizedBox(height: 26.h),
                  /// Container Message
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ContainerMessage3(imageOfMessage: OImages.imageMessage,message: "Bill"),
                    ],
                  ),
                  /// Make Space
                  SizedBox(height: 26.h),
                  /// Container Message
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ContainerMessage1(message: "Request to add an additional value of 20%", timeOfMessage: "10.00",haveButton: false,haveOneButton: true)
                    ],
                  ),
                  /// Make Space
                  SizedBox(height: 27.h),
                  /// Container Message
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /// Container Message
                      ContainerMessageWidget2(message: "Ok", timeOfMessage: "10.00")
                    ],
                  ),
                  /// Make Space
                  SizedBox(height: 26.h),
                  /// Container Message
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ContainerMessage1(message: "Request to add an additional value of 20%", timeOfMessage: "10.00",haveButton: false,haveOneButton: false)
                    ],
                  ),

                   ],
              ),
            ),
            /// Container Of Total
            const ContainerForTotalWidget(totalAmount: 335)
          ],
        ),
      ),
      /// Text Form Field
      bottomNavigationBar: ChatBottomNavigationBarWidget(),
    );
  }
}
