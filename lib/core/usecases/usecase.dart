import 'package:dartz/dartz.dart';
import 'package:messenger/core/errors/failures.dart';

abstract class UseCaseWithParams<ReturnType, Params> {
  Future<Either<Failure, ReturnType>> call(Params params);
}

abstract class UseCaseWithoutParams<ReturnType> {
  Future<Either<Failure, ReturnType>> call();
}
