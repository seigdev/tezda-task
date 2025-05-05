import 'package:flutter/material.dart';
import 'package:tezda_task/app/modules/profile/data/models/user_model.dart';
import 'package:tezda_task/app/modules/profile/presentation/pages/update_profile_page.dart';
import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';

class ProfileComponent extends StatelessWidget {
  final UserModel userModel;
  const ProfileComponent(this.userModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (colors) {
        return GestureDetector(
          onTap: () {
            pushTo(UpdateProfilePage(userModel));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: colors.tF9A03F,
                    foregroundImage: NetworkImage(
                      UserModel.image ?? fetchProfileUrl(userModel.fullName),
                    ),
                    maxRadius: 30,
                  ),
                  const HSpacer(Spacings.spacing16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        userModel.fullName,
                        fontSize: TextSizes.size16,
                        fontWeight: FontWeight.w600,
                      ),
                      BaseText(
                        userModel.email,
                        color: colors.ggray400,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: colors.ggray500,
              ),
            ],
          ),
        );
      },
    );
  }
}
