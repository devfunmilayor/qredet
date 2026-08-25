import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/language.dart';
import '../repositories/language_repository.dart';

@lazySingleton
class SetLanguage implements UseCase<Language, Language> {
  const SetLanguage(this._repository);

  final LanguageRepository _repository;

  @override
  Future<Either<Failure, Language>> call(Language params) => _repository.setLanguage(params);
}
