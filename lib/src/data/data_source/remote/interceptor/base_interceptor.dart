import 'package:dio/dio.dart';
import 'package:my_weather/src/data/data_source/remote/constant/service_constant.dart';
import 'package:my_weather/src/data/data_source/remote/exception/app_exception.dart';

class BaseInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final queryParameters = options.queryParameters;
    Map<String, String> apiKey = {
      ServiceConstant.appIdApiKey: ServiceConstant.appIdApi,
    };
    queryParameters.addAll(apiKey);
    options.queryParameters = queryParameters;
    options.baseUrl = ServiceConstant.baseUrl;
    handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    handler.next(err);
    throw AppException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: err.error,
      stackTrace: err.stackTrace,
      message: err.message,
    );
  }
}
