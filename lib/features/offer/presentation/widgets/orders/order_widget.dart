import 'package:lottie/lottie.dart';
import 'package:osta/utils/constants/exports.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({Key? key,
    required this.warranty,
    required this.serviceName,
    required this.maxAllowedPrice,
    required this.status,
    this.description,
    required this.imageUrls, required this.orderRef,
    required this.onTap, required this.totalPendingOffers,
  });

  final String warranty, status, serviceName, maxAllowedPrice;
  final String? description;
  final int orderRef, totalPendingOffers;
  final List<String> imageUrls;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWellWidget(
      onTap: onTap,
      child: Container(
    width: double.infinity,
    height: ODeviceUtils.getScreenHeight(context) / 5,
    padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 20.w),
    margin: EdgeInsets.only(bottom: 20.h),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        color: OColors.greyScale50,
        boxShadow: [AppBoxShadows.cardShadowTwo]
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                  children: [
                    TextSpan(text: '${AppLocalizations.of(context)!.translate('orderRef')!} ', style: OStyles.bodyLargeBold),
                    TextSpan(text: orderRef.toString(), style: OStyles.bodyLargeRegular.copyWith(color: OColors.primaryColor500)),
                  ]
              ),
            ),

            RichText(
              text: TextSpan(
                  children: [
                    TextSpan(text: '${AppLocalizations.of(context)!.translate('numberOfOffers')!} ', style: OStyles.bodyLargeBold),
                    TextSpan(text: totalPendingOffers.toString(), style: OStyles.bodyLargeRegular.copyWith(color: OColors.primaryColor500)),
                  ]
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        Divider(thickness: .5.h),

        SizedBox(height: 24.h),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(text: '${AppLocalizations.of(context)!.translate('warrant')!} ', style: OStyles.bodyLargeSemiBold),
                              TextSpan(text: warranty, style: OStyles.bodyLargeRegular.copyWith(color: OColors.primaryColor500)),
                            ]
                        ),
                      ),

                      RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(text: '${AppLocalizations.of(context)!.translate('serviceName')!} ', style: OStyles.bodyLargeSemiBold),
                              TextSpan(text: serviceName, style: OStyles.bodyLargeRegular.copyWith(color: OColors.primaryColor500)),
                            ]
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(text: '${AppLocalizations.of(context)!.translate('status')!} ', style: OStyles.bodyLargeSemiBold),
                              TextSpan(text: status, style: OStyles.bodyLargeRegular.copyWith(color: OColors.primaryColor500)),
                            ],
                        ),
                      ),

                      RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(text: '${AppLocalizations.of(context)!.translate('maxAllowedPrice')!} ', style: OStyles.bodyLargeSemiBold),
                              TextSpan(text: maxAllowedPrice, style: OStyles.bodyLargeRegular.copyWith(color: OColors.primaryColor500)),
                            ]
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  description == null ? SizedBox() :RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: '${AppLocalizations.of(context)!.translate('description')!} ', style: OStyles.bodyLargeBold),
                          TextSpan(text: description, style: OStyles.bodyLargeRegular.copyWith(color: OColors.primaryColor500)),
                        ]
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   flex: 1,
            //   child: imageUrls.isEmpty
            //       ? CircleAvatar(
            //     radius: 40.r,
            //     backgroundImage: const AssetImage(OImages.profileImage),
            //   )
            //       : ListView.builder(
            //     itemCount: imageUrls.length,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (context, index) {
            //       if (imageUrls[index].startsWith('http://')) {
            //         return CircleAvatar(
            //           radius: 40.r,
            //           backgroundImage: NetworkImage(imageUrls[index]),
            //         );
            //       } else {
            //         return CircleAvatar(
            //           radius: 40.r,
            //           backgroundImage: NetworkImage(imageUrls[index]),
            //         );
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
      ],
    ),
  ),
    );
  }
}