import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mica_school_app/features/authentication/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String? uid;
  final String? id;
  final String? nameAr;
  final String? nameEn;
  final String? profileImageUrl;
  final String? gradeEn;
  final String? gradeAr;
  final String? gradeNum;
  final String? majorEn;
  final String? majorAr;
  final String? majorId;
  final String? department;
  final String? lab;


  UserModel({
      this.uid,
      this.id,
      this.nameAr,
      this.nameEn,
      this.profileImageUrl,
      this.gradeEn,
      this.gradeAr,
      this.gradeNum,
      this.majorEn,
      this.majorAr,
      this.majorId,
      this.department,
      this.lab,

      }) : super (
        uid: uid,
        id: id,
        nameAr: nameAr,
        nameEn: nameEn,
        profileImageUrl: profileImageUrl,
        gradeEn: gradeEn,
        gradeAr: gradeAr,
        gradeNum: gradeNum,
        majorEn: majorEn,
        majorAr: majorAr,
        majorId: majorId,
        department: department,
        lab: lab,
      );

    factory UserModel.fromSnapshot(DocumentSnapshot snap) {
      var snapshot = snap.data() as Map<String, dynamic>;

      return UserModel(
        uid: snapshot['uid'],
        id: snapshot['id'],
        nameAr: snapshot['nameAr'],
        nameEn: snapshot['nameEn'],
        profileImageUrl: snapshot['profileImageUrl'],
        gradeEn: snapshot['gradeEn'],
        gradeAr: snapshot['gradeAr'],
        gradeNum: snapshot['gradeNum'],
        majorEn: snapshot['majorEn'],
        majorAr: snapshot['majorAr'],
        majorId: snapshot['majorId'],
        department: snapshot['department'],
        lab: snapshot['lab'],
      );
    }



  Map<String, dynamic> toJson() => {
    'uid': uid,
    'id': id,
    'nameAr': nameAr,
    'nameEn': nameEn,
    'profileImageUrl': profileImageUrl,
    'gradeEn': gradeEn,
    'gradeAr': gradeAr,
    'gradeNum': gradeNum,
    'majorEn': majorEn,
    'majorAr': majorAr,
    'majorId': majorId,
    'department': department,
    'lab': lab,
  };
}