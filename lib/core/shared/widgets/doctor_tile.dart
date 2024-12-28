import 'package:brite_eye/core/extentions/color_theme.dart';
import 'package:brite_eye/core/extentions/text_theme.dart';
import 'package:brite_eye/faetures/all_doctors/models/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorTile extends StatelessWidget {
  const DoctorTile({
    super.key,
    this.selected,
    required this.doctor,
    this.onTapSelect,
  });

  final bool? selected;
  final Doctor doctor;
  final VoidCallback? onTapSelect;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected ?? false,
      selectedColor: context.surface,
      selectedTileColor: context.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      onTap: () {
        // NavigationHelper.push(DoctorFormScreen.id,
        //     extra: doctors[index]);
      },
      title: Text(
        doctor.name ?? "",
        style: context.headlineMedium
            .copyWith(color: (selected ?? false) ? context.surface : null),
      ),
      subtitle: PannableRatingBar(
        alignment: WrapAlignment.start,
        rate: doctor.rating ?? 0,
        items: List.generate(
            5,
            (index) => const RatingWidget(
                  selectedColor: Colors.yellow,
                  unSelectedColor: Colors.grey,
                  child: Icon(
                    Icons.star,
                  ),
                )),
      ),
      trailing: selected == null
          ? null
          : selected!
              ? Icon(Icons.check)
              : TextButton(
                  child: Text(
                    "select",
                    style: context.labelSmall.copyWith(
                      color: selected! ? context.surface : context.primary,
                    ),
                  ),
                  onPressed: onTapSelect,
                ),
    );
  }
}
