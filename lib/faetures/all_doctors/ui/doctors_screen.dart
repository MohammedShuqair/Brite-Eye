import 'package:brite_eye/core/di/service_locator.dart';
import 'package:brite_eye/core/shared/widgets/loadable_screen.dart';
import 'package:brite_eye/core/shared/widgets/ssized_box.dart';
import 'package:brite_eye/faetures/all_doctors/logic/doctor_provider.dart';
import 'package:brite_eye/faetures/profile/logic/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/shared/widgets/doctor_tile.dart';
import '../models/doctor.dart';

class DoctorsScreen extends StatelessWidget {
  static const String id = '/doctors/all';

  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>
          DoctorsProvider(childRepository: locator()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Doctors",
          ),
        ),
        body: Consumer2<DoctorsProvider, UserProvider>(
          builder: (context, provider, userProvider, child) {
            List<Doctor> doctors = provider.response?.data ?? [];
            return LoadableScreen(
              isLoading: provider.isLoading(),
              child: ListView.separated(
                padding: EdgeInsets.all(24.r),
                itemBuilder: (_, index) {
                  var selected =
                      userProvider.isDoctorSelected(doctors[index].id);
                  return DoctorTile(
                      onTapSelect: () {
                        userProvider.saveSelectedDoctor(doctors[index]);
                      },
                      selected: selected,
                      doctor: doctors[index]);
                },
                separatorBuilder: (_, __) => SSizedBox(
                  height: 16,
                ),
                itemCount: doctors.length,
              ),
            );
          },
        ),
      ),
    );
  }
}
