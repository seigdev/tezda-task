import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tezda_task/app/modules/profile/data/dummy_data.dart';
import 'package:tezda_task/app/modules/profile/data/models/user_model.dart';
import 'package:tezda_task/app/modules/profile/presentation/components/logout_component.dart';
import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';

import '../components/activity_component.dart';
import '../components/profile_component.dart';

class ProfilePage extends StatefulHookConsumerWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> with AppThemeMixin {
  UserModel userModel = UserModel(fullName: "", email: "", phone: "");
  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  fetchUser() async {
    Map<String, dynamic> userData =
        await FIRESTORE.read("users", UserModel.userId);
    setState(() {
      userModel = UserModel.fromJson(userData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.kBackground,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: Spacings.spacing20),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const VSpacer(Spacings.spacing24),
                    const BaseText(
                      "My Account",
                      fontSize: TextSizes.size20,
                      fontWeight: FontWeight.w600,
                    ),
                    const VSpacer(Spacings.spacing24),
                    ProfileComponent(userModel),
                    const VSpacer(Spacings.spacing24),
                    const BaseText(
                      "Activity",
                      fontSize: TextSizes.size16,
                      fontWeight: FontWeight.w600,
                    ),
                    Column(
                      children: List.generate(
                        activityText.length,
                        (index) => ActivityComponent(
                          activityText[index],
                          activityIcon[index],
                        ),
                      ),
                    ),
                    const VSpacer(Spacings.spacing24),
                    const LogOutComponent(),
                  ],
                ),
              ),
              // CustomButton(
              //   text: "Log Out",
              //   expanded: true,
              //   color: Colors.red,
              //   onPressed: () async {
              //     final authController = ref.read(authenticationProvider);
              //     await authController.signOut();
              //   },
              // ),
              const VSpacer(Spacings.spacing24)
            ],
          ),
        ),
      ),
    );
  }
}
