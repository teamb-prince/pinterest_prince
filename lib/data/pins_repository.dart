import 'package:pintersest_clone/api/pins_api.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/model/pin_request_model.dart';

class PinsRepository {
  PinsRepository(this._pinsApi);

  final PinsApi _pinsApi;

  Future<PinModel> getPin(String id) => _pinsApi.getPin(id);

  Future<List<PinModel>> getPins() => _pinsApi.getPins();

  Future<PinModel> savePin(PinRequestModel pinRequestModel) =>
      _pinsApi.savePinWithUrl(pinRequestModel);
}
