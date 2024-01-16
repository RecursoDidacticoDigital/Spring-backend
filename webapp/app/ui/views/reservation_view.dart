import '../../api/requestsApi.dart';
import '../../providers/request_form_provider.dart';
import 'package:flutter/material.dart';

import '../../router/router.dart';
import '../../services/navigation_service.dart';
import '../inputs/custom_inputs.dart';
import '../buttons/custom_outlined_button.dart';
import 'package:provider/provider.dart';

class ReservationView extends StatefulWidget {
  ReservationView({super.key});

  @override
  State<ReservationView> createState() => _ReservationViewState();
}

class _ReservationViewState extends State<ReservationView> {
  void navigateTo(String routeName){
    NavigationService.navigateTo(routeName);
  }
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
      create: (_) => RequestFormProvider(),
      child: Builder(
        builder: (context) {

          final requestFormProvider = Provider.of<RequestFormProvider>(context, listen: false);

          return Container(
            margin: const EdgeInsets.only(top: 100),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 370, maxHeight: 600),
                child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: requestFormProvider.formKey,
                  child: Column(
                    children: [
                      
                      // Nombre completo
                      TextFormField(
                        onChanged: (value) => requestFormProvider.subject = value,
                        validator: (value){
                          if(value == null || value.isEmpty) return 'El nombre de la actividad es obligatorio';
                          return null;
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: CustomInputs.reservationInputDecoration(
                          hint: 'Ingrese el nombre de la actividad',
                          label: 'Nombre de la actividad',
                          icon: Icons.local_activity_outlined,
                        ),
                      ),
    
                      const SizedBox(height: 20),
    
                      // No. Cuenta
                      TextFormField(
                        onChanged: (value) => requestFormProvider.classroom = value,
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
                        style: const TextStyle(color: Colors.black),
                        decoration: CustomInputs.reservationInputDecoration(
                          hint: 'Ingrese el número del salón',
                          label: 'Número del salón',
                          icon: Icons.numbers_outlined,
                        ),
                      ),
    
                      const SizedBox(height: 20),

                      // Email
                      TextFormField(
                        onChanged: (value) => requestFormProvider.memberName = value,
                        validator: (value){
                          if(value == null || value.isEmpty) return 'El nombre del profesor es obligatorio';
                          return null;
                        },
                        style: const TextStyle(color: Colors.black),
                        decoration: CustomInputs.reservationInputDecoration(
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
                        onChanged: (newDay){
                          selectedDay = newDay;
                          requestFormProvider.dayId = getDayId(newDay!);
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
                        onChanged: (newTimeblock){
                          selectedTimeblock = newTimeblock;
                          requestFormProvider.timeblockId = getTimeblockId(newTimeblock!);
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
                        onPressed: (){

                          final validForm = requestFormProvider.validateForm();
                          if(!validForm) return;
                          
                          final requestProvider = Provider.of<RequestsApi>(context, listen: false);
                          requestProvider.postRequests(
                            requestFormProvider.memberName,
                            requestFormProvider.memberAccount,
                            requestFormProvider.department,
                            requestFormProvider.classroom,
                            requestFormProvider.dayId,
                            requestFormProvider.timeblockId,
                            requestFormProvider.subject,
                            0
                          );

                          navigateTo(Flurorouter.classroomReserveFormRoute);
                        }, 
                        text: 'Enviar solicitud',
                        color: Colors.blue.shade900,
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

  String? onFormSubmit(RequestFormProvider requestFormProvider/*, AuthApi authProvider*/) {
    final isValid = requestFormProvider.validateForm();
    if(isValid){
      String? response = "${requestFormProvider.memberName}, ${requestFormProvider.classroom}, ${requestFormProvider.subject}, ${requestFormProvider.dayId}, ${requestFormProvider.timeblockId}";
      return response;
      //authProvider.login(loginFormProvider.account, loginFormProvider.email, loginFormProvider.password);
    }
    return null;
  }
}

int getDayId(String option){
    switch(option){
      case "Lunes": return 1;
      case "Martes": return 2;
      case "Miercoles": return 3;
      case "Jueves": return 4;
      case "Viernes": return 5;
      default: return 1;
    }
}

int getTimeblockId(String option){
  switch (option){
    case "07:00 - 08:30": return 1;
    case "08:30 - 10:00": return 2;
    case "10:30 - 12:00": return 3;
    case "12:00 - 13:30": return 4;
    case "13:30 - 15:00": return 5;
    case "15:00 - 16:30": return 6;
    case "16:30 - 18:00": return 7;
    case "18:30 - 20:00": return 8;
    case "20:00 - 21:30": return 9;
    default: return 1;
  }
}