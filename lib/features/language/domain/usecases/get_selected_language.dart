import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qredet/core/error/failure.dart';
import 'package:qredet/core/usecase/usecase.dart';
import 'package:qredet/features/language/domain/entities/language.dart';
import 'package:qredet/features/language/domain/repositories/language_repository.dart';

@lazySingleton
class GetSelectedLanguage implements UseCase<Language, NoParams> {
  const GetSelectedLanguage(this._repository);

  final LanguageRepository _repository;

  @override
  Future<Either<Failure, Language>> call(NoParams params) =>
      _repository.getSelectedLanguage();
}
