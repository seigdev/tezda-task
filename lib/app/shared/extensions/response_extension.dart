import 'package:http/http.dart';
import 'package:tezda_task/app/shared/shared.dart';

extension StatusCodes on Response {
  bool get is200 => statusCode == 200;
  bool get is201 => statusCode == 201;
  bool get is202 => statusCode == 202;
  bool get is400 => statusCode == 400;
  bool get is409 => statusCode == 409;
  bool get is500 => statusCode == 500;
  bool get is401 => statusCode == 401;
  bool get is404 => statusCode == 404;

  bool get is502 => statusCode == 502;

  bool get is200or201 => statusCode == 200 || statusCode == 201;
}

extension Status on ApiResponse {
  bool get is200 => status == 200;
  bool get is201 => status == 201;
  bool get is202 => status == 202;
  bool get is400 => status == 400;
  bool get is409 => status == 409;
  bool get is500 => status == 500;
  bool get is401 => status == 401;
  bool get is404 => status == 404;

  bool get is502 => status == 502;

  bool get is200or201 => status == 200 || status == 201;
}
