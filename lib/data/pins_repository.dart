import 'dart:io';

import 'package:pintersest_clone/api/pins_api.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/model/pin_request_model.dart';

class PinsRepository {
  PinsRepository(this._pinsApi);

  final PinsApi _pinsApi;

  Future<PinModel> getPin(String id) => _pinsApi.getPin(id);

  Future<List<PinModel>> getPins() => _pinsApi.getPins();

  Future<List<PinModel>> getDiscoverPins() => _pinsApi.getDiscoverPins();

  Future<PinModel> savePinFromUrl(PinRequestModel pinRequestModel) =>
      _pinsApi.savePinWithUrl(pinRequestModel);

  Future<PinModel> savePinFromLocal(File image,
      PinRequestModel pinRequestModel) =>
      _pinsApi.savePinWithImage(image, pinRequestModel);
}
