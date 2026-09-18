import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_up/features/auth/forgot_password/view/cubit/forgot_passowrd_cubit.dart';
import '../../../../../core/app_ui/app_ui.dart';
import '../../../../../core/shared/shared.dart';

class EmailFieldWidget extends StatefulWidget {
  const EmailFieldWidget({super.key});

  @override
  State<EmailFieldWidget> createState() => _EmailFieldWidgetState();
}

class _EmailFieldWidgetState extends State<EmailFieldWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late Debouncer _debouncer;

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = FocusNode()..addListener(_focusNodeListener);
    _debouncer = Debouncer();
    super.initState();
  }

  void _focusNodeListener() {
    if (!_focusNode.hasFocus) {
      context.read<ForgotPasswordCubit>().onEmailUnfocused();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode
      ..removeListener(_focusNodeListener)
      ..dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailError = context.select(
      (ForgotPasswordCubit cubit) => cubit.state.email.errorMessage,
    );
    return AppTextField(
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      errorText: emailError,
      textController: _controller,
      focusNode: _focusNode,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      prefixIcon: const Icon(
        Icons.email_outlined,
        color: AppColors.color2F628D,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.lg * 2),
        borderSide: const BorderSide(color: AppColors.colorE2E2E6, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.lg * 2),
        borderSide: const BorderSide(color: AppColors.colorE2E2E6, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.lg * 2),
        borderSide: const BorderSide(color: AppColors.color2F628D, width: 1.0),
      ),
      hintText: AppStrings.emailHint,
      hintStyle: context.bodyLarge?.copyWith(color: AppColors.colorBFC7D3),
      onChanged: (value) {
        _debouncer.run(() {
          context.read<ForgotPasswordCubit>().onEmailChanged(value);
        });
      },
    );
  }
}
