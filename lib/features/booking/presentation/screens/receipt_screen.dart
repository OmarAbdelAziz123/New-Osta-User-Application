import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/features/booking/managers/booking_cubit.dart';
import 'package:osta_user_app/features/booking/models/get_orders_by_filter_model.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/formatters/formatter.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key, required this.data});

  final Map data;

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  final List<SubServices> subServices = [];

  SubServices? selectedService;

  bool isOpened = false;
  bool dataFetched = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    if(!dataFetched) {
      BookingCubit.get(context).getReceiptFunction(orderId: widget.data['orderId']);
      setState(() {
        dataFetched = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.greyScale50,
      // appBar: AppBar(
      //   title: Text('${widget.orderId}'),
      // ),
      body: BlocBuilder<BookingCubit, BookingState>(
          builder: (context, state) {
            var bookingCubit = BookingCubit.get(context);

            return Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
              child: Column(
                children: [
                  /// App Bar
                  TopRowInAllScreens(
                    titleOfScreenWidget: Text('E-Receipt', style: OStyles.h4Bold),
                    onTap: () {
                      BookingCubit.get(context).clearReceiptData();
                      context.pop();
                    },
                  ),

                  /// Make Space
                  SizedBox(height: 24.h),

                  bookingCubit.receiptModel == null || bookingCubit.receiptModel!.result == null
                      ? Center(child: LoadingWidget(iconColor: OColors.primaryColor500))
                      :  Expanded(child: SingleChildScrollView(
                    child:  Column(
                      children: [
                        /// Bar Code
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: SvgPicture.asset(OImages.barcode, fit: BoxFit.scaleDown),
                        ),

                        /// Make Space
                        SizedBox(height: 20.h),

                        /// Container In Top
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Services', style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale700)),
                                  Text(ODeviceUtils.capitalizeFirstLetter(bookingCubit.receiptModel!.result!.details!.service!), style: OStyles.bodyLargeSemiBold.copyWith(color: OColors.greyScale800)),
                                ],
                              ),

                              /// Make Space
                              SizedBox(height: 20.h),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Category', style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale700)),
                                  Text(ODeviceUtils.capitalizeFirstLetter(bookingCubit.receiptModel!.result!.details!.service!), style: OStyles.bodyLargeSemiBold.copyWith(color: OColors.greyScale800)),
                                ],
                              ),

                              /// Make Space
                              SizedBox(height: 20.h),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Workers', style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale700)),
                                  Text(ODeviceUtils.capitalizeFirstLetter(bookingCubit.receiptModel!.result!.details!.worker!), style: OStyles.bodyLargeSemiBold.copyWith(color: OColors.greyScale800)),
                                ],
                              ),

                              /// Make Space
                              SizedBox(height: 20.h),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Date & Time', style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale700)),
                                  Text(ODeviceUtils.capitalizeFirstLetter(OFormatter.formatDateTime(bookingCubit.receiptModel!.result!.createdAt!)), style: OStyles.bodyLargeSemiBold.copyWith(color: OColors.greyScale800)),
                                ],
                              ),
                              /// Make Space
                              SizedBox(height: 20.h),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Working Hours', style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale700)),
                                  Text(ODeviceUtils.capitalizeFirstLetter(bookingCubit.receiptModel!.result!.details!.workingInMinutes == '' ? 'Undefined' : bookingCubit.receiptModel!.result!.details!.workingInMinutes!), style: OStyles.bodyLargeSemiBold.copyWith(color: OColors.greyScale800)),
                                ],
                              ),
                            ],
                          ),
                        ),

                        /// Make Space
                        SizedBox(height: 20.h),

                        /// Sub Services
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isOpened = !isOpened;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ODeviceUtils.capitalizeFirstLetter('${bookingCubit.receiptModel!.result!.details!.service!} Details'),
                                      style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale700),
                                    ),
                                    SvgPicture.asset(isOpened ? OImages.arrowBottom : OImages.arrowBottom),
                                  ],
                                ),
                                AnimatedCrossFade(
                                  firstChild: Container(),
                                  secondChild: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: bookingCubit.receiptModel!.result!.order!.subServices!.length,
                                    itemBuilder: (context, index) {
                                      return Text(
                                        '- ${bookingCubit.receiptModel!.result!.order!.subServices![index].name!}',
                                        style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale700),
                                      );
                                    },
                                  ),
                                  crossFadeState: isOpened ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                  duration: const Duration(milliseconds: 300),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// Make Space
                        SizedBox(height: 20.h),

                        /// Container In Bottom
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Amount', style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale700)),
                                  Text(ODeviceUtils.capitalizeFirstLetter('\$${bookingCubit.receiptModel!.result!.total}'), style: OStyles.bodyLargeSemiBold.copyWith(color: OColors.greyScale800)),
                                ],
                              ),

                              /// Make Space
                              SizedBox(height: 20.h),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Promo', style: OStyles.bodyMediumMedium.copyWith(color: OColors.primaryColor400)),
                                  Text(ODeviceUtils.capitalizeFirstLetter('-\$${bookingCubit.receiptModel!.result!.discount}'), style: OStyles.bodyLargeSemiBold.copyWith(color: OColors.primaryColor400)),
                                ],
                              ),

                              /// Make Space
                              SizedBox(height: 20.h),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Payment Methods', style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale700)),
                                  Text(ODeviceUtils.capitalizeFirstLetter(bookingCubit.receiptModel!.result!.paymentMethod!), style: OStyles.bodyLargeSemiBold.copyWith(color: OColors.greyScale800)),
                                ],
                              ),

                              /// Make Space
                              SizedBox(height: 20.h),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Date', style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale700)),
                                  Text(ODeviceUtils.capitalizeFirstLetter(OFormatter.formatDateTime(bookingCubit.receiptModel!.result!.createdAt!)), style: OStyles.bodyLargeSemiBold.copyWith(color: OColors.greyScale800)),
                                ],
                              ),
                              /// Make Space
                              SizedBox(height: 20.h),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Transaction ID', style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale700)),
                                  GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(text: bookingCubit.receiptModel!.result!.invoiceNumber!));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: const Text('Copied to clipboard'), backgroundColor: OColors.primaryColor400),
                                      );
                                    },
                                    child: SizedBox(
                                        width: ODeviceUtils.getScreenWidth(context) / 2.6,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Text(ODeviceUtils.capitalizeFirstLetter('${bookingCubit.receiptModel!.result!.invoiceNumber}'), style: OStyles.bodyLargeSemiBold.copyWith(color: OColors.greyScale800), overflow: TextOverflow.ellipsis),
                                            ),
                                            Expanded(child: SvgPicture.asset(OImages.copyIcon)),
                                          ],
                                        )
                                    ),
                                  ),
                                ],
                              ),

                              /// Make Space
                              SizedBox(height: 20.h),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Status', style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale700)),
                                  Container(
                                    color: OColors.purpleTransparent.withOpacity(.08),
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                                    child: Text(ODeviceUtils.capitalizeFirstLetter(bookingCubit.receiptModel!.result!.status!), style: OStyles.bodyXSmallSemiBold.copyWith(color: OColors.primaryColor500), overflow: TextOverflow.ellipsis),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),),

                ],
              ),
            );
          }
      ),
    );
  }
}