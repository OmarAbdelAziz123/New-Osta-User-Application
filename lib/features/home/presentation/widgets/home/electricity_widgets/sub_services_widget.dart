import 'package:osta_user_app/features/home/presentation/screens/services_details/electricity_plumbing_aircondition_carpentry/one_time/one_time_screen_in_electricity.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class SubServicesWidget extends StatefulWidget {
  const SubServicesWidget(
      {super.key,
      required this.subServiceName,
      required this.onTap,
      required this.numberOfPieces,
      required this.onPressed});

  final String subServiceName;
  final VoidCallback onTap;
  final String numberOfPieces;
  final void Function() onPressed;

  @override
  State<SubServicesWidget> createState() => _SubServicesWidgetState();
}

class _SubServicesWidgetState extends State<SubServicesWidget> {
  int selectedSpecificService = -1;

  @override
  Widget build(BuildContext context) {
    void handleTap() {
      widget.onTap();
    }

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 55.h,
          padding: EdgeInsets.only(top: 10.h),
          child: GestureDetector(
            onTap: () {
              setState(() {
                handleTap();
              });
            },
            child: AnimatedContainer(
              curve: Curves.easeInOut,
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                color: OColors.primaryColor100,
                boxShadow: [AppBoxShadows.cardShadowTwo],
              ),
              child: Center(
                child: Text(widget.subServiceName,
                    style: OStyles.bodyLargeBold
                        .copyWith(color: OColors.primaryColor500)),
              ),
            ),
          ),
        ),
        widget.numberOfPieces != '0'
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 25.h,
                  height: 25.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [AppBoxShadows.cardShadowOne],
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: Center(
                    child: Text(widget.numberOfPieces,
                        style: OStyles.bodyLargeRegular
                            .copyWith(color: OColors.blackColor)),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
