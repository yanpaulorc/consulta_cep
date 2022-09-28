import '../model/cep.dart';
import '../repositories/cep_repository.dart';

class CepController {
  final _cepRepository = CepRepository();

  Future<Cep?> buscarCEP(String cep) async {
    final cepCidade = await _cepRepository.buscarCEP(cep);
    print(cepCidade);
    return cepCidade;
  }
}
