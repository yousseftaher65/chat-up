import 'package:bloc_test/bloc_test.dart';
import 'package:chat_up/core/form_fields/form_fields.dart';
import 'package:chat_up/features/auth/login/view/cubit/login_cubit.dart';
import 'package:chat_up/features/auth/login/view/cubit/login_state.dart';
import 'package:chat_up/features/auth/login/view/repo/login_repo.dart';
import 'package:chat_up/features/auth/shared/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginRepo extends Mock implements LoginRepo {}

void main() {
  const email = 'user@example.com';
  const password = 'password123';
  const userId = 'user123';
  const fullname = 'John Doe';

  group('LoginCubit', () {
    late MockLoginRepo loginRepo;
    late LoginCubit cubit;

    setUp(() {
      loginRepo = MockLoginRepo();
      cubit = LoginCubit(loginRepo: loginRepo);
    });

    tearDown(() => cubit.close());

    blocTest<LoginCubit, LoginState>(
      'does not login when credentials are invalid',
      build: () => LoginCubit(loginRepo: loginRepo),
      seed: () => LoginState.initial().copyWith(
        email: const Email.dirty('invalid'),
        password: const Password.dirty(password),
      ),
      act: (cubit) => cubit.onLoginPressed(),
      expect: () => <LoginState>[],
      verify: (_) => verifyZeroInteractions(loginRepo),
    );

    blocTest<LoginCubit, LoginState>(
      'emits loading and success states when login succeeds',
      build: () => cubit,
      setUp: () {
        when(
          () => loginRepo.login(email: email, password: password),
        ).thenAnswer(
          (_) async => UserModel(email: email, id: userId, fullname: fullname),
        );
      },
      seed: () => LoginState.initial().copyWith(
        email: const Email.dirty(email),
        password: const Password.dirty(password),
      ),
      act: (cubit) => cubit.onLoginPressed(),
      expect: () => [
        LoginState.initial().copyWith(
          email: const Email.dirty(email),
          password: const Password.dirty(password),
          status: LoginStatus.loading,
        ),
        LoginState.initial().copyWith(
          email: const Email.dirty(email),
          password: const Password.dirty(password),
          status: LoginStatus.success,
          user: UserModel(email: email, id: userId, fullname: fullname),
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits loading and error states when login fails',
      build: () => LoginCubit(loginRepo: loginRepo),
      seed: () => LoginState.initial().copyWith(
        email: const Email.dirty(email),
        password: const Password.dirty(password),
      ),
      setUp: () {
        when(
          () => loginRepo.login(email: email, password: password),
        ).thenThrow(Exception('Login failed'));
      },
      act: (cubit) => cubit.onLoginPressed(),
      expect: () {
        final loading = LoginState.initial().copyWith(
          email: const Email.dirty(email),
          password: const Password.dirty(password),
          status: LoginStatus.loading,
        );

        return [
          loading,
          loading.copyWith(
            status: LoginStatus.error,
            errorMessage: 'Exception: Login failed',
          ),
        ];
      },
    );
  });
}
