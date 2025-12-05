import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pocket_pantry_frontend/core/error/app_exceptions.dart';
import 'package:pocket_pantry_frontend/core/error/failure.dart';
import 'package:pocket_pantry_frontend/core/network/network_info.dart';

typedef RemoteCall<T> = Future<T> Function();

class SafeApiCall {
  final NetworkInfo networkInfo;

  SafeApiCall(this.networkInfo);

  Future<Either<Failure, T>> execute<T>(RemoteCall<T> call) async {
    // Check internet connection
    if (!await networkInfo.isConnected) {
      return const Left(
        NetworkFailure(
          'No Internet Connection. Please check your network and try again.',
        ),
      );
    }

    // API CALL in try-catch
    try {
      final result = await call();
      return Right(result);
    } on DioException catch (e) {
      // Handle Dio Specific Errors
      // Check if the error is an AppException
      if (e.error is AppException) {
        final appException = e.error as AppException;
        return Left(
          ServerFailure(appException.message ?? 'Something went wrong'),
        );
      }

      // Fallback for other DioExceptions not caught by AppException interceptor
      final message =
          e.response?.data['message'] ??
          e.message ??
          "An Unexpected Server Error Occurred";

      return Left(ServerFailure(message));
    } catch (e) {
      // Any other error
      return Left(
        ServerFailure("An unexpected error occurred: ${e.toString()}"),
      );
    }
  }
}
