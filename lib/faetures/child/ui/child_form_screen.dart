import 'package:brite_eye/core/extentions/color_theme.dart';
import 'package:brite_eye/core/extentions/text_theme.dart';
import 'package:brite_eye/core/helpers/date_formater.dart';
import 'package:brite_eye/core/helpers/validator_helper.dart';
import 'package:brite_eye/core/shared/widgets/app_button.dart';
import 'package:brite_eye/core/shared/widgets/app_field.dart';
import 'package:brite_eye/core/shared/widgets/loadable_screen.dart';
import 'package:brite_eye/core/shared/widgets/ssized_box.dart';
import 'package:brite_eye/faetures/child/logic/child_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ChildFormScreen extends StatelessWidget {
  static const String id = '/child/form';

  const ChildFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var title = context.read<ChildFormProvider>().title;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: context.headlineMedium,
        ),
      ),
      body: Consumer<ChildFormProvider>(
        builder: (context, provider, child) {
          return LoadableScreen(
            isLoading: provider.isLoading(),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Form(
                  key: provider.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppField(
                        controller: provider.nameController,
                        label: "Name",
                        validator: ValidatorHelper.validateName,
                      ),
                      AppDatePicker(
                        onDateSelected: provider.setBirthDate,
                        label: 'Birthdate',
                        currentDate: provider.birthDate,
                        validator: ValidatorHelper.validateNotEmpty,
                      ),
                      AppDatePicker(
                        onDateSelected: provider.setLastExaminationDate,
                        label: 'Last Examination Date (optional)',
                        currentDate: provider.lastExaminationDate,
                        validator: ValidatorHelper.validateNotEmpty,
                      ), //vision level upper and lower values
                      SSizedBox(
                        height: 24,
                      ),
                      Text(
                        "Vision Level",
                        style: context.headlineMedium.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                      Text(
                        "like 4/6",
                        style: context.bodySmall.copyWith(),
                      ),
                      SSizedBox(
                        height: 4,
                      ),
                      VisionLevelFields(
                        lower: provider.visionLevelLowerController,
                        upper: provider.visionLevelUpperController,
                      ),
                      SSizedBox(
                        height: 24,
                      ),
                      AppField(
                        controller: provider.otherDetailsController,
                        label: "Other Details",
                        minLines: 5,
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 24,
        ),
        child: AppButton(
          onTap: () {
            context.read<ChildFormProvider>().performRequest();
          },
          hint: title,
          foregroundColor: context.surface,
          background: context.primary,
        ),
      ),
    );
  }
}

class AppDatePicker extends StatelessWidget {
  const AppDatePicker({
    super.key,
    this.currentDate,
    required this.onDateSelected,
    required this.label,
    this.validator,
  });

  final DateTime? currentDate;
  final Function(DateTime?) onDateSelected;
  final String label;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return AppField(
      readOnly: true,
      onTap: () {
        showDatePicker(
                context: context,
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime.now(),
                currentDate: currentDate)
            .then((date) {
          onDateSelected(date);
        });
      },
      controller: TextEditingController(
          text: DateFormatter.formatToYYYYMMDD(currentDate)),
      label: label,
      validator: validator,
    );
  }
}

class VisionLevelFields extends StatelessWidget {
  const VisionLevelFields({
    super.key,
    required this.lower,
    required this.upper,
  });

  final TextEditingController lower;
  final TextEditingController upper;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: AppField(
              controller: lower,
              label: "Ex:6",
              centerInput: true,
              validator: (v) {
                String? msg;
                msg = ValidatorHelper.validateInt(v);
                if (msg == null && upper.text.isNotEmpty) {
                  if (int.parse(v!) > int.parse(upper.text)) {
                    return "Lower value must be less than upper value";
                  }
                } else {
                  return msg;
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                Text(
                  "/",
                  style: context.headlineMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: AppField(
              controller: upper,
              label: "Ex:4",
              keyboardType: TextInputType.number,
              centerInput: true,
              validator: (v) {
                String? msg;
                msg = ValidatorHelper.validateInt(v);
                if (msg == null && lower.text.isNotEmpty) {
                  if (int.parse(v!) < int.parse(lower.text)) {
                    return "Upper value must be greater than lower value";
                  }
                } else {
                  return msg;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
