import 'package:osta_user_app/features/booking/presentation/screens/upcoming_screen.dart';

import '../../../../utils/constants/exports.dart';

class EmptyUpcomingScreen extends StatefulWidget {
   EmptyUpcomingScreen({Key? key}) : super(key: key);
  bool onPressedButton = false;

  @override
  State<EmptyUpcomingScreen> createState() => _EmptyUpcomingScreenState();
}

class _EmptyUpcomingScreenState extends State<EmptyUpcomingScreen> {

  @override
  Widget build(BuildContext context) {

    return widget.onPressedButton ? const UpcomingScreen(): Column(
      children: [
        /// Make Size
        SizedBox(height: 104.h),
        /// Upcoming Image
        Image.asset(OImages.upcomingImage,fit: BoxFit.scaleDown,height: 250.h,width: 339.w,),
        /// Make Size
        SizedBox(height: 40.h),
        /// Text
        SizedBox(
          width: double.infinity,
          height: 105.h,
          child: Column(
            children: [
              Text("You have no upcoming booking",style: OStyles.h4Bold),
              /// Make Size
              SizedBox(height: 12.h),
              Text("You do not have a upcoming booking. Make a new booking by clicking the button below",style: OStyles.bodyXLargeRegular)
            ],
          ),
        ),
        /// Make Size
        SizedBox(height: 40.h),
        /// Button
        GestureDetector(
            onTap: (){
              setState(() {
                widget.onPressedButton = !widget.onPressedButton;
              });
            },
            child: ThirdButtonWidget(

                isRejected: false, widgetInButton: Text("Make New Booking", style: OStyles.bodyXSmallSemiBold.copyWith(color: OColors.whiteColor)), textStyle: OStyles.bodyLargeBold.copyWith(color: OColors.primaryColor500), containerColor: OColors.primaryColor100, width: 380.w, height: 58.h, borderRadius: 50.r, onTap: () {  }, )
        )

      ],
    );
  }
}
