import 'package:brite_eye/core/di/service_locator.dart';
import 'package:brite_eye/core/helpers/navigation_helper.dart';
import 'package:brite_eye/core/shared/controllers/langprovider.dart';
import 'package:brite_eye/faetures/all_children/logic/children_provider.dart';
import 'package:brite_eye/faetures/all_children/ui/children_screen.dart';
import 'package:brite_eye/faetures/all_doctors/ui/doctors_screen.dart';
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
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Consumer<LangProvider>(
            builder: (context, provider, child) {
              return ListTile(
                leading: Icon(Icons.language),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: DropdownButton<String>(
                        value: provider.currentLocale.languageCode,
                        underline: Container(),
                        isExpanded: true,
                        isDense: true,
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
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: const Text("Add Child"),
            onTap: () {
              NavigationHelper.push(ChildFormScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: const Text("All Children"),
            onTap: () {
              locator<ChildrenProvider>().performRequest();
              NavigationHelper.push(ChildrenScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.local_hospital),
            title: const Text("All Doctors"),
            onTap: () {
              NavigationHelper.push(DoctorsScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
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
