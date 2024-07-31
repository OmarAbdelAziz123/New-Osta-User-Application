import 'package:contacts_service/contacts_service.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:permission_handler/permission_handler.dart';


class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({super.key});

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  List<Contact> _contacts = [];
  bool _isLoading = true;
  bool isInvite = false;

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  Future<void> _getContacts() async {
    PermissionStatus permissionStatus = await Permission.contacts.request();
    if (permissionStatus.isGranted) {
      Iterable<Contact> contacts = await ContactsService.getContacts();
      setState(() {
        _contacts = contacts.toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.greyScale50,
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
        child: Column(
          children: [
            /// Arrow Button
            TopRowInAllScreens(titleOfScreenWidget: Text(AppLocalizations.of(context)!.translate('inviteFriends')!, style: OStyles.h4Bold)),

            _isLoading
                ? Expanded(child: Center(child: LoadingWidget(iconColor: OColors.primaryColor500)))
                : Expanded(child: ListView.builder(
              itemCount: _contacts.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                Contact contact = _contacts[index];
                return ContactContainerWidget(contact: contact);
              },
            ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactContainerWidget extends StatefulWidget {
  ContactContainerWidget({super.key, required this.contact});
  Contact contact;

  @override
  State<ContactContainerWidget> createState() => _ContactContainerWidgetState();
}

class _ContactContainerWidgetState extends State<ContactContainerWidget> {
  List<Contact> _contacts = [];
  bool _isLoading = true;
  bool isInvite = false;

  @override
  void initState() {
    super.initState();
    _getContacts();
  }

  Future<void> _getContacts() async {
    PermissionStatus permissionStatus = await Permission.contacts.request();
    if (permissionStatus.isGranted) {
      Iterable<Contact> contacts = await ContactsService.getContacts();
      setState(() {
        _contacts = contacts.toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: (
            widget.contact.avatar != null && widget.contact.avatar!.isNotEmpty)
            ? CircleAvatar(
          backgroundImage: MemoryImage(widget.contact.avatar!),
        )
            : CircleAvatar(
          child: Text(widget.contact.initials(), style: OStyles.bodyXLargeSemiBold),
        ),
        title: Text(widget.contact.displayName ?? '', style: OStyles.bodyXLargeSemiBold.copyWith(color: OColors.primaryColor500)),
        subtitle: Text(widget.contact.phones!.isNotEmpty ? widget.contact.phones!.first.value ?? '' : '', style: OStyles.bodyXLargeSemiBold),
        trailing: GestureDetector(
          onTap: () {
            setState(() {
              isInvite = !isInvite;
            });
          },
          child: Container(
            width: 68.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: isInvite ? OColors.whiteColor : OColors.primaryColor500,
              border: Border.all(color: OColors.primaryColor500, width: 2.w),
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Center(child: Text(isInvite ? AppLocalizations.of(context)!.translate('invited')! : AppLocalizations.of(context)!.translate('invite')!, style: OStyles.bodyMediumSemiBold.copyWith(color: isInvite ? OColors.primaryColor500 : OColors.whiteColor))),
          ),
        )
    );
  }
}

