import 'package:chat_up/features/auth/signup/view/cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_ui/app_ui.dart';
import '../../../../../core/shared/shared.dart';

class PasswordFieldWidget extends StatefulWidget {
  const PasswordFieldWidget({super.key});

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
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
      context.read<SignupCubit>().onPasswordUnfocused();
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
      (SignupCubit cubit) => cubit.state.password.errorMessage,
    );

    final showPassword = context.select(
      (SignupCubit cubit) => cubit.state.showPassword,
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
        onTap: context.read<SignupCubit>().onShowPasswordChanged,
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
      hintText: AppStrings.passwordHint,
      textController: _controller,
      focusNode: _focusNode,
      textInputType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      hintStyle: context.bodyLarge?.copyWith(color: AppColors.colorBFC7D3),
      onChanged: (value) {
        _debouncer.run(() {
          context.read<SignupCubit>().onPasswordChanged(value);
        });
      },
    );
  }
}
