import 'package:admin_dashboard_new/providers/reservation_form_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard_new/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard_new/ui/buttons/custom_outlined_button.dart';
import 'package:provider/provider.dart';

class ReservationView extends StatelessWidget {
  const ReservationView({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> dayOptions = [
      'Lunes',
      'Martes',
      'Miercoles',
      'Jueves',
      'Viernes',
    ];
    String? selectedDay;

    List<String> timeblockOptions = [
      '07:00 - 08:30',
      '08:30 - 10:00',
      '10:30 - 12:00',
      '12:00 - 13:30',
      '13:30 - 15:00',
      '15:00 - 16:30',
      '16:30 - 18:00',
      '18:30 - 20:00',
      '20:00 - 21:30',
    ];
    String? selectedTimeblock;
    
    return ChangeNotifierProvider(
      create: (_) => ReservationFormProvider(),
      child: Builder(
        builder: (context) {

          final reservationFormProvider = Provider.of<ReservationFormProvider>(context, listen: false);

          return Container(
            margin: const EdgeInsets.only(top: 100),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 370, maxHeight: 600),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: reservationFormProvider.formKey,
                  child: Column(
                    children: [
                      
                      // Nombre completo
                      TextFormField(
                        onChanged: (value) => reservationFormProvider.name = value,
                        validator: (value){
                          if(value == null || value.isEmpty) return 'El nombre de la actividad es obligatorio';
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.loginInputDecoration(
                          hint: 'Ingrese el nombre de la actividad',
                          label: 'Nombre de la actividad',
                          icon: Icons.local_activity_outlined,
                        ),
                      ),
    
                      const SizedBox(height: 20),
    
                      // No. Cuenta
                      TextFormField(
                        onChanged: (value) => reservationFormProvider.classroom = value,
                        validator: (value){
                          if(value == null || value.isEmpty) return 'El número del salón es obligatorio';
                          if(value.length < 4 || value.length > 4) return 'El salón tiene 4 dígitos';
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
                          hint: 'Ingrese el número del salón',
                          label: 'Número del salón',
                          icon: Icons.numbers_outlined,
                        ),
                      ),
    
                      const SizedBox(height: 20),

                      // Email
                      TextFormField(
                        onChanged: (value) => reservationFormProvider.teacher = value,
                        validator: (value){
                          if(!EmailValidator.validate(value ?? '')) return 'El nombre del profesor es obligatorio';
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.loginInputDecoration(
                          hint: 'Ingrese su nombre',
                          label: 'Nombre del profesor',
                          icon: Icons.account_box_outlined,
                        ),
                      ),

                      const SizedBox(height: 20),

                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'Selecciona un día',
                          border: OutlineInputBorder(),
                        ),
                        value: selectedDay,
                        onChanged: (String? newDay){
                          selectedDay = newDay;
                        },
                        items: dayOptions.map<DropdownMenuItem<String>>((String value){
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value)
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 20),

                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'Selecciona un horario',
                          border: OutlineInputBorder(),
                        ),
                        value: selectedTimeblock,
                        onChanged: (String? newTimeblock){
                          selectedTimeblock = newTimeblock;
                        },
                        items: timeblockOptions.map<DropdownMenuItem<String>>((String value){
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value)
                          );
                        }).toList(),
                      ),
    
                      const SizedBox(height: 20),

                      CustomOutlinedButton(
                        // TODO: Añadir funcionalidad al formulario.
                        onPressed: (){}, 
                        text: 'Registrarse',
                        color: Colors.blue,
                        isFilled: true,
                      ),
    
                      const SizedBox(height: 20),
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