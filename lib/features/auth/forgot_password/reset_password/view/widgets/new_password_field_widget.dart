import 'package:chat_up/core/app_ui/app_ui.dart';
import 'package:chat_up/core/shared/shared.dart';
import 'package:chat_up/features/auth/forgot_password/reset_password/view/cubit/reset_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPasswordFieldWidget extends StatefulWidget {
  const NewPasswordFieldWidget({super.key});

  @override
  State<NewPasswordFieldWidget> createState() => _NewPasswordFieldWidgetState();
}

class _NewPasswordFieldWidgetState extends State<NewPasswordFieldWidget> {
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
      context.read<ResetPasswordCubit>().onNewPasswordUnfocused();
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
    final passwordError = context.select(
      (ResetPasswordCubit cubit) => cubit.state.newPassword.errorMessage,
    );

    final showPassword = context.select(
      (ResetPasswordCubit cubit) => cubit.state.showNewPassword,
    );

    return AppTextField(
      errorText: passwordError,
      obscureText: !showPassword,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      prefixIcon: const Icon(Icons.lock_outlined, color: AppColors.color2F628D),
      suffixIcon: Tappable(
        onTap: context.read<ResetPasswordCubit>().onShowNewPasswordChanged,
        child: Icon(
          showPassword
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          color: AppColors.color2F628D,
        ),
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
      hintText: AppStrings.enterNewPassword,
      textController: _controller,
      focusNode: _focusNode,
      textInputType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      hintStyle: context.bodyLarge?.copyWith(color: AppColors.colorBFC7D3),
      onChanged: (value) {
        _debouncer.run(() {
          context.read<ResetPasswordCubit>().onNewPasswordChanged(value);
        });
      },
    );
  }
}
