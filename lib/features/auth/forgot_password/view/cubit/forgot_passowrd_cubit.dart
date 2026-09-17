import 'package:chat_up/features/auth/forgot_password/view/cubit/forgot_password_state.dart';
import 'package:chat_up/features/auth/forgot_password/view/repo/forgot_password_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepo forgotPasswordRepo;
  ForgotPasswordCubit({required this.forgotPasswordRepo})
    : super(ForgotPasswordState.initial());
}
