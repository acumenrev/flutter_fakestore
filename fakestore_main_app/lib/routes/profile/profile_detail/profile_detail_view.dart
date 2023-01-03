import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakestore_main_app/app_utils.dart';
import 'package:fakestore_main_app/constants/color_constants.dart';
import 'package:fakestore_main_app/constants/image_constants.dart';
import 'package:fakestore_main_app/routes/profile/profile_detail/profile_detail_controller.dart';
import 'package:fakestore_main_app/ui/app_ios_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileDetailView extends StatefulWidget {
  ProfileDetailView({super.key, required this.controller});

  late ProfileDetailInterface controller;

  @override
  State<ProfileDetailView> createState() => _ProfileDetailViewState();
}

class _ProfileDetailViewState extends State<ProfileDetailView> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerEmail.text = "sdsd";
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: FSIOSNavigationBar.create(
          middleText: AppUtils.getLocalizationContext(context)
              .profile_profile_menu_profile_details_title,
          backButtonPressed: () {
            context.pop();
          }),
      child: Container(
        color: Colors.white,
        child: ListView(
          children: _buildMainUI(),
        ),
      ),
    );
  }

  _buildMainUI() {
    List<Widget> listWidget = [];
    listWidget.add(_buildImageCover());
    listWidget.add(_buildNameField());
    listWidget.add(_buildEmailField());
    listWidget.add(_buildPasswordField());
    return listWidget;
  }

  // avatar
  _buildImageCover() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: Container(
        height: 180,
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: 180,
            height: 180,
            color: Colors.transparent,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: CachedNetworkImage(
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Image.asset(ImageConstants.avatarPlaceholder),
                      imageUrl:
                          "https://images.unsplash.com/photo-1561045439-ce8ec5bc42f8?ixlib=rb-1.2.1&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjEyMDd9",
                    ),
                  ),
                ),
                Positioned(
                  right: -15.0,
                  bottom: -15.0,
                  child: CupertinoButton(
                    onPressed: _editAvatarHandler,
                    pressedOpacity: 0.8,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.blue,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: Offset(1, 1), // Shadow position
                            )
                          ]),
                      child: const Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _editAvatarHandler() {
    debugPrint("_editAvatarHandler");
    _showAvatarActionSheet();
  }

  _buildDataField(
      {required IconData icon,
      required String title,
      required String value,
      bool isPassword = false,
      bool isEditable = false,
      String trailingButtonText = "",
      VoidCallback? onTap = null,
      TextEditingController? textEditController}) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0),
      child: Container(
        height: 60.0,
        child: Row(
          children: [
            // icon
            Container(
              width: 60,
              child: Center(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.blue,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
                width: 1.0,
                color: Colors.black12,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 14.0,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  // value
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 0.0),
                    child: CupertinoTextField(
                      controller: textEditController,
                      keyboardType: TextInputType.text,
                      enabled: isEditable,
                      obscureText: isPassword,
                      style: const TextStyle(fontSize: 16),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent)),
                    ),
                  )
                ],
              ),
            ),
            trailingButtonText.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: CupertinoButton(
                      onPressed: onTap,
                      child: Text(
                        trailingButtonText,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  )
                : Container()
            // trailing button
          ],
        ),
        decoration: BoxDecoration(
            color: ColorConstants.colorF7F7F7,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.black12)),
      ),
    );
  }

  // email
  _buildEmailField() {
    return _buildDataField(
        icon: Icons.email_outlined,
        title: AppUtils.getLocalizationContext(context).profile_detail_email,
        value: "",
        isEditable: false,
        isPassword: false,
        textEditController: _controllerEmail);
  }

  // name
  _buildNameField() {
    return _buildDataField(
        icon: Icons.person_outline_outlined,
        title: AppUtils.getLocalizationContext(context).profile_detail_name,
        value: "",
        isEditable: true,
        isPassword: false,
        textEditController: _controllerName);
  }

  // Password field
  _buildPasswordField() {
    return _buildDataField(
        icon: Icons.key_outlined,
        title: AppUtils.getLocalizationContext(context).profile_detail_password,
        value: "",
        isEditable: false,
        isPassword: true,
        textEditController: _controllerPassword,
        trailingButtonText: AppUtils.getLocalizationContext(context)
            .profile_detail_change_password,
        onTap: () {
          debugPrint("_buildPasswordField");
        });
  }

  _showAvatarActionSheet() {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {/*...*/},
                    child: Text(AppUtils.getLocalizationContext(context)
                        .profile_detail_view_avatar)),
                CupertinoActionSheetAction(
                    onPressed: () {/*...*/},
                    child: Text(AppUtils.getLocalizationContext(context)
                        .profile_detail_change_avatar)),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () => _close(context),
                child: const Text('Close'),
              ),
            ));
  }

  void _close(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }
}
