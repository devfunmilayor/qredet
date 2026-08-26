import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/language.dart';
import '../repositories/language_repository.dart';

@lazySingleton
class GetSelectedLanguage implements UseCase<Language, NoParams> {
  const GetSelectedLanguage(this._repository);

  final LanguageRepository _repository;

  @override
  Future<Either<Failure, Language>> call(NoParams params) =>
      _repository.getSelectedLanguage();
}
