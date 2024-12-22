import 'package:brite_eye/core/extentions/color_theme.dart';
import 'package:brite_eye/core/extentions/text_theme.dart';
import 'package:brite_eye/faetures/auth/ui/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/data/network/api_response.dart';
import '../../../../core/helpers/validator_helper.dart';
import '../../../../core/shared/widgets/app_button.dart';
import '../../../../core/shared/widgets/app_field.dart';
import '../../../../core/shared/widgets/back_button.dart';
import '../../../../core/shared/widgets/gender_drop_down.dart';
import '../../../../core/shared/widgets/loadable_screen.dart';
import '../../../../core/shared/widgets/ssized_box.dart';
import '../../logic/signup_provider.dart';
import '../../models/auth_response.dart';

class SignupScreen extends StatelessWidget {
  static const String id = '/signup';

  const SignupScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key(id),
      body: Selector<SingUpProvider, ApiResponse<AuthResponse>?>(
        selector: (context, provider) => provider.response,
        builder: (context, value, child) {
          SingUpProvider provider =
              Provider.of<SingUpProvider>(context, listen: false);
          return LoadableScreen(
            isLoading: value?.loading() ?? false,
            child: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: provider.formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: AppBackButton(),
                        ),
                        const SSizedBox(
                          height: 32,
                        ),
                        Text(
                          "Join Brite Eye",
                          style: context.titleLarge,
                        ),
                        const SSizedBox(
                          height: 16,
                        ),
                        Text(
                          "Create an account to get started",
                          style: context.bodyLarge,
                        ),
                        const SSizedBox(
                          height: 32,
                        ),
                        AppField(
                          key: const Key('nameField'),
                          controller: provider.nameController,
                          label: "caregiver name",
                          validator: ValidatorHelper.validateName,
                        ),
                        const SSizedBox(
                          height: 16,
                        ),
                        AppField(
                          key: const Key('emailField'),
                          controller: provider.emailController,
                          label: "email",
                          validator: ValidatorHelper.validateEmail,
                        ),
                        const SSizedBox(
                          height: 16,
                        ),
                        PasswordField(
                          key: const Key('passwordField'),
                          controller: provider.passwordController,
                          label: "password",
                          validator: ValidatorHelper.validatePassword,
                        ),
                        const SSizedBox(
                          height: 16,
                        ),
                        PasswordField(
                          key: const Key('confirmPasswordField'),
                          controller: provider.confirmPasswordController,
                          label: "reset password",
                          validator: (confirm) =>
                              ValidatorHelper.validateConfirmPassword(
                                  confirm, provider.passwordController.text),
                        ),
                        const SSizedBox(
                          height: 16,
                        ),
                        GenderDropDown(
                          selectedItem: provider.gender,
                          onChanged: provider.setGender,
                        ),
                        const SSizedBox(
                          height: 32,
                        ),
                        AppButton(
                            key: const Key('signUpButton'),
                            onTap: () {
                              provider.signUp();
                            },
                            background: context.primary,
                            foregroundColor: context.surface,
                            hint: "Sign up"),
                        const SSizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
