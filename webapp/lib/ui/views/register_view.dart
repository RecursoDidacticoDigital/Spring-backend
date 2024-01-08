import 'package:admin_dashboard_new/api/authApi.dart';
import 'package:admin_dashboard_new/providers/register_form_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard_new/router/router.dart';

import 'package:admin_dashboard_new/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard_new/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard_new/ui/buttons/link_text.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      child: Builder(
        builder: (context) {

          final registerFormProvider = Provider.of<RegisterFormProvider>(context, listen: false);

          return Container(
            margin: const EdgeInsets.only(top: 100),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 370, maxHeight: 600),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: registerFormProvider.formKey,
                  child: Column(
                    children: [
    
                      // Nombre completo
                      TextFormField(
                        onChanged: (value) => registerFormProvider.name = value,
                        validator: (value){
                          if(value == null || value.isEmpty) return 'El nombre es obligatorio';
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.loginInputDecoration(
                          hint: 'Ingrese su nombre completo',
                          label: 'Nombre',
                          icon: Icons.verified_user_outlined,
                        ),
                      ),
    
                      const SizedBox(height: 20),
    
                      // No. Cuenta
                      TextFormField(
                        onChanged: (value) => registerFormProvider.account = value,
                        validator: (value){
                          if(value == null || value.isEmpty) return 'Ingrese su número de cuenta';
                          if(value.length < 10) return 'Su número de cuenta debe tener 10 caracteres';
                          try{
                            int.parse(value);
                            return null;
                          }
                          catch(exception) {
                            return 'Caracter no válido, ingrese sólo números';
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.loginInputDecoration(
                          hint: 'Ingrese su no. de cuenta',
                          label: 'Número de cuenta',
                          icon: Icons.account_box_outlined,
                        ),
                      ),
    
                      const SizedBox(height: 20),

                      // Email
                      TextFormField(
                        onChanged: (value) => registerFormProvider.email = value,
                        validator: (value){
                          if(!EmailValidator.validate(value ?? '')) return 'Email no válido';
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.loginInputDecoration(
                          hint: 'Ingrese su Correo Institucional',
                          label: 'Email Inst.',
                          icon: Icons.email_outlined,
                        ),
                      ),
    
                      const SizedBox(height: 20),
    
                      // Contraseña
                      TextFormField(
                        
                        onChanged: (value) => registerFormProvider.password = value,
                        validator: ( value ) {
                          if ( value == null || value.isEmpty ) return 'Ingrese su contraseña';
                          if ( value.length < 6 ) return 'La contraseña debe de ser de 6 caracteres';

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

                          final validForm = registerFormProvider.validateForm();
                          if(!validForm) return;

                          final authProvider = Provider.of<AuthProvider>(context, listen: false);
                          authProvider.register(
                            registerFormProvider.name,
                            registerFormProvider.account,
                            registerFormProvider.email,
                            registerFormProvider.password,
                          );

                        }, 
                        text: 'Registrarse',
                        color: Colors.blue,
                        isFilled: true,
                      ),
    
                      const SizedBox(height: 20),
    
                      LinkText(
                        text: 'Ir al login',
                        onPressed: (){
                          Navigator.pushNamed(context, Flurorouter.loginRoute);
                        },
                      )
                    ],
                  )
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}