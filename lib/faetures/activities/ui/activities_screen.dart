import 'package:brite_eye/core/extentions/color_theme.dart';
import 'package:brite_eye/core/extentions/text_theme.dart';
import 'package:brite_eye/core/helpers/navigation_helper.dart';
import 'package:brite_eye/core/shared/widgets/app_button.dart';
import 'package:brite_eye/core/shared/widgets/ssized_box.dart';
import 'package:brite_eye/faetures/child/model/child_model.dart';
import 'package:brite_eye/faetures/profile/logic/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../child/ui/child_form_screen.dart';
import '../examination/ishihara/ui/ishihara_screen.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        final selectedChildName = provider.selectedChild?.name;
        final title = selectedChildName != null
            ? "Welcome $selectedChildName\nto Brite Eye"
            : "Welcome\nto Brite Eye";
        return SafeArea(
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: context.titleLarge,
                  ),
                  SSizedBox(
                    height: 24.h,
                  ),
                  Visibility(
                    visible: provider.childSelected(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Examination 📝 ⎚-⎚",
                          style: context.bodyLarge,
                        ),
                        SSizedBox(
                          height: 24.h,
                        ),
                        ListTile(
                          onTap: () {
                            NavigationHelper.push(IshiharaScreen.id);
                          },
                          tileColor: context.secondaryContainer,
                          leading: const Icon(
                            Icons.remove_red_eye,
                            size: 30,
                          ),
                          title: Text(
                            "Ishihara Test",
                            style: context.bodyLarge.copyWith(
                              color: context.onSurface,
                            ),
                          ),
                        ),
                        SSizedBox(
                          height: 32.h,
                        ),
                        Text(
                          "Vision Therapy 👩🏽‍⚕️",
                          style: context.bodyLarge,
                        ),
                        SSizedBox(
                          height: 24.h,
                        ),
                        ListTile(
                          onTap: () async {
                            final url =
                                "https://www.youtube.com/watch?v=mqXR8O2VJLo";
                            await _launchUrl(url);
                          },
                          tileColor: context.secondaryContainer,
                          leading: const Icon(
                            Icons.link,
                            size: 30,
                          ),
                          title: Text(
                            "voka. by",
                            style: context.bodyLarge.copyWith(
                              color: context.onSurface,
                            ),
                          ),
                        ),
                        SSizedBox(
                          height: 4,
                        ),
                        ListTile(
                          onTap: () async {
                            final url =
                                "https://www.youtube.com/watch?v=LXYkM28SEFc";
                            await _launchUrl(url);
                          },
                          tileColor: context.secondaryContainer,
                          leading: const Icon(
                            Icons.link,
                            size: 30,
                          ),
                          title: Text(
                            "See In 3D",
                            style: context.bodyLarge.copyWith(
                              color: context.onSurface,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !provider.childSelected(),
                    child: AddChild(
                      onTap: () async {
                        final child = await NavigationHelper.push<Child?>(
                            ChildFormScreen.id);
                        provider.saveSelectedChild(child);
                      },
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }

  Future<void> _launchUrl(String url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class AddChild extends StatelessWidget {
  const AddChild({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Want to start playing? 🎮 👓",
          style: context.headlineMedium.copyWith(
            fontSize: 20,
          ),
        ),
        Text(
          "To get started, add a child",
          style: context.titleMedium,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 32.h),
          child: AppButton(
            hint: "Add Child",
            foregroundColor: context.surface,
            background: context.primary,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
