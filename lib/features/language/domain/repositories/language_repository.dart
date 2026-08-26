import 'package:fpdart/fpdart.dart';
import 'package:qredet/core/error/failure.dart';
import 'package:qredet/features/language/domain/entities/language.dart';

abstract class LanguageRepository {
  Future<Either<Failure, List<Language>>> getLanguages();

  Future<Either<Failure, Language>> getSelectedLanguage();

  Future<Either<Failure, Language>> setLanguage(Language language);
}
