import 'package:chat_up/features/auth/signup/view/cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_ui/app_ui.dart';
import '../../../../../core/shared/shared.dart';

class FullNameFieldWidget extends StatefulWidget {
  const FullNameFieldWidget({super.key});

  @override
  State<FullNameFieldWidget> createState() => _FullNameFormWidgetState();
}

class _FullNameFormWidgetState extends State<FullNameFieldWidget> {
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
      context.read<SignupCubit>().onFullNameUnfocused();
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
    final fullnameError = context.select(
      (SignupCubit cubit) => cubit.state.fullname.errorMessage,
    );
    return AppTextField(
      textInputType: TextInputType.name,
      textInputAction: TextInputAction.next,
      errorText: fullnameError,
      textController: _controller,
      focusNode: _focusNode,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.lg,
      ),
      prefixIcon: const Icon(
        Icons.person_outline_rounded,
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
      hintText: AppStrings.fullNameHint,
      hintStyle: context.bodyLarge?.copyWith(color: AppColors.colorBFC7D3),
      onChanged: (value) {
        _debouncer.run(() {
          context.read<SignupCubit>().onFullNameChanged(value);
        });
      },
    );
  }
}
