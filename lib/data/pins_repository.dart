import 'package:pintersest_clone/api/pins_api.dart';
import 'package:pintersest_clone/model/pin_model.dart';
import 'package:pintersest_clone/model/pin_request_model.dart';

class PinsRepository {
  PinsRepository(this._pinsApi);

  final PinsApi _pinsApi;

  Future<PinModel> getPin(String id) => _pinsApi.getPin(id);

  Future<List<PinModel>> getPins(
          {String userId, String boardId, int limit, int offset}) =>
      _pinsApi.getPins(
          userId: userId, boardId: boardId, limit: limit, offset: offset);

  Future<PinModel> savePin(PinRequestModel pinRequestModel) =>
      _pinsApi.savePin(pinRequestModel);
}
