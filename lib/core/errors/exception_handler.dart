import 'package:dartz/dartz.dart';
import 'package:messenger/core/errors/failures.dart';
import 'package:messenger/core/utils/typedef.dart';

ResultFutureT<T> exceptionHandler<T>(Future<T> Function() func) async {
  try {
    return Right(await func());
  } catch (e) {
    return Left(AuthFailure(e.toString()));
  }
}
