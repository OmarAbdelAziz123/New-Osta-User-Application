import 'package:osta/features/inbox/inbox_for_delivery/presentation/widgets/container_info_widget/container_info_widget.dart';
import '../../../../utils/constants/exports.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key, required this.title}) : super(key: key);
 final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
        child: Column(
          children: [
            /// App Bar
            AppBarWidget(
                leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed:(){context.pop();}), title: title,
                actions: Row(
                  children: [
                    SvgPicture.asset(OImages.searchIcon, fit: BoxFit.scaleDown,width: 28.w,),
                    // SizedBox(width: 20.w),
                    // SvgPicture.asset(OImages.chatIcon, fit: BoxFit.scaleDown),
                  ],),
                widthOfText: 260.w),

            /// Make Space
            SizedBox(height: 24.h),

            /// Container Info For User
            const ContainerInfoWidget(),

            ///Make Space
            SizedBox(height: 20.w),
            
          ],
        ),
      ),
    );
  }
}
