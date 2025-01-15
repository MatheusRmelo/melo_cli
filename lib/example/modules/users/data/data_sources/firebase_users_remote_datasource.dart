import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../commons/models/response_model.dart';
import '../../domain/models/user_model.dart';

abstract class IUsersRemoteDataSource {
  Future<ResponseModel<List<UserModel>>> findAll();
  Future<ResponseModel<UserModel>> findById(String id);
  Future<ResponseModel<bool>> update(String id, UserModel body);
  Future<ResponseModel<UserModel>> create(UserModel body);
  Future<ResponseModel<bool>> delete(String id);
}

class UsersRemoteDataSource implements IUsersRemoteDataSource {
  final CollectionReference<UserModel> _collection =
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
            fromFirestore: (snapshot, options) {
              var json = snapshot.data();
              json!['id'] = snapshot.id;
              return UserModel.fromJson(json);
            },
            toFirestore: (value, options) => value.toJson(),
          );
  @override
  Future<ResponseModel<List<UserModel>>> findAll() async {
    var response = await _collection.get();

    return ResponseModel(
        ok: true, result: response.docs.map((e) => e.data()).toList());
  }

  @override
  Future<ResponseModel<UserModel>> findById(String id) async {
    var response = await _collection.doc(id).get();

    return ResponseModel(ok: true, result: response.data());
  }

  @override
  Future<ResponseModel<bool>> update(String id, UserModel body) async {
    try {
      await _collection.doc(id).update(body.toJson());
      return ResponseModel(ok: true, result: true);
    } catch (err) {
      return ResponseModel(ok: false, result: false);
    }
  }

  @override
  Future<ResponseModel<UserModel>> create(UserModel body) async {
    try {
      var response = await _collection.add(body);
      return ResponseModel(ok: true, result: (await response.get()).data());
    } catch (err) {
      return ResponseModel(
          ok: false, result: null, description: err.toString());
    }
  }

  @override
  Future<ResponseModel<bool>> delete(String id) async {
    try {
      await _collection.doc(id).delete();
      return ResponseModel(ok: true, result: true);
    } catch (err) {
      return ResponseModel(ok: false, result: false);
    }
  }
}
