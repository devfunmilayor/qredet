import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qredet/core/error/failure.dart';
import 'package:qredet/core/usecase/usecase.dart';
import 'package:qredet/features/language/domain/entities/language.dart';
import 'package:qredet/features/language/domain/repositories/language_repository.dart';

@lazySingleton
class GetLanguages implements UseCase<List<Language>, NoParams> {
  const GetLanguages(this._repository);

  final LanguageRepository _repository;

  @override
  Future<Either<Failure, List<Language>>> call(NoParams params) =>
      _repository.getLanguages();
}
