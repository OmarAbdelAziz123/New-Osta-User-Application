import 'package:osta_user_app/utils/constants/exports.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        context.pushReplacementNamed(ORoutesName.navigationMenuRoute, arguments: 3);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
            child: Column(
              children: [
                /// Arrow Button
                TopRowInAllScreens(titleOfScreenWidget: Text(AppLocalizations.of(context)!.translate('editProfile')!, style: OStyles.h4Bold), onTap: () => context.pushReplacementNamed(ORoutesName.navigationMenuRoute, arguments: 4)),

                /// Make Space
                SizedBox(height: 33.5.h),

                const EditProfileFormWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}