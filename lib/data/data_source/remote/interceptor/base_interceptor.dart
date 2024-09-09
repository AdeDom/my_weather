import 'package:dio/dio.dart';
import 'package:my_weather/utils/constants/app_constant.dart';

class BaseInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final queryParameters = options.queryParameters;
    Map<String, String> apiKey = {
      AppConstant.appIdApiKey: AppConstant.appIdApi,
    };
    queryParameters.addAll(apiKey);
    options.queryParameters = queryParameters;
    super.onRequest(options, handler);
  }
}
