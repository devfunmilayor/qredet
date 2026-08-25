import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/language.dart';
import '../repositories/language_repository.dart';

@lazySingleton
class GetLanguages implements UseCase<List<Language>, NoParams> {
  const GetLanguages(this._repository);

  final LanguageRepository _repository;

  @override
  Future<Either<Failure, List<Language>>> call(NoParams params) => _repository.getLanguages();
}
