import 'package:dartz/dartz.dart';

import 'app_exception.dart';

/// A mixin class that provides default repository methods for making API calls.
mixin class DefaultRepository {
  /// Makes an API call and processes the result.
  ///
  /// [T] is the type of data expected in the response.
  /// [request] is a function that returns a future containing the API request.
  /// [resultBuilder] is a function that processes the API response and returns an [Either] containing an [AppException] or the data.
  /// Returns an [Either] containing an [AppException] or the data.
  Future<Either<AppException, T>> call<T>(
      {required Future<Map<String, dynamic>> Function() request,
      required Future<T> Function(Map<String, dynamic>) resultBuilder}) async {
    return await Task(
      request,
    )
        .attempt()
        .map((either) {
          return either.leftMap((obj) {
            try {
              return obj as AppException;
            } catch (e) {
              throw obj;
            }
          });
        })
        .run()
        .then((networkEither) {
          return networkEither.fold(
            (exception) {
              return Left(exception);
            },
            (data) async {
              return Right(await resultBuilder(data));
            },
          );
        });
  }
}
