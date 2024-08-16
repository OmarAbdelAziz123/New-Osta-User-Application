import '../../../../../../utils/constants/exports.dart';


class ContainerChatsWidget extends StatelessWidget {
  const ContainerChatsWidget({Key? key, required this.profileImage, required this.profileName,required this.profileMessage, required this.onTap, required this.numOfMessage, required this.date}) : super(key: key);
  final String profileImage,profileName, profileMessage, numOfMessage, date;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h),
        width: double.infinity,
        height: 60.h,
        child: Row(
          children: [
            /// Profile Image
            // SizedBox(
            //   height: 60.h,
            //   width: 60.w,
            //   // child: Image.asset(profileImage,fit: BoxFit.scaleDown),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(100.r),
            //     child: Image.network(profileImage,fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
            //       return Image.asset(OImages.inbox1);
            //     },),
            //   ),
            // ),
            SizedBox(
              height: 60.h,
              width: 60.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.r),
                child: Image.network(
                  profileImage,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(OImages.inbox1, fit: BoxFit.cover);
                  },
                ),
              ),
            ),
            /// Make Space
            SizedBox(width: 20.w),
            /// Profile Info
            SizedBox(
              width: 250.w,
              height: 48.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(profileName, style: OStyles.h6Bold, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(profileMessage,style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale500), maxLines: 1, overflow: TextOverflow.ellipsis),

                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   height: 25.h,
                //   width: 25.w,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(50.r),
                //     gradient: AppGradients.purpleGradient
                //   ),
                //   child: Center(
                //     // child: Text(numOfMessage,style: OStyles.bodyXSmallRegular.copyWith(color: OColors.whiteColor)),
                //   ),
                // ),
                SizedBox(height: 9.5.h),
                Text(date, style: OStyles.bodyMediumMedium),
              ],
            )

          ],
        ),
      ),
    );
  }
}

// import '../../../../../../utils/constants/exports.dart';
//
//
// class ContainerChatsWidget extends StatelessWidget {
//   const ContainerChatsWidget({Key? key, required this.profileImage, required this.profileName,required this.profileMessage, required this.onTap, required this.numOfMessage, required this.date}) : super(key: key);
//   final String profileImage,profileName, profileMessage, numOfMessage, date;
//   final VoidCallback onTap;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: EdgeInsets.only(bottom: 24.h),
//         width: double.infinity,
//         height: 60.h,
//         child: Row(
//           children: [
//             /// Profile Image
//             SizedBox(
//               height: 60.h,
//               width: 60.w,
//               child: Image.network(profileImage,fit: BoxFit.scaleDown),
//             ),
//             /// Make Space
//             SizedBox(width: 20.w),
//             /// Profile Info
//             SizedBox(
//               width: 250.w,
//               height: 48.h,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(profileName,style: OStyles.h6Bold),
//                   Text(profileMessage,style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale500)),
//
//                 ],
//               ),
//             ),
//             const Expanded(child: SizedBox()),
//             Column(
//               children: [
//                 Container(
//                   height: 25.h,
//                   width: 25.w,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(50.r),
//                     gradient: AppGradients.purpleGradient
//                   ),
//                   child: Center(
//                     child: Text(numOfMessage,style: OStyles.bodyXSmallRegular.copyWith(color: OColors.whiteColor)),
//                   ),
//                 ),
//                 SizedBox(height: 9.5.h),
//                 Text(date),
//               ],
//             )
//
//           ],
//         ),
//       ),
//     );
//   }
// }
