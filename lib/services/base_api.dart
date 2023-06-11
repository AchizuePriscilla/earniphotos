import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../models/api/api_response.dart';

abstract class BaseApi {
  late Dio dio;

  BaseApi(String baseApi) {
    final options = BaseOptions(
        baseUrl: baseApi,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60));

    dio = Dio(options);
  }
  Future<Either<Failure, Success>> makeRequest(Future<Response> future) async {
    try {
      var req = await future;

      var data = req.data;
      if ("${req.statusCode}".startsWith('2')) {
        return Right(Success(data));
      } else {
        return Left(Failure(data["message"]));
      }
    } on SocketException catch (_) {
      return Left(
        Failure(
          "Oops. You got disconnected. Check your internet connection and try again.",
        ),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return Left(
          Failure(
            "Oops. It took too long to process your request. Check your internet connection and try again.",
          ),
        );
      } else {
        log(e.response.toString());
        return Left(Failure(e.response.toString()));
      }
    }
  }

  Future<Either<Failure, Success>> get(
    path, {
    Map<String, dynamic>? data,
    Map<String, dynamic> headers = const {},
  }) =>
      makeRequest(
        dio.get(
          "$path",
          data: data,
          options: Options(
            method: "GET",
            headers: {
              ...headers,
            },
          ),
        ),
      );
}
