import 'package:brite_eye/core/extentions/color_theme.dart';
import 'package:brite_eye/core/extentions/text_theme.dart';
import 'package:brite_eye/core/helpers/validator_helper.dart';
import 'package:brite_eye/core/shared/widgets/app_button.dart';
import 'package:brite_eye/core/shared/widgets/loadable_screen.dart';
import 'package:brite_eye/core/shared/widgets/ssized_box.dart';
import 'package:brite_eye/faetures/auth/ui/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/data/network/api_response.dart';
import '../../../../core/helpers/navigation_helper.dart';
import '../../../../core/shared/widgets/app_field.dart';
import '../../logic/login_provider.dart';
import '../../models/auth_response.dart';
import '../widgets/password_field.dart';

class LoginScreen extends StatelessWidget {
  static const String id = '/login';
  final LoginProvider loginProvider;

  const LoginScreen({super.key, required this.loginProvider});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          NavigationHelper.exitApp();
        }
      },
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (BuildContext context) => loginProvider,
          child: Selector<LoginProvider, ApiResponse<AuthResponse>?>(
            selector: (context, provider) => provider.response,
            builder: (context, value, child) {
              LoginProvider provider =
                  Provider.of<LoginProvider>(context, listen: false);
              return LoadableScreen(
                  isLoading: (value?.loading() ?? false),
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
                              const SSizedBox(
                                height: 32,
                              ),
                              Text(
                                "Welcome to\nBrite Eye",
                                // style: context.titleLarge,
                                style: context.titleLarge,
                              ),
                              const SSizedBox(
                                height: 16,
                              ),
                              Text(
                                "Sign in to continue",
                                style: context.bodyLarge,
                              ),
                              const SSizedBox(
                                height: 32,
                              ),
                              AppField(
                                controller: provider.emailController,
                                label: "Email",
                                validator: ValidatorHelper.validateEmail,
                              ),
                              Consumer<LoginProvider>(
                                builder: (context, provider, child) {
                                  return PasswordField(
                                    controller: provider.passwordController,
                                    label: "enter password",
                                    validator: ValidatorHelper.validatePassword,
                                    textInputAction: TextInputAction.go,
                                  );
                                },
                              ),
                              const SSizedBox(
                                height: 16,
                              ),
                              AppButton(
                                onTap: () {
                                  if (!provider.isLoading()) {
                                    provider.login();
                                  }
                                },
                                hint: "Sign in",
                                background: context.primary,
                                foregroundColor: context.surface,
                              ),
                              const SSizedBox(
                                height: 16,
                              ),
                              AppButton(
                                  onTap: () {
                                    NavigationHelper.push(SignupScreen.id);
                                  },
                                  hint: "Sign up"),
                              const SSizedBox(
                                height: 32,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
