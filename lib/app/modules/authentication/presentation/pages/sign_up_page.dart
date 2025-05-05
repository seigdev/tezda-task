import 'package:flutter/material.dart';
import 'package:tezda_task/app/modules/authentication/domain/controllers/authentication_controller.dart';
import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'sign_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with AppThemeMixin {
  bool obscureText = true;

  bool loading = false;

  TextEditingController editFullNameController = TextEditingController();

  TextEditingController editEmailController = TextEditingController();

  TextEditingController editPhoneController = TextEditingController();

  TextEditingController editPasswordController = TextEditingController();

  TextEditingController editConfirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.kBackground,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: Spacings.spacing20),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const VSpacer(Spacings.spacing50),
                    const Center(
                      child: BaseText(
                        'Create an Account',
                        fontSize: TextSizes.size18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: Spacings.spacing8),
                    Center(
                      child: BaseText(
                        'Welcome to Tezda',
                        color: colors.ggray400,
                        fontSize: TextSizes.size14,
                      ),
                    ),
                    Form(
                      key: const Key(''),
                      child: Column(
                        children: [
                          const SizedBox(height: Spacings.spacing24),
                          TextFieldComponent(
                            hint: 'Full Name',
                            editingController: editFullNameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: Spacings.spacing24),
                          TextFieldComponent(
                            hint: 'Email Address',
                            editingController: editEmailController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: Spacings.spacing24),
                          TextFieldComponent(
                            hint: 'Phone Number',
                            editingController: editPhoneController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            prefixText: '+234 ',
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
                                      color: colors.ggray400,
                                    ),
                                  )
                                : IconButton(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      obscureText = !obscureText;
                                      setState(() {
                                        setState(() {});
                                      });
                                    },
                                    icon: Icon(
                                      Icons.visibility_off,
                                      size: 20,
                                      color: colors.ggray400,
                                    ),
                                  ),
                            hint: 'Password',
                            onChanged: (value) {},
                            textInputAction: TextInputAction.done,
                          ),
                          const SizedBox(height: Spacings.spacing24),
                          TextFieldComponent(
                            obscureText: obscureText,
                            editingController: editConfirmPasswordController,
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
                                      color: colors.ggray400,
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
                                      color: colors.ggray400,
                                    ),
                                  ),
                            hint: 'Confirm Password',
                            onChanged: (value) {
                              setState(() {});
                            },
                            textInputAction: TextInputAction.done,
                          ),
                          const SizedBox(height: Spacings.spacing50),
                          BaseTextLink(
                            text: "Have an account?",
                            "Login Now",
                            () {
                              pushReplacementTo(const SignInPage());
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
                    text: 'Create Account',
                    loading: loading,
                    validator: () =>
                        editConfirmPasswordController.text.isNotEmpty,
                    onPressed: () {
                      if (editConfirmPasswordController.text ==
                          editPasswordController.text) {
                        setState(() => loading = true);
                        signUp(ref);
                      } else {
                        showErrorToast("Passwords do not match.");
                      }
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

  void signUp(WidgetRef ref) async {
    final authController = ref.read(authenticationProvider);
    await authController.register(
      phone: editPhoneController.text,
      password: editPasswordController.text,
      email: editEmailController.text,
      fullName: editFullNameController.text,
    );
    clearControllers();
    setState(() => loading = false);
  }

  void clearControllers() {
    editPhoneController.clear();
    editPasswordController.clear();
    editConfirmPasswordController.clear();
    editEmailController.clear();
    editFullNameController.clear();
  }
}
