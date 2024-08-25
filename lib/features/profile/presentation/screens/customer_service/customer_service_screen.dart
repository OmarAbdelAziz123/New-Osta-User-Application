import 'package:osta/utils/constants/exports.dart';

class CustomerServiceScreen extends StatelessWidget {
  const CustomerServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
        child: Column(
          children: [
            /// App Bar
            AppBarWidget(leading: InkWellWidget(onTap: () => context.pop(), child: const Icon((Icons.arrow_back))), title: 'Customer Service', actions: Row(
              children: [
                SizedBox(
                  width: 75.w,
                  height: 28.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(OImages.phone2Icon),
                      SvgPicture.asset(OImages.moreIcon),
                    ],
                  ),
                ),
              ],
            ), widthOfText: 248.w),

          ],
        ),
      ),
    );
  }
}
