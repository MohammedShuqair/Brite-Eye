import 'package:brite_eye/core/helpers/navigation_helper.dart';
import 'package:brite_eye/core/shared/controllers/langprovider.dart';
import 'package:brite_eye/faetures/child/ui/child_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/data/local/shared_preferences.dart';
import '../../auth/ui/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Consumer<LangProvider>(
            builder: (context, provider, child) {
              return ListTile(
                title: DropdownButton<String>(
                  value: provider.currentLocale.languageCode,
                  items: provider.supportedLocales
                      .map((locale) => DropdownMenuItem(
                            value: locale.languageCode,
                            child: Text(locale.languageCode),
                          ))
                      .toList(),
                  onChanged: (v) {
                    provider.changeLocale(v);
                  },
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Add Child"),
            onTap: () {
              NavigationHelper.push(ChildFormScreen.id);
            },
          ),
          ListTile(
            title: const Text("logout"),
            onTap: () async {
              NavigationHelper.showSnackBar("logged out successfully",
                  isError: false);
              await SharedHelper.clear();
              NavigationHelper.pushAndRemoveUntil(LoginScreen.id);

              // Navigator.of(context).pushReplacementNamed('/login');
            },
          )
        ],
      )),
    );
  }
}
