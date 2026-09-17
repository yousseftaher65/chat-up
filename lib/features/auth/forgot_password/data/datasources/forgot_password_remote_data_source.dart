import 'package:injectable/injectable.dart';

abstract class ForgotPasswordRemoteDataSource {}

@Injectable(as: ForgotPasswordRemoteDataSource)
class ForgotPasswordRemoteDataSourceImpl implements ForgotPasswordRemoteDataSource {}