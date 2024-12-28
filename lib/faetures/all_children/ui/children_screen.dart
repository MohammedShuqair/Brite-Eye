import 'package:brite_eye/core/extentions/color_theme.dart';
import 'package:brite_eye/core/extentions/text_theme.dart';
import 'package:brite_eye/core/helpers/date_formater.dart';
import 'package:brite_eye/core/helpers/user_helper.dart';
import 'package:brite_eye/core/shared/widgets/app_button.dart';
import 'package:brite_eye/core/shared/widgets/loadable_screen.dart';
import 'package:brite_eye/core/shared/widgets/ssized_box.dart';
import 'package:brite_eye/faetures/all_children/logic/children_provider.dart';
import 'package:brite_eye/faetures/child/model/child_model.dart';
import 'package:brite_eye/faetures/profile/logic/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/helpers/navigation_helper.dart';
import '../../child/ui/child_form_screen.dart';

class ChildrenScreen extends StatefulWidget {
  static const String id = '/child/all';

  const ChildrenScreen({super.key});

  @override
  State<ChildrenScreen> createState() => _ChildrenScreenState();
}

class _ChildrenScreenState extends State<ChildrenScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final user = UserHelper.getUserFromLocal();
      if (user?.id != null) {
        locator<ChildrenProvider>().performRequest(params: user?.id);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Children",
        ),
      ),
      body: Consumer2<ChildrenProvider, UserProvider>(
        builder: (context, provider, userProvider, child) {
          List<Child> children = provider.response?.data ?? [];
          return LoadableScreen(
            isLoading: provider.isLoading(),
            child: children.isEmpty && !provider.isLoading()
                ? Center(
                    child: AppButton(
                        foregroundColor: context.surface,
                        background: context.primary,
                        hint: "Add Child",
                        onTap: () async {
                          final child = await NavigationHelper.push<Child?>(
                              ChildFormScreen.id);
                          if (child != null && userProvider.user?.id != null) {
                            provider.performRequest(
                                params: userProvider.user?.id);
                          }
                        }),
                  )
                : ListView.separated(
                    padding: EdgeInsets.all(24.r),
                    itemBuilder: (_, index) {
                      var selected =
                          userProvider.isChildSelected(children[index].userId);
                      return ListTile(
                        selected: selected,
                        selectedColor: context.surface,
                        selectedTileColor: context.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        onTap: () {
                          NavigationHelper.push(ChildFormScreen.id,
                              extra: children[index]);
                        },
                        title: Text(
                          children[index].name ?? "",
                          style: context.headlineMedium.copyWith(
                              color: selected ? context.surface : null),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date of Birth: ${DateFormatter.formatToYYYYMMDD(children[index].birthDate)}",
                            ),
                            Text(
                              "Vision Level: ${children[index].visionLevelString ?? ""}",
                            ),
                          ],
                        ),
                        trailing: selected
                            ? Icon(Icons.check)
                            : TextButton(
                                child: Text(
                                  "select",
                                  style: context.labelSmall.copyWith(
                                    color: selected
                                        ? context.surface
                                        : context.primary,
                                  ),
                                ),
                                onPressed: () {
                                  userProvider
                                      .saveSelectedChild(children[index]);
                                },
                              ),
                      );
                    },
                    separatorBuilder: (_, __) => SSizedBox(
                      height: 16,
                    ),
                    itemCount: children.length,
                  ),
          );
        },
      ),
    );
  }
}
