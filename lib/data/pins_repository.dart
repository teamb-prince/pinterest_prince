import 'package:pintersest_clone/api/pins_api.dart';
import 'package:pintersest_clone/model/pin_model.dart';

class PinsRepository {
  PinsRepository(this._pinsApi);

  final PinsApi _pinsApi;

  Future<PinModel> getPin(String id) => _pinsApi.getPin(id);

  Future<List<PinModel>> getPins() => _pinsApi.getPins();
}
