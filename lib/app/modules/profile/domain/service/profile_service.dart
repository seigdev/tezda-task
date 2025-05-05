import 'package:firebase_auth/firebase_auth.dart';
import 'package:tezda_task/app/modules/profile/data/models/user_model.dart';
import 'package:tezda_task/app/modules/profile/domain/service/interface/profile_service_interface.dart';
import 'package:tezda_task/app/shared/shared.dart';

class ProfileService implements ProfileServiceInterface {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Future updateProfile(String fullName, String email, String phone) async {
    await FIRESTORE.update(
      "users",
      UserModel.userId,
      {
        "full_name": fullName,
        "email": email,
        "phone": phone,
      },
    );
    await user!
        .verifyBeforeUpdateEmail(email)
        .then((value) => showSuccessToast("Check Email for Verification."))
        .catchError((onError) {
      showSuccessToast("Unable to Update Account.");
    });
  }
}
