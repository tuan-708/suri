import 'package:dartz/dartz.dart';
import 'package:suri_checking_event_app/core/error/failures.dart';

abstract class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
