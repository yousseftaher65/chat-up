// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/forgot_password/reset_password/data/datasources/reset_password_remote_data_source.dart'
    as _i862;
import '../../features/auth/forgot_password/reset_password/data/repo/reset_password_repo_impl.dart'
    as _i119;
import '../../features/auth/forgot_password/reset_password/view/cubit/reset_password_cubit.dart'
    as _i292;
import '../../features/auth/forgot_password/reset_password/view/repo/reset_password_repo.dart'
    as _i506;
import '../../features/auth/forgot_password/data/datasources/forgot_password_remote_data_source.dart'
    as _i837;
import '../../features/auth/forgot_password/data/repo/forgot_password_repo_impl.dart'
    as _i877;
import '../../features/auth/forgot_password/view/cubit/forgot_passowrd_cubit.dart'
    as _i429;
import '../../features/auth/forgot_password/view/repo/forgot_password_repo.dart'
    as _i974;
import '../../features/auth/login/data/datasources/login_remote_data_source.dart'
    as _i743;
import '../../features/auth/login/data/repo/login_repo_impl.dart' as _i1001;
import '../../features/auth/login/view/cubit/login_cubit.dart' as _i14;
import '../../features/auth/login/view/repo/login_repo.dart' as _i407;
import '../../features/auth/shared/data/datasources/auth_local_data_source.dart'
    as _i342;
import '../../features/auth/shared/data/datasources/auth_remote_database.dart'
    as _i256;
import '../../features/auth/signup/data/datasources/signup_remote_data_source.dart'
    as _i336;
import '../../features/auth/signup/data/repo/signup_repo_impl.dart' as _i767;
import '../../features/auth/signup/view/cubit/signup_cubit.dart' as _i625;
import '../../features/auth/signup/view/repo/signup_repo.dart' as _i72;
import '../services/cache_service.dart' as _i717;
import '../services/remote_auth_service.dart' as _i578;
import '../services/remote_database_service.dart' as _i905;
import 'service_locator.dart' as _i105;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.singleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.singleton<_i974.FirebaseFirestore>(
      () => registerModule.firebaseFirestore,
    );
    gh.singleton<_i116.GoogleSignIn>(() => registerModule.googleSignIn);
    gh.factory<_i578.RemoteAuthService>(
      () => _i578.RemoteAuthServiceImpl(
        firebaseAuth: gh<_i59.FirebaseAuth>(),
        googleSignIn: gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.singleton<_i717.CacheService>(() => _i717.CacheServiceImpl());
    gh.factory<_i905.RemoteDatabaseService>(
      () => _i905.RemoteDatabaseServiceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.factory<_i862.ResetPasswordRemoteDataSource>(
      () => _i862.ResetPasswordRemoteDataSourceImpl(
        gh<_i578.RemoteAuthService>(),
      ),
    );
    gh.factory<_i336.SignupRemoteDataSource>(
      () => _i336.RemoteDataSourceImpl(gh<_i578.RemoteAuthService>()),
    );
    gh.factory<_i743.LoginRemoteDataSource>(
      () => _i743.RemoteDataSourceImpl(gh<_i578.RemoteAuthService>()),
    );
    gh.factory<_i506.ResetPasswordRepo>(
      () => _i119.ResetPasswordRepoImpl(
        resetPasswordDataSource: gh<_i862.ResetPasswordRemoteDataSource>(),
      ),
    );
    gh.factory<_i256.AuthRemoteDatabase>(
      () => _i256.AuthRemoteDatabaseImpl(gh<_i905.RemoteDatabaseService>()),
    );
    gh.factory<_i837.ForgotPasswordRemoteDataSource>(
      () => _i837.ForgotPasswordRemoteDataSourceImpl(
        gh<_i578.RemoteAuthService>(),
      ),
    );
    gh.factory<_i974.ForgotPasswordRepo>(
      () => _i877.ForgotPasswordRepoImpl(
        remoteDataSource: gh<_i837.ForgotPasswordRemoteDataSource>(),
      ),
    );
    gh.factory<_i342.AuthLocalDataSource>(
      () => _i342.LoginLocalDataSourceImpl(gh<_i717.CacheService>()),
    );
    gh.factory<_i292.ResetPasswordCubit>(
      () => _i292.ResetPasswordCubit(
        resetPasswordRepo: gh<_i506.ResetPasswordRepo>(),
      ),
    );
    gh.factory<_i407.LoginRepo>(
      () => _i1001.LoginRepoImpl(
        remoteDataSource: gh<_i743.LoginRemoteDataSource>(),
        localDataSource: gh<_i342.AuthLocalDataSource>(),
        authRemoteDatabase: gh<_i256.AuthRemoteDatabase>(),
      ),
    );
    gh.factory<_i14.LoginCubit>(
      () => _i14.LoginCubit(loginRepo: gh<_i407.LoginRepo>()),
    );
    gh.factory<_i72.SignupRepo>(
      () => _i767.SignupRepoImpl(
        remoteDataSource: gh<_i336.SignupRemoteDataSource>(),
        authRemoteDatabase: gh<_i256.AuthRemoteDatabase>(),
        authlocalDataSource: gh<_i342.AuthLocalDataSource>(),
      ),
    );
    gh.factory<_i429.ForgotPasswordCubit>(
      () => _i429.ForgotPasswordCubit(
        forgotPasswordRepo: gh<_i974.ForgotPasswordRepo>(),
      ),
    );
    gh.factory<_i625.SignupCubit>(
      () => _i625.SignupCubit(signupRepo: gh<_i72.SignupRepo>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i105.RegisterModule {}
