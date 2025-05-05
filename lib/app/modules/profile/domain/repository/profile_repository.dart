import 'package:tezda_task/app/modules/profile/domain/service/profile_service.dart';
import 'package:tezda_task/injection.dart';

class ProfileRepository {
  final _profileService = inj<ProfileService>();

  Future updateProfile(String fullName, String email, String phone) {
    return _profileService.updateProfile(fullName, email, phone);
  }
}
