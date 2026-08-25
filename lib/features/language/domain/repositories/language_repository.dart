import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../entities/language.dart';

abstract class LanguageRepository {
  Future<Either<Failure, List<Language>>> getLanguages();

  Future<Either<Failure, Language>> getSelectedLanguage();

  Future<Either<Failure, Language>> setLanguage(Language language);
}
