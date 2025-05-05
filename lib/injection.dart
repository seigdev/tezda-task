import 'package:get_it/get_it.dart';
import 'package:tezda_task/app/modules/authentication/domain/service/authentication_service.dart';
import 'package:tezda_task/app/modules/products/domain/service/products_service.dart';
import 'package:tezda_task/app/modules/profile/domain/service/profile_service.dart';
import 'package:tezda_task/core/core.dart';

GetIt inj = GetIt.instance;

Future<void> configDependencies() async {
  inj.registerLazySingleton<AppThemeController>(() => AppThemeController());

  inj.registerLazySingleton<AuthenticationService>(
      () => AuthenticationService());

  inj.registerLazySingleton<ProfileService>(() => ProfileService());

  inj.registerLazySingleton<ProductsService>(() => ProductsService());
}
