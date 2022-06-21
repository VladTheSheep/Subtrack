import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:subtrack/consts/colors.dart';
import 'package:subtrack/consts/sizes.dart';
import 'package:subtrack/navigation/nav.dart';
import 'package:subtrack/pages/landing_page/prompt_header.dart';
import 'package:subtrack/providers.dart';
import 'package:subtrack/widgets/buttons/custom_button.dart';

class StoragePrompt extends StatelessWidget {
  const StoragePrompt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: elevation,
      child: Container(
        width: Nav().screenWidth - (Nav().screenWidth / 5),
        height: Nav().screenHeight - (Nav().screenHeight / 1.5),
        decoration: BoxDecoration(
          color: bgColorMat,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          children: const [
            SizedBox(
              width: double.infinity,
              child: WelcomeHeader(
                headerText: "Request Permissions",
                noProgressBar: true,
              ),
            ),
            Expanded(
              child: _StoragePromptView(),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoragePromptView extends StatelessWidget {
  const _StoragePromptView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Consumer(
            builder: (context, ref, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Column(
                  children: const [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Requires the following permissions to work",
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "- Manage External Storage",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      FaIcon(FontAwesomeIcons.lightHdd),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Required to store your database',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "- Storage",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      FaIcon(FontAwesomeIcons.lightFolderOpen),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Required to read/write to the database',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Consumer(
            builder: (context, ref, child) {
              return CustomButton(
                text: "Grant permissions",
                color: cannabisColorMat,
                radius: const BorderRadius.vertical(bottom: Radius.circular(borderRadius)),
                callback: (val) {
                  ref.watch(storagePermissionsNotifierProvider.notifier).grantPermissions();
                },
                callbackValue: false,
              );
            },
          ),
        ),
      ],
    );
  }
}
