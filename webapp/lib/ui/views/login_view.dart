import 'package:admin_dashboard_new/providers/auth_provider.dart';
import 'package:admin_dashboard_new/providers/login_form_provider.dart';
//import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard_new/router/router.dart';

import 'package:admin_dashboard_new/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard_new/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard_new/ui/buttons/link_text.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    
    final authProvider = Provider.of<AuthProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),
      child: Builder(builder: ( context ){

        final loginFormProvider = Provider.of<LoginFormProvider>(context, listen: false);
        
        return Container(
          margin: const EdgeInsets.only(top: 100),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 370),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: loginFormProvider.formKey,

                child: Column(
                  children: [
                    // No. de cuenta
                    TextFormField(
                      validator: (value){
                        if(value == null || value.isEmpty) return 'Ingrese su número de cuenta';
                        if(value.length > 10) return 'Su número de cuenta debe tener máximo 10 caracteres';
                        try{
                          int.parse(value);
                          return null;
                        }
                        catch(exception) {
                          return 'Caracter no válido, ingrese sólo números';
                        }
                      },
                      onChanged: (value) => loginFormProvider.account = value,
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.loginInputDecoration(
                        hint: 'Ingrese su no. de cuenta',
                        label: 'Número de cuenta',
                        icon: Icons.account_box_outlined,
                      ),
                    ),
      
                    const SizedBox(height: 20),
      
                    // Password
                    TextFormField(
                      onFieldSubmitted: (_) => onFormSubmit(loginFormProvider, authProvider),
                      onChanged: (value) => loginFormProvider.password = value,
                      validator: (value){
                        // Password no válido
                        if(value == null || value.isEmpty) return 'Ingrese su contraseña';
                        if(value.length < 6) return 'La contraseña debe ser mayor de 6 caracteres';
      
                        return null; // Válido
                      },
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.loginInputDecoration(
                        hint: '*******',
                        label: 'Contraseña',
                        icon: Icons.lock_outline,
                      ),
                    ),
      
                    const SizedBox(height: 20),

                    CustomOutlinedButton(
                      onPressed: (){
                        onFormSubmit(loginFormProvider, authProvider);
                      }, 
                      text: 'Ingresar',
                      color: Colors.blue,
                      isFilled: true,
                    ),
      
                    const SizedBox(height: 20),
      
                    LinkText(
                      text: 'Nueva cuenta',
                      onPressed: (){
                        Navigator.pushNamed(context, Flurorouter.registerRoute);
                      },
                    )
                  ],
                )
              ),
            ),
          ),
        );
      }),
    );
  }
}

void onFormSubmit(LoginFormProvider loginFormProvider, AuthProvider authProvider) {
  final isValid = loginFormProvider.validateForm();
  if(isValid){
    authProvider.login(loginFormProvider.account, loginFormProvider.password);
  }
}