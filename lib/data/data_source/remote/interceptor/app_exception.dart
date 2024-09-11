import 'package:dio/dio.dart';
import 'package:my_weather/data/models/response/error/error_response.dart';

class AppException extends DioException {
  AppException({
    required super.requestOptions,
    super.response,
    super.type = DioExceptionType.unknown,
    super.error,
    StackTrace? stackTrace,
    super.message,
  });

  @override
  String toString() {
    final json = response?.data;
    final errorResponse = ErrorResponse.fromJson(json);
    return errorResponse.message ?? type.name;
  }
}
