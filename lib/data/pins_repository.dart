import 'package:pintersest_clone/api/pins_api.dart';
import 'package:pintersest_clone/model/pin_model.dart';

class PinsRepository {
  final PinsApi _pinsApi;

  PinsRepository(this._pinsApi);

  Future<PinModel> getPin(String id) => _pinsApi.getPin(id);
}