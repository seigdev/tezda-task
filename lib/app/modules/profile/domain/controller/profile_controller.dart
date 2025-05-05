import 'package:tezda_task/app/modules/profile/domain/repository/profile_repository.dart';
import 'package:tezda_task/app/shared/classes/dashboard.dart';
import 'package:tezda_task/app/shared/shared.dart';
import 'package:tezda_task/core/core.dart';

class ProfileController {
  final _profileRepository = ProfileRepository();

  Future updateProfile(
      {required String fullName,
      required String email,
      required String phone}) async {
    await _profileRepository.updateProfile(fullName, email, phone);

    showSuccessToast("Account Updated Successfully.");

    pushToAndClearStack(const Dashboard());
  }
}
