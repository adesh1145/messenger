import 'package:dartz/dartz.dart';
import 'package:messenger/core/errors/failures.dart';

typedef ResultFutureT<T> = Future<Either<Failure, T>>;

typedef ResultVoid = ResultFutureT<void>;
