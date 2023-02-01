import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/errors/failures.dart';

/// Future<Either<Failure, Success>>
///
/// eg:
/// Typical eight-pixel margin on all sides:
///
/// ```dart
/// FutureEither<Car> getCar();
/// is same as
/// Future<Either<CarFailure, Car>> getCar();
/// ```
typedef FutureEither<T> = Future<Either<Failure, T>>;

/// onsuccess Noting returns
typedef FutureEitherVoid = Future<Either<Failure, void>>;

typedef FutureVoid = Future<void>;
