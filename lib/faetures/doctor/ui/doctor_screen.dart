import 'package:brite_eye/core/extentions/color_theme.dart';
import 'package:brite_eye/core/extentions/text_theme.dart';
import 'package:brite_eye/core/helpers/date_formater.dart';
import 'package:brite_eye/core/helpers/navigation_helper.dart';
import 'package:brite_eye/core/shared/widgets/app_button.dart';
import 'package:brite_eye/core/shared/widgets/doctor_tile.dart';
import 'package:brite_eye/faetures/doctor/logic/doctor_provider.dart';
import 'package:brite_eye/faetures/profile/logic/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../all_doctors/models/doctor.dart';
import '../../all_doctors/ui/doctors_screen.dart';

class DoctorScreen extends StatelessWidget {
  static const String id = '/doctor';

  const DoctorScreen({super.key, required this.doctorProvider});

  final DoctorProvider doctorProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.doctorSelected() && userProvider.childSelected()) {
            return ChangeNotifierProvider.value(
              value: doctorProvider,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DoctorTile(
                        doctor: userProvider.selectedDoctor!,
                      ),
                      Consumer<DoctorProvider>(
                        builder: (context, provider, child) {
                          return ExpansionTile(
                            initiallyExpanded: true,
                            title: Text("Sessions"),
                            children: buildSessionList(provider, context),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return ConnectWithDoctor(
              onTap: () {
                NavigationHelper.push<Doctor?>(DoctorsScreen.id);
              },
              childSelected: userProvider.childSelected(),
            );
          }
        },
      ),
    );
  }

  List<Widget> buildSessionList(DoctorProvider provider, BuildContext context) {
    final sessions = provider.response?.data;
    return (provider.response?.complete() ?? false)
        ? sessions!
            .map((session) => Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.symmetric(
                  vertical: 14.h,
                  horizontal: 16.w,
                ),
                decoration: BoxDecoration(
                  color: context.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Info(
                      hint: "Vision Level: ",
                      info: session.visionLevelString ?? "",
                    ),
                    Info(
                      hint: "Date: ",
                      info: DateFormatter.formatToYYYYMMDD(session.sessionDate),
                    ),
                    Info(
                      hint: "description: ",
                      info: session.description ?? "",
                    ),
                  ],
                )))
            .toList()
        : [];
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.hint,
    required this.info,
  });

  final String hint;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            hint,
            style: context.headlineMedium.copyWith(fontSize: 16.sp),
          ),
          Text(info),
        ],
      ),
    );
  }
}

class ConnectWithDoctor extends StatelessWidget {
  const ConnectWithDoctor({
    super.key,
    required this.onTap,
    required this.childSelected,
  });

  final VoidCallback onTap;
  final bool childSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Want to connect with a doctor?",
            style: context.headlineMedium.copyWith(
              fontSize: 20,
            ),
          ),
          if (!childSelected)
            Text(
              "Select a child to connect with a doctor",
              style: context.titleMedium,
            ),
          Text(
            "Select a doctor to connect with",
            style: context.titleMedium,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32.h),
            child: AppButton(
              hint: "Select Doctor",
              foregroundColor: context.surface,
              background: context.primary,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
