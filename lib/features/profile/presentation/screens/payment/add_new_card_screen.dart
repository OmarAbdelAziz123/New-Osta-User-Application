import 'package:osta/utils/constants/exports.dart';

class AddNewCardScreen extends StatelessWidget {
  const AddNewCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// App Bar
              AppBarWidget(
                leading: InkWellWidget(onTap: () => context.pop(), child: const Icon((Icons.arrow_back))),
                title: 'Add New Card',
                actions: SvgPicture.asset(OImages.moreIcon),
                widthOfText: 282.w,
              ),

              /// Make Space
              SizedBox(height: 24.h),

              Image.asset(OImages.cardImage),

              /// Make Space
              SizedBox(height: 24.h),

              AddNewCardForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class AddNewCardForm extends StatefulWidget {
  const AddNewCardForm({super.key});

  @override
  State<AddNewCardForm> createState() => _AddNewCardFormState();
}

class _AddNewCardFormState extends State<AddNewCardForm> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expireDateNumberController = TextEditingController();
  TextEditingController cvvNumberController = TextEditingController();

  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode cardNumberFocusNode = FocusNode();
  final FocusNode expireDateNumberFocusNode = FocusNode();
  final FocusNode cvvNumberFocusNode = FocusNode();

  bool isFullNameFieldFocused = false;
  bool isCardNumberFieldFocused = false;
  bool isExpireDateNumberFieldFocused = false;
  bool isCvvNumberFieldFocused = false;

  @override
  void initState() {
    super.initState();
    /// Add listener to focus node
    fullNameFocusNode.addListener(() => setState(() => isFullNameFieldFocused = fullNameFocusNode.hasFocus));
    cardNumberFocusNode.addListener(() => setState(() => isCardNumberFieldFocused = cardNumberFocusNode.hasFocus));
    expireDateNumberFocusNode.addListener(() => setState(() => isExpireDateNumberFieldFocused = expireDateNumberFocusNode.hasFocus));
    cvvNumberFocusNode.addListener(() => setState(() => isCvvNumberFieldFocused = cvvNumberFocusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    fullNameFocusNode.dispose();
    cardNumberFocusNode.dispose();
    expireDateNumberFocusNode.dispose();
    cvvNumberFocusNode.dispose();
    fullNameController.dispose();
    cardNumberController.dispose();
    expireDateNumberController.dispose();
    cvvNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Card Name', style: OStyles.bodyXLargeBold),
        /// Make Space
        SizedBox(height: 12.h),

        /// Full Name
        TextFormFieldWidget(
          controller: fullNameController,
          textInputType: TextInputType.name,
          focusNode: fullNameFocusNode,
          hintText: 'Andrew Ainsley',
          hintColor: isFullNameFieldFocused ? OColors.primaryColor500 : OColors.greyScale900,
          fillColor: isFullNameFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
          borderSide: isFullNameFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
          obscureText: false,
          isEdit: true,
        ),

        /// Make Space
        SizedBox(height: 24.h),

        Text('Card Number', style: OStyles.bodyXLargeBold),
        /// Make Space
        SizedBox(height: 12.h),

        /// Card Number
        TextFormFieldWidget(
          controller: cardNumberController,
          textInputType: TextInputType.datetime,
          focusNode: cardNumberFocusNode,
          hintText: '2673 4374 8483 95874',
          hintColor: isFullNameFieldFocused ? OColors.primaryColor500 : OColors.greyScale900,
          fillColor: isCardNumberFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
          borderSide: isCardNumberFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
          obscureText: false,
          inputFormatters: [DateInputFormatter()],
          isEdit: true,
        ),

        /// Make Space
        SizedBox(height: 24.h),

        Row(
          children: [
            Expanded(
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Expiry Date', style: OStyles.bodyXLargeBold),
                  /// Make Space
                  SizedBox(height: 12.h),

                  TextFormFieldWidget(
                    controller: expireDateNumberController,
                    textInputType: TextInputType.datetime,
                    focusNode: expireDateNumberFocusNode,
                    hintText: '09/07/26',
                    hintColor: isExpireDateNumberFieldFocused ? OColors.primaryColor500 : OColors.greyScale900,
                    suffixIcon: SvgPicture.asset(OImages.calendarIconNotSelected, fit: BoxFit.scaleDown, colorFilter: ColorFilter.mode(isExpireDateNumberFieldFocused ? OColors.primaryColor500 : expireDateNumberController.text.isNotEmpty ? OColors.greyScale900 : OColors.greyScale500, BlendMode.srcIn)),
                    fillColor: isExpireDateNumberFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
                    borderSide: isExpireDateNumberFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                    obscureText: false,
                    inputFormatters: [DateInputFormatter()],
                    isEdit: true,
                  ),
                ],
              ),
            ),

            /// Make Space
            SizedBox(width: 20.w),

            Expanded(
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CVV', style: OStyles.bodyXLargeBold),
                  /// Make Space
                  SizedBox(height: 12.h),

                  TextFormFieldWidget(
                    controller: expireDateNumberController,
                    textInputType: TextInputType.datetime,
                    focusNode: expireDateNumberFocusNode,
                    hintText: '699',
                    hintColor: isExpireDateNumberFieldFocused ? OColors.primaryColor500 : OColors.greyScale900,
                    fillColor: isExpireDateNumberFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
                    borderSide: isExpireDateNumberFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                    obscureText: false,
                    inputFormatters: [DateInputFormatter()],
                    isEdit: true,
                  ),
                ],
              ),
            ),
          ],
        ),

        /// Make Space
        SizedBox(height: 60.h),

        MainButtonWidget(
          centerWidgetInButton: Text('Add New Card', style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)),
          onTap: () => context.pushNamed(ORoutesName.otpRoute),
          margin: EdgeInsets.zero,
          buttonColor: fullNameController.text.isEmpty || cardNumberController.text.isEmpty || expireDateNumberController.text.isEmpty || cvvNumberController.text.isEmpty ? OColors.disabledButton : OColors.primaryColor500,
          boxShadow: fullNameController.text.isEmpty || cardNumberController.text.isEmpty || expireDateNumberController.text.isEmpty || cvvNumberController.text.isEmpty  ? [] : [AppBoxShadows.buttonShadowOne],
        ),
      ],
    );
  }
}
