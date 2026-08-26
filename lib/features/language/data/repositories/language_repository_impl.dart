import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qredet/core/error/error.dart';
import 'package:qredet/features/language/domain/entities/language.dart';
import 'package:qredet/features/language/domain/repositories/language_repository.dart';
import 'package:qredet/features/language/data/datasources/language_local_data_source.dart';

@LazySingleton(as: LanguageRepository)
class LanguageRepositoryImpl implements LanguageRepository {
  const LanguageRepositoryImpl(this._localDataSource);

  final LanguageLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<Language>>> getLanguages() async {
    try {
      return Right(_localDataSource.getLanguages());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Language>> getSelectedLanguage() async {
    try {
      return Right(_localDataSource.getSelectedLanguage());
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Language>> setLanguage(Language language) async {
    try {
      return Right(await _localDataSource.setLanguage(language));
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
