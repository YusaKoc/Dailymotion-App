import 'package:dailymotion_app/app/common/constants/app_constants.dart';
import 'package:dailymotion_app/app/features/auth_features/presentation/cubit/register_cubit.dart';
import 'package:dailymotion_app/app/features/auth_features/presentation/cubit/register_state.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_button_styles.dart';
import 'package:dailymotion_app/app/common/theme/app_styles/app_input_styles.dart';
import 'package:dailymotion_app/core/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _surnameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _rePasswordCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _surnameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _rePasswordCtrl.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final cubit = context.read<RegisterCubit>();
      cubit.updateField(
        name: _nameCtrl.text,
        surname: _surnameCtrl.text,
        email: _emailCtrl.text,
        password: _passwordCtrl.text,
        rePassword: _rePasswordCtrl.text,
      );
      cubit.register();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status == RegisterStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        } else if (state.status == RegisterStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              _buildField("İsim", _nameCtrl, Icons.person,
                  (val) => val!.isValidName ? null : 'Geçersiz isim'),
              _buildField("Soyisim", _surnameCtrl, Icons.person_outline,
                  (val) => val!.isValidName ? null : 'Geçersiz soyisim'),
              _buildField(
                  "E-posta",
                  _emailCtrl,
                  Icons.mail,
                  (val) => val!.isValidEmail ? null : 'Geçersiz email',
                  TextInputType.emailAddress),
              _buildPasswordField(state),
              _buildRePasswordField(state),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: state.status == RegisterStatus.loading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        style: AppButtonStyles.primary,
                        onPressed: _onSubmit,
                        child: const Text('Kayıt Ol'),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildField(
    String hint,
    TextEditingController controller,
    IconData icon,
    String? Function(String?) validator, [
    TextInputType type = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  ]) {
    return Padding(
      padding: AppPadding.vertical8,
      child: TextFormField(
        controller: controller,
        decoration: AppInputStyles.inputDecoration(
          context,
          hint: hint,
          icon: icon,
        ).copyWith(suffixIcon: suffixIcon),
        keyboardType: type,
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }

  Widget _buildPasswordField(RegisterState state) {
    return _buildField(
      "Şifre",
      _passwordCtrl,
      Icons.lock_outline,
      (val) => val!.isValidPassword ? null : 'En az 6 karakter',
      TextInputType.text,
      state.obscurePassword,
      IconButton(
        icon: Icon(
            state.obscurePassword ? Icons.visibility_off : Icons.visibility),
        onPressed: () =>
            context.read<RegisterCubit>().togglePasswordVisibility(),
      ),
    );
  }

  Widget _buildRePasswordField(RegisterState state) {
    return _buildField(
      "Tekrar Şifre",
      _rePasswordCtrl,
      Icons.lock,
      (val) => val == _passwordCtrl.text ? null : 'Şifreler eşleşmiyor',
      TextInputType.text,
      state.obscureRePassword,
      IconButton(
        icon: Icon(
            state.obscureRePassword ? Icons.visibility_off : Icons.visibility),
        onPressed: () =>
            context.read<RegisterCubit>().toggleRePasswordVisibility(),
      ),
    );
  }
}
