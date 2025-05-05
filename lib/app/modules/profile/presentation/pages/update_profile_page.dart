import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tezda_task/app/modules/profile/data/models/user_model.dart';
import 'package:tezda_task/app/modules/profile/domain/controller/profile_controller.dart';
import 'package:tezda_task/app/modules/profile/presentation/components/update_profile_component.dart';
import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';

class UpdateProfilePage extends StatefulHookConsumerWidget {
  final UserModel userModel;
  const UpdateProfilePage(this.userModel, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateProfilePageState();
}

class _UpdateProfilePageState extends ConsumerState<UpdateProfilePage>
    with AppThemeMixin {
  String email = "";

  String fullName = "";

  String phone = "";

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final userModel = widget.userModel;

    return Scaffold(
      backgroundColor: colors.kBackground,
      appBar: const AppBarComponent(title: "Update Profile"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacings.spacing20),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const VSpacer(Spacings.spacing24),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: colors.tF9A03F,
                          foregroundImage: NetworkImage(
                            UserModel.image ??
                                fetchProfileUrl(userModel.fullName),
                          ),
                          maxRadius: 35,
                        ),
                        const HSpacer(Spacings.spacing18),
                        const UploadProfilePicture(),
                      ],
                    ),
                    Form(
                      key: const Key(''),
                      child: Column(
                        children: [
                          const SizedBox(height: Spacings.spacing24),
                          TextFieldComponent(
                            hint: 'Full Name',
                            initialValue: userModel.fullName,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              setState(() => fullName = value);
                            },
                          ),
                          const SizedBox(height: Spacings.spacing24),
                          TextFieldComponent(
                            hint: 'Email Address',
                            initialValue: userModel.email,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              setState(() => email = value);
                            },
                          ),
                          const SizedBox(height: Spacings.spacing24),
                          TextFieldComponent(
                            hint: 'Phone Number',
                            initialValue: userModel.phone,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              setState(() => phone = value);
                            },
                          ),
                          const SizedBox(height: Spacings.spacing24),
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
                    text: 'Update Profile',
                    loading: loading,
                    validator: () => true,
                    onPressed: () async {
                      setState(() => loading = true);
                      final profileController = ProfileController();
                      await profileController.updateProfile(
                        fullName:
                            fullName.isEmpty ? userModel.fullName : fullName,
                        email: email.isEmpty ? userModel.email : email,
                        phone: phone.isEmpty ? userModel.phone : phone,
                      );
                      setState(() => loading = false);
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
}
