import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thoughts/bloc/login/login_bloc.dart';
import 'package:thoughts/bloc/login/login_event.dart';
import 'package:thoughts/bloc/login/login_state.dart';
import 'package:thoughts/presentation/widget/custom_text_field.dart';
import 'package:thoughts/theme/app_theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  // Helper method to determine device type
  DeviceType _getDeviceType(double width) {
    if (width < 600) {
      return DeviceType.mobile;
    } else if (width < 1200) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  // Get responsive values based on device type
  ResponsiveValues _getResponsiveValues(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
        return ResponsiveValues(
          logoSize: 32,
          logoFontSize: 28,
          cardPadding: 24.0,
          cardInnerPadding: 16.0,
          titleFontSize: 25,
          fieldSpacing: 12,
          buttonHeight: 45,
          buttonWidth: 120,
          maxCardWidth: double.infinity,
          topSpacing: 0.2,
        );
      case DeviceType.tablet:
        return ResponsiveValues(
          logoSize: 38,
          logoFontSize: 32,
          cardPadding: 32.0,
          cardInnerPadding: 24.0,
          titleFontSize: 28,
          fieldSpacing: 16,
          buttonHeight: 50,
          buttonWidth: 140,
          maxCardWidth: 500,
          topSpacing: 0.15,
        );
      case DeviceType.desktop:
        return ResponsiveValues(
          logoSize: 42,
          logoFontSize: 36,
          cardPadding: 48.0,
          cardInnerPadding: 32.0,
          titleFontSize: 32,
          fieldSpacing: 20,
          buttonHeight: 55,
          buttonWidth: 160,
          maxCardWidth: 550,
          topSpacing: 0.12,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final deviceType = _getDeviceType(screenWidth);
    final values = _getResponsiveValues(deviceType);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/dashboard',
                (route) => false,
              );
            }

            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(16),
                  duration: const Duration(seconds: 3),
                ),
              );
            }

            if (state.resetPasswordSuccess && state.resetPasswordMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.resetPasswordMessage!),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.all(16),
                  duration: const Duration(seconds: 3),
                ),
              );
            }

            // if (state.resetPasswordInitiated && !state.resetPasswordInitiatedShown) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(
            //       content: const Text('Sending password reset email...'),
            //       backgroundColor: AppColors.warning,
            //       behavior: SnackBarBehavior.floating,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       margin: const EdgeInsets.all(16),
            //       duration: const Duration(seconds: 2),
            //       onVisible: () {
            //         context.read<LoginBloc>().add(ResetPasswordInitiated());
            //       },
            //     ),
            //   );
            // }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Container(color: AppColors.primary),
                  Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: deviceType == DeviceType.mobile ? 0 : 24,
                        vertical: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo section
                          Container(
                            color: AppColors.primary,
                            padding: EdgeInsets.only(
                              top: deviceType == DeviceType.mobile ? 20 : 40,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  color: AppColors.surface,
                                  size: values.logoSize,
                                ),
                                SizedBox(width: values.logoSize * 0.25),
                                Text(
                                  'fireray ',
                                  style: TextStyle(
                                    color: AppColors.surface,
                                    fontSize: values.logoFontSize,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  'BLE',
                                  style: TextStyle(
                                    color: AppColors.surface,
                                    fontSize: values.logoFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * values.topSpacing),
                          // Sign In Card
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: values.cardPadding,
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: values.maxCardWidth,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: deviceType != DeviceType.mobile
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 20,
                                          offset: const Offset(0, 10),
                                        ),
                                      ]
                                    : null,
                              ),
                              padding: EdgeInsets.all(values.cardInnerPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: values.titleFontSize,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.onBackground,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: values.fieldSpacing),
                                  CustomTextField(
                                    label: 'Email Address',
                                    hintText: 'Enter your email address',
                                    errorText: state.emailError,
                                    onChanged: (value) => context.read<LoginBloc>().add(EmailChanged(value)),
                                  ),
                                  CustomTextField(
                                    label: 'Password',
                                    hintText: 'Enter your password',
                                    obscureText: state.obscurePassword,
                                    errorText: state.passwordError,
                                    onChanged: (value) => context.read<LoginBloc>().add(PasswordChanged(value)),
                                    onToggleVisibility: () => context.read<LoginBloc>().add(TogglePasswordVisibility()),
                                  ),
                                  // Remember me checkbox
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: Checkbox(
                                          value: state.rememberMe,
                                          onChanged: (v) => context.read<LoginBloc>().add(RememberMeToggled(v ?? false)),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          side: BorderSide(
                                            color: Colors.grey[400]!,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Remember me',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.onBackground.withValues(alpha: 0.4),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: values.fieldSpacing * 0.67),
                                  // Forgot Password
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTap: state.email.isEmpty || state.emailError != null
                                          ? null
                                          : () {
                                              context.read<LoginBloc>().add(ResetPasswordInitiated());
                                              context.read<LoginBloc>().add(ResetPasswordRequested());
                                            },
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: state.email.isEmpty || state.emailError != null
                                              ? AppColors.onBackground.withValues(alpha: 0.4)
                                              : AppColors.warning,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: values.fieldSpacing * 0.83),
                                  // Sign In Button
                                  state.isLoading
                                      ? Center(
                                          child: SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              color: AppColors.warning,
                                            ),
                                          ),
                                        )
                                      : Align(
                                          alignment: Alignment.center,
                                          child: SizedBox(
                                            width: values.buttonWidth,
                                            height: values.buttonHeight,
                                            child: ElevatedButton(
                                              onPressed: state.emailError != null ||
                                                      state.passwordError != null ||
                                                      state.email.isEmpty ||
                                                      state.password.isEmpty
                                                  ? null
                                                  : () => context.read<LoginBloc>().add(LoginSubmitted()),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.warning,
                                                padding: const EdgeInsets.symmetric(
                                                  vertical: 12,
                                                  horizontal: 24,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                elevation: 2,
                                                disabledBackgroundColor: Colors.grey[300],
                                              ),
                                              child: Text(
                                                'Sign In',
                                                style: TextStyle(
                                                  fontSize: deviceType == DeviceType.desktop ? 18 : 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.surface,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                  SizedBox(height: values.fieldSpacing * 0.83),
                                  // Sign up link
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                        "Don't have an account? ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.onBackground.withValues(alpha: 0.7),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/register');
                                        },
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: const Size(0, 0),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: Text(
                                          'Sign up here.',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.warning,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: deviceType == DeviceType.mobile ? 35 : 60,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// Enums and helper classes
enum DeviceType { mobile, tablet, desktop }

class ResponsiveValues {
  final double logoSize;
  final double logoFontSize;
  final double cardPadding;
  final double cardInnerPadding;
  final double titleFontSize;
  final double fieldSpacing;
  final double buttonHeight;
  final double buttonWidth;
  final double maxCardWidth;
  final double topSpacing;

  ResponsiveValues({
    required this.logoSize,
    required this.logoFontSize,
    required this.cardPadding,
    required this.cardInnerPadding,
    required this.titleFontSize,
    required this.fieldSpacing,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.maxCardWidth,
    required this.topSpacing,
  });
}