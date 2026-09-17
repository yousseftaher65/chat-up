import 'package:bloc_test/bloc_test.dart';
import 'package:chat_up/core/form_fields/email.dart';
import 'package:chat_up/core/form_fields/full_name.dart';
import 'package:chat_up/core/form_fields/password.dart';
import 'package:chat_up/features/auth/shared/data/models/user_model.dart';
import 'package:chat_up/features/auth/signup/view/cubit/signup_cubit.dart';
import 'package:chat_up/features/auth/signup/view/cubit/signup_states.dart';
import 'package:chat_up/features/auth/signup/view/repo/signup_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignupRepo extends Mock implements SignupRepo {}

void main() {
  const email = 'user@example.com';
  const password = 'password123';
  const fullname = 'John Doe';
  const userId = 'user123';

  group('SignupCubit', () {
    late MockSignupRepo signupRepo;
    late SignupCubit cubit;

    setUp(() {
      signupRepo = MockSignupRepo();
      cubit = SignupCubit(signupRepo: signupRepo);
    });

    tearDown(() => cubit.close());

    blocTest<SignupCubit, SignupState>(
      'does not signup when credentials are invalid',
      build: () => SignupCubit(signupRepo: signupRepo),
      seed: () => SignupState.initial().copyWith(
        email: const Email.dirty('invalid'),
        password: const Password.dirty(password),
        fullname: const FullName.dirty(fullname),
      ),
      act: (cubit) => cubit.onSignupPressed(),
      expect: () => <SignupState>[],
      verify: (_) => verifyZeroInteractions(signupRepo),
    );

    blocTest<SignupCubit, SignupState>(
      'emits loading and success states when signup succeeds',
      build: () => cubit,
      setUp: () {
        when(
          () => signupRepo.createAccount(
            email: email,
            password: password,
            fullname: fullname,
          ),
        ).thenAnswer(
          (_) async => UserModel(email: email, fullname: fullname, id: userId),
        );
      },
      seed: () => SignupState.initial().copyWith(
        email: const Email.dirty(email),
        password: const Password.dirty(password),
        fullname: const FullName.dirty(fullname),
      ),
      act: (cubit) => cubit.onSignupPressed(),
      expect: () => [
        SignupState.initial().copyWith(
          email: const Email.dirty(email),
          password: const Password.dirty(password),
          fullname: const FullName.dirty(fullname),
          status: SignupStatus.loading,
        ),
        SignupState.initial().copyWith(
          email: const Email.dirty(email),
          password: const Password.dirty(password),
          fullname: const FullName.dirty(fullname),
          status: SignupStatus.success,
          user: UserModel(email: email, id: userId, fullname: fullname),
        ),
      ],
    );

    blocTest<SignupCubit, SignupState>(
      'emits loading and error states when signup fails',
      build: () => SignupCubit(signupRepo: signupRepo),
      seed: () => SignupState.initial().copyWith(
        email: const Email.dirty(email),
        password: const Password.dirty(password),
        fullname: const FullName.dirty(fullname),
      ),
      setUp: () {
        when(
          () => signupRepo.createAccount(
            email: email,
            password: password,
            fullname: fullname,
          ),
        ).thenThrow(Exception('signup failed'));
      },
      act: (cubit) => cubit.onSignupPressed(),
      expect: () {
        final loading = SignupState.initial().copyWith(
          email: const Email.dirty(email),
          password: const Password.dirty(password),
          fullname: const FullName.dirty(fullname),
          status: SignupStatus.loading,
        );

        return [
          loading,
          loading.copyWith(
            status: SignupStatus.error,
            errorMessage: 'Exception: signup failed',
          ),
        ];
      },
    );
  });
}
