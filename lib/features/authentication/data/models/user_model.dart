import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mica_school_app/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String? uid;
  final String? name;
  final String? id;


  UserModel({
      this.uid,
      this.name,
      this.id,
      }) : super (
        uid: uid,
        name: name,
        id: id,

      );

    factory UserModel.fromSnapshot(DocumentSnapshot snap) {
      var snapshot = snap.data() as Map<String, dynamic>;

      return UserModel(
        uid: snapshot['uid'],
        name: snapshot['name'],
        id: snapshot['id'],
      );
    }



  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'id': id,
  };


}