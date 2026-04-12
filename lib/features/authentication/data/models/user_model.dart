import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mica_school_app/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String? uid;
  final String? nameAr;
  final String? nameEn;
  final String? profileImageUrl;
  final String? gradeEn;
  final String? gradeAr;
  final String? gradeNum;
  final String? majorEn;
  final String? majorAr;
  final String? majorId;
  final String? id;


  UserModel({
      this.uid,
      this.nameAr,
      this.nameEn,
      this.profileImageUrl,
      this.gradeEn,
      this.gradeAr,
      this.gradeNum,
      this.majorEn,
      this.majorAr,
      this.majorId,
      this.id,
      }) : super (
        uid: uid,
        nameAr: nameAr,
        nameEn: nameEn,
        profileImageUrl: profileImageUrl,
        gradeEn: gradeEn,
        gradeAr: gradeAr,
        gradeNum: gradeNum,
        majorEn: majorEn,
        majorAr: majorAr,
        majorId: majorId,
        id: id,
      );

    factory UserModel.fromSnapshot(DocumentSnapshot snap) {
      var snapshot = snap.data() as Map<String, dynamic>;

      return UserModel(
        uid: snapshot['uid'],
        nameAr: snapshot['nameAr'],
        nameEn: snapshot['nameEn'],
        profileImageUrl: snapshot['profileImageUrl'],
        gradeEn: snapshot['gradeEn'],
        gradeAr: snapshot['gradeAr'],
        gradeNum: snapshot['gradeNum'],
        majorEn: snapshot['majorEn'],
        majorAr: snapshot['majorAr'],
        majorId: snapshot['majorId'],
        id: snapshot['id'],
      );
    }



  Map<String, dynamic> toJson() => {
    'uid': uid,
    'nameAr': nameAr,
    'nameEn': nameEn,
    'profileImageUrl': profileImageUrl,
    'gradeEn': gradeEn,
    'gradeAr': gradeAr,
    'gradeNum': gradeNum,
    'majorEn': majorEn,
    'majorAr': majorAr,
    'majorId': majorId,
    'id': id,
  };


}