import 'dart:convert';

import 'package:tezda_task/app/modules/products/domain/service/interface/products_service_interface.dart';
import 'package:tezda_task/app/shared/shared.dart';

class ProductsService implements ProdctsServiceInterface {
  @override
  Future<ApiResponse> fetchAllProducts() async {
    final r = await HTTP.get("products");

    final Map<String, dynamic> response = json.decode(r.body);

    // final data = response.map((json) => json as Map<String, dynamic>).toList();

    response.prettyLogJson();

    if (r.is200or201) {
      return ApiResponse(
        data: response["products"],
        message: r.reasonPhrase!,
        status: r.statusCode,
      );
    }
    throw AppException.fromResponse(r);
  }

  @override
  Future<ApiResponse> fetchCategories() async {
    final r = await HTTP.get("products/categories");

    final List<dynamic> response = json.decode(r.body);

    final data = response.map((json) => json as Map<String, dynamic>).toList();

    if (r.is200or201) {
      return ApiResponse(
        data: data,
        message: r.reasonPhrase!,
        status: r.statusCode,
      );
    }
    throw AppException.fromResponse(r);
  }
}
