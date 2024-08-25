import 'package:osta/common/widgets/app_bar/app_bar_widget2.dart';
import 'package:osta/features/inbox/inbox_for_delivery/presentation/widgets/bottom_sheet_widget/bottom_sheet_for_payment.dart';
import 'package:osta/features/inbox/inbox_for_delivery/presentation/widgets/chat_bottom_navigation_bar_widget/chat_bottom_navigation_bar_widget.dart';
import 'package:osta/features/inbox/inbox_for_delivery/presentation/widgets/container_details_price_widget/container_details_price_widget.dart';
import 'package:osta/features/inbox/inbox_for_delivery/presentation/widgets/container_details_price_widget/container_total_amount.dart';
import 'package:osta/features/inbox/inbox_for_delivery/presentation/widgets/container_info_widget/container_info_widget.dart';
import 'package:osta/features/inbox/inbox_for_delivery/presentation/widgets/container_of_confirmtion/container_of_confirmation_widget.dart';
import 'package:osta/features/inbox/inbox_for_delivery/presentation/widgets/container_of_confirmtion/container_of_confirmation_widget2.dart';
import 'package:osta/features/inbox/inbox_for_delivery/presentation/widgets/text/container_text_widget.dart';

import '../../../../../utils/constants/exports.dart';
import '../widgets/container_problem_description_widget/continer_problem_description_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// App Bar
            AppBarWidget2(
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context.pop();
                    }),
                title: widget.title,
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

            /// Container Info For User
            const ContainerInfoWidget(),

            ///Make Space
            SizedBox(height: 16.w),

            Expanded(
              child: ListView(
                children: [
                  /// Problem Description
                  const ContainerProblemDescriptionWidget(),

                  /// Make Space
                  SizedBox(height: 16.h),

                  /// Details Price
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ContainerDetailsPriceWidget(),
                    ],
                  ),

                  /// Make Space
                  SizedBox(height: 16.h),

                  /// Confirmation Order
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ContainerOfConfirmationWidget(
                        isTrue: false,
                        text1:
                            'Hello, this is Mustafa Ibrahim. I am pleased to serve you today. I ask you to confirm the request',
                        textBt1: 'Confirmation',
                        textBt2: "Cancel",
                      ),
                    ],
                  ),

                  /// Make Space
                  SizedBox(height: 16.h),
                  ContainerTextWidget(text: "Confirmation", time: "4:31PM"),

                  /// Make Space
                  SizedBox(height: 16.h),

                  /// Track On Map
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomContainerConfirmationWidget2(
                          text:
                              "Mustafa is now crowned, following him on the map",
                          textButton: "Track on map",
                          onTap: () {})
                    ],
                  ),
                  SizedBox(height: 16.h),

                  /// Track On Map
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomContainerConfirmationWidget2(
                          text: "Mustafa has reached you now, confirm arrival",
                          textButton: "Arrived",
                          onTap: () {})
                    ],
                  ),

                  /// Make Space
                  SizedBox(height: 16.h),
                  ContainerTextWidget(text: "Arrived", time: "4:38PM"),

                  SizedBox(height: 16.h),

                  /// Confirmation Order
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ContainerOfConfirmationWidget(
                        isTrue: true,
                        text1:
                            'The service provider wants to add an additional cost 20%',
                        textBt1: 'Confirmation',
                        textBt2: "reject",
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  ContainerTextWidget(text: "Reject", time: "4:38PM"),

                  SizedBox(height: 16.h),

                  /// Track On Map
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomContainerConfirmationWidget2(
                          text: "Please confirm payment",
                          textButton: "Payment",
                          onTap: () {showBottomSheetForPayment();}
                      )
                    ],
                  ),

                  /// Make Space
                  SizedBox(height: 16.h),
                  ContainerTextWidget(text: "Payment", time: "4:38PM"),
                  SizedBox(height: 16.h),

                  /// Track On Map
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomContainerConfirmationWidget2(
                          text: "Please confirm when the service is finished",
                          textButton: "Service ended",
                          onTap: () {})
                    ],
                  ),
                  /// Make Space
                  SizedBox(height: 16.h),
                  ContainerTextWidget(text: "Service ended", time: "4:38PM"),

                  /// Make Space
                  SizedBox(height: 16.h),
                  const ContainerTotalAmount()
                ],
              ),
            )
          ],
        ),
      ),

      /// Text Form Field
      bottomNavigationBar: ChatBottomNavigationBarWidget(),
    );
  }

  void showBottomSheetForPayment() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r))),
        showDragHandle: false,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return const BottomSheetForPayment();
        });
  }
}
