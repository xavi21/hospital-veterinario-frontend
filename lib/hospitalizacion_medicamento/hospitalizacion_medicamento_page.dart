import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paraiso_canino/hospitalizacion_medicamento/bloc/hospitalizacionmedicamento_bloc.dart';
import 'package:paraiso_canino/hospitalizacion_medicamento/widget/hospitalizacion_medicamento_body.dart';

class HospitalizacionMedicamentoPage extends StatelessWidget {
  final int idhospitalizacion;
  const HospitalizacionMedicamentoPage({
    super.key,
    required this.idhospitalizacion,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HospitalizacionmedicamentoBloc(),
      child: HospitalizacionMedicamentoBody(
        idhospitalizacion: idhospitalizacion,
      ),
    );
  }
}
