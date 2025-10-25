import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thoughts/presentation/widget/custom_text_field.dart';
import 'package:thoughts/theme/app_theme.dart';
import 'package:thoughts/view_models/register_view_model.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterViewModel(),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

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
          cardInnerPadding: 14.0,
          titleFontSize: 25,
          fieldSpacing: 7,
          buttonHeight: 43,
          buttonWidth: 117,
          maxCardWidth: double.infinity,
          topSpacing: 4.0,
          logoBottomSpacing: 10.0,
        );
      case DeviceType.tablet:
        return ResponsiveValues(
          logoSize: 38,
          logoFontSize: 32,
          cardPadding: 32.0,
          cardInnerPadding: 24.0,
          titleFontSize: 28,
          fieldSpacing: 12,
          buttonHeight: 48,
          buttonWidth: 130,
          maxCardWidth: 600,
          topSpacing: 20.0,
          logoBottomSpacing: 20.0,
        );
      case DeviceType.desktop:
        return ResponsiveValues(
          logoSize: 42,
          logoFontSize: 36,
          cardPadding: 48.0,
          cardInnerPadding: 32.0,
          titleFontSize: 32,
          fieldSpacing: 16,
          buttonHeight: 52,
          buttonWidth: 145,
          maxCardWidth: 650,
          topSpacing: 30.0,
          logoBottomSpacing: 30.0,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final deviceType = _getDeviceType(screenWidth);
    final values = _getResponsiveValues(deviceType);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Consumer<RegisterViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.isSuccess && !viewModel.successMessageShown) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Registration Successful! Please login.',
                    ),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(16),
                    duration: const Duration(seconds: 3),
                    onVisible: () =>
                        viewModel.markSuccessMessageShown(), // Mark as shown
                  ),
                );
                Navigator.pushReplacementNamed(context, '/login');
              });
            }
            if (viewModel.errorMessage != null &&
                !viewModel.errorMessageShown) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(viewModel.errorMessage!),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(16),
                    duration: const Duration(seconds: 3),
                    onVisible: () => viewModel
                        .markErrorMessageShown(), // Mark error as shown
                  ),
                );
              });
            }
            if (viewModel.errorMessage != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(viewModel.errorMessage!),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(16),
                    duration: const Duration(seconds: 3),
                  ),
                );
              });
            }
            return Stack(
              children: [
                Container(color: AppColors.primary),
                Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceType == DeviceType.mobile ? 0 : 24,
                      vertical: deviceType == DeviceType.mobile ? 10 : 30,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo section
                        Padding(
                          padding: EdgeInsets.only(top: values.topSpacing),
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
                        SizedBox(height: values.logoBottomSpacing),
                        // Register Card
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
                                  'Register',
                                  style: TextStyle(
                                    fontSize: values.titleFontSize,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.onBackground,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: values.fieldSpacing),
                                CustomTextField(
                                  label: 'Name',
                                  hintText: 'Enter your name',
                                  errorText: viewModel.nameError,
                                  onChanged: viewModel.updateName,
                                ),
                                CustomTextField(
                                  label: 'Company Name',
                                  hintText: 'Enter your company name',
                                  errorText: viewModel.companyError,
                                  onChanged: viewModel.updateCompany,
                                ),
                                CustomTextField(
                                  label: 'Email Address',
                                  hintText: 'Enter your email address',
                                  errorText: viewModel.emailError,
                                  onChanged: viewModel.updateEmail,
                                ),
                                CustomTextField(
                                  label: 'Password',
                                  hintText: 'Enter your password',
                                  obscureText: viewModel.obscurePassword,
                                  errorText: viewModel.passwordError,
                                  onChanged: viewModel.updatePassword,
                                  // onToggleVisibility:
                                  //     viewModel.togglePasswordVisibility,
                                ),
                                CustomTextField(
                                  label: 'Confirm Password',
                                  hintText: 'Re-enter your password',
                                  obscureText: viewModel.obscureConfirmPassword,
                                  errorText: viewModel.confirmPasswordError,
                                  onChanged: viewModel.updateConfirmPassword,
                                  // onToggleVisibility:
                                  //     viewModel.toggleConfirmPasswordVisibility,
                                ),
                                // Terms & Conditions
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: Checkbox(
                                        value: viewModel.termsAccepted,
                                        onChanged: (v) =>
                                            viewModel.toggleTerms(v ?? false),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        side: BorderSide(
                                          color: Colors.grey[400]!,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                            fontSize:
                                                deviceType == DeviceType.desktop
                                                ? 15
                                                : 14,
                                            color: AppColors.onBackground,
                                            height: 1.4,
                                          ),
                                          children: [
                                            const TextSpan(
                                              text:
                                                  'By signing up, you agree to the FFE ',
                                            ),
                                            TextSpan(
                                              text: 'Terms & Conditions',
                                              style: TextStyle(
                                                color: AppColors.warning,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const TextSpan(text: ' and '),
                                            TextSpan(
                                              text: 'Privacy Policy',
                                              style: TextStyle(
                                                color: AppColors.warning,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (viewModel.termsError != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      viewModel.termsError!,
                                      style: TextStyle(
                                        color: AppColors.warning,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                SizedBox(height: values.fieldSpacing * 1.7),
                                // Buttons
                                Align(
                                  alignment: Alignment.center,
                                  child: Wrap(
                                    spacing: 16,
                                    runSpacing: 12,
                                    alignment: WrapAlignment.center,
                                    children: [
                                      _button(
                                        label: 'Cancel',
                                        color: Colors.grey[200]!,
                                        textColor: AppColors.onBackground,
                                        onTap: () => Navigator.pop(context),
                                        width: values.buttonWidth,
                                        height: values.buttonHeight,
                                        deviceType: deviceType,
                                      ),
                                      _button(
                                        label: 'Register',
                                        color: AppColors.warning,
                                        textColor: AppColors.surface,
                                        onTap:
                                            viewModel.isLoading ||
                                                viewModel.nameError != null ||
                                                viewModel.companyError !=
                                                    null ||
                                                viewModel.emailError != null ||
                                                viewModel.passwordError !=
                                                    null ||
                                                viewModel
                                                        .confirmPasswordError !=
                                                    null ||
                                                viewModel.termsError != null
                                            ? null
                                            : viewModel.register,
                                        width: values.buttonWidth,
                                        height: values.buttonHeight,
                                        deviceType: deviceType,
                                      ),
                                    ],
                                  ),
                                ),
                                if (viewModel.isLoading)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Center(
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          color: AppColors.warning,
                                        ),
                                      ),
                                    ),
                                  ),
                                SizedBox(height: values.fieldSpacing * 1.14),
                                // Sign In link
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      'Already have an account? ',
                                      style: TextStyle(
                                        fontSize:
                                            deviceType == DeviceType.desktop
                                            ? 14
                                            : 13,
                                        color: AppColors.onBackground
                                            .withValues(alpha: 0.7),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pushNamed(
                                        context,
                                        '/login',
                                      ),
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: const Size(0, 0),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      child: Text(
                                        'Sign in here.',
                                        style: TextStyle(
                                          fontSize:
                                              deviceType == DeviceType.desktop
                                              ? 15
                                              : 14,
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
                          height: deviceType == DeviceType.mobile ? 20 : 40,
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
    );
  }

  Widget _button({
    required String label,
    required Color color,
    required Color textColor,
    required VoidCallback? onTap,
    required double width,
    required double height,
    required DeviceType deviceType,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 2,
          disabledBackgroundColor: Colors.grey[300],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: deviceType == DeviceType.desktop ? 18 : 16,
            fontWeight: FontWeight.w600,
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
  final double logoBottomSpacing;

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
    required this.logoBottomSpacing,
  });
}
