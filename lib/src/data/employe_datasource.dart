import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:employe_app/src/models/employe_model.dart';

class EmployeDatasource {
  Future<Either<String, String>> updateEmploye(EmployeModel data) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.doc('employe/${data.employeId}');

    DocumentSnapshot<Map<String, dynamic>> result =
        await documentReference.get();
    if (result.exists) {
      await documentReference.update({
        "userId": data.userId,
        "employeId": data.employeId,
        "appliedPosition": data.appliedPosition,
        "name": data.name,
        "identityNumber": data.identityNumber,
        "gender": data.gender,
        "placeBirth": data.placeBirth,
        "dateOfBirth": data.dateOfBirth,
        "religion": data.religion,
        "bloodType": data.bloodType,
        "status": data.status,
        "address": data.address,
        "email": data.email,
        "phoneNumber": data.phoneNumber,
        "otherNumberCanBeCall": data.otherNumberCanBeCall,
        "lastEducation": data.lastEducation,
        "skill": data.skill,
        "trainingHistory": data.trainingHistory,
        "lastJobHistory": data.lastJobHistory,
        "expectedSalary": data.expectedSalary,
        "availableEverywherePlacement": data.availableEverywherePlacement,
      });
      return right('Success');
    } else {
      return left('Failed');
    }
  }

  Future<Either<String, EmployeModel>> createEmploye(EmployeModel data) async {
    String id = data.userId ?? '';
    CollectionReference<Map<String, dynamic>> complaint =
        FirebaseFirestore.instance.collection('employe');
    await complaint.doc(id).set(
      {
        "userId": data.userId,
        "employeId": id,
        "appliedPosition": data.appliedPosition,
        "name": data.name,
        "identityNumber": data.identityNumber,
        "gender": data.gender,
        "placeBirth": data.placeBirth,
        "dateOfBirth": data.dateOfBirth,
        "religion": data.religion,
        "bloodType": data.bloodType,
        "status": data.status,
        "address": data.address,
        "email": data.email,
        "phoneNumber": data.phoneNumber,
        "otherNumberCanBeCall": data.otherNumberCanBeCall,
        "lastEducation": data.lastEducation,
        "skill": data.skill,
        "trainingHistory": data.trainingHistory,
        "lastJobHistory": data.lastJobHistory,
        "expectedSalary": data.expectedSalary,
        "availableEverywherePlacement": data.availableEverywherePlacement,
      },
    );

    DocumentSnapshot<Map<String, dynamic>> result =
        await complaint.doc(id).get();
    if (result.exists) {
      return right(
        EmployeModel.fromJson(
          result.data()!,
        ),
      );
    } else {
      return left('failed to create data');
    }
  }

  Future<List<EmployeModel>> getAllEmploye() async {
    QuerySnapshot<Map<String, dynamic>> complaints =
        await FirebaseFirestore.instance.collection('employe').get();
    List<EmployeModel> data =
        complaints.docs.map((e) => EmployeModel.fromJson(e.data())).toList();
    return data;
  }

  Future<Either<String, EmployeModel>> getEmploye(String uid) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.doc('employe/$uid');

    DocumentSnapshot<Map<String, dynamic>> result =
        await documentReference.get();
    if (result.exists) {
      return right(EmployeModel.fromJson(result.data()!));
    } else {
      return left("Failed to get user");
    }
  }
}
