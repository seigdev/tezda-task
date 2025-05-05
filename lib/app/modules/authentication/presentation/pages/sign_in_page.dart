import 'package:tezda_task/app/modules/authentication/domain/controllers/authentication_controller.dart';
import 'package:tezda_task/app/modules/authentication/presentation/pages/sign_up_page.dart';
import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> with AppThemeMixin {
  bool obscureText = true;

  bool checkedBox = false;

  bool loading = false;

  String errorText = '';

  TextEditingController editEmailController = TextEditingController();

  TextEditingController editPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.kBackground,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacings.spacing20),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const VSpacer(Spacings.spacing30),
                    const BaseText(
                      'Sign In',
                      fontSize: TextSizes.size18,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Spacings.spacing8),
                    BaseText(
                      'Welcome back to Tezda',
                      color: colors.ggray400,
                      fontSize: TextSizes.size14,
                      textAlign: TextAlign.center,
                    ),
                    Form(
                      key: const Key(''),
                      child: Column(
                        children: [
                          const SizedBox(height: Spacings.spacing24),
                          TextFieldComponent(
                            hint: 'Email',
                            editingController: editEmailController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: Spacings.spacing24),
                          TextFieldComponent(
                            obscureText: obscureText,
                            editingController: editPasswordController,
                            suffix: obscureText
                                ? IconButton(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      obscureText = !obscureText;
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      size: 20,
                                      color: colors.ggray900,
                                    ),
                                  )
                                : IconButton(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      obscureText = !obscureText;
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      Icons.visibility_off,
                                      size: 20,
                                      color: colors.ggray900,
                                    ),
                                  ),
                            hint: 'Password',
                            onChanged: (value) {
                              setState(() {});
                            },
                            textInputAction: TextInputAction.done,
                          ),
                          const SizedBox(height: Spacings.spacing50),
                          BaseTextLink(
                            text: "Don't have an account?",
                            "Register Now",
                            () {
                              pushReplacementTo(const SignUpPage());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const VSpacer(Spacings.spacing24),
              Consumer(
                builder: (context, ref, child) {
                  return CustomButton(
                    expanded: true,
                    text: 'Log In',
                    loading: loading,
                    validator: () => editPasswordController.text.isNotEmpty,
                    onPressed: () {
                      setState(() => loading = true);
                      singIn(ref);
                    },
                  );
                },
              ),
              const SizedBox(height: Spacings.spacing16),
            ],
          ),
        ),
      ),
    );
  }

  void singIn(WidgetRef ref) async {
    final authController = ref.read(authenticationProvider);

    await authController.login(
      email: editEmailController.text,
      password: editPasswordController.text,
    );

    clearControllers();

    setState(() => loading = false);
  }

  void clearControllers() {
    editEmailController.clear();
    editPasswordController.clear();
  }
}
