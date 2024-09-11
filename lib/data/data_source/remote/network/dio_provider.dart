import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/data/data_source/remote/interceptor/base_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(DioRef ref) {
  final dio = Dio();
  dio.interceptors.addAll([
    BaseInterceptor(),
    LogInterceptor(logPrint: (o) => debugPrint(o.toString())),
  ]);
  return dio;
}
