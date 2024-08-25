import 'package:osta/utils/constants/exports.dart';

class SpacesScreen extends StatelessWidget {
  const SpacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h, bottom: 0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// App Bar
            AppBarWidget(
              leading: InkWellWidget(onTap: () => Navigator.of(context).pop(), child: const Icon(Icons.arrow_back)),
              title: '',
              actions: Container(),
              widthOfText: 282.w,
            ),

            /// Make Space
            SizedBox(height: 15.h),

            Text('Spaces', style: OStyles.h5Bold),

            /// Make Space
            SizedBox(height: 15.h),

            Expanded(
              child: GridView.builder(
                itemCount: 80,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 24.w,
                  crossAxisSpacing: 23.h,
                  childAspectRatio: 3 / 1,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    width: 97.w,
                    height: 33.h,
                    decoration: BoxDecoration(
                      color: OColors.whiteColor,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [AppBoxShadows.cardShadowTwo],
                    ),
                    child: Center(
                      child: Text('10 - 20 M', style: OStyles.bodyLargeBold, textAlign: TextAlign.center),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // bottomNavigationBar: ContinueButtonInBottomWidget(onTap: () {}),
    );
  }
}
