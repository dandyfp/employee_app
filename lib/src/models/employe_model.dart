// To parse this JSON data, do
//
//     final employeModel = employeModelFromJson(jsonString);

import 'dart:convert';

EmployeModel employeModelFromJson(String str) =>
    EmployeModel.fromJson(json.decode(str));

String employeModelToJson(EmployeModel data) => json.encode(data.toJson());

class EmployeModel {
  final String? userId;
  final String? employeId;
  final String? appliedPosition;
  final String? name;
  final String? identityNumber;
  final String? gender;
  final String? placeBirth;
  final String? dateOfBirth;
  final String? religion;
  final String? bloodType;
  final String? status;
  final String? address;
  final String? email;
  final String? phoneNumber;
  final String? otherNumberCanBeCall;
  final String? lastEducation;
  final String? skill;
  final String? trainingHistory;
  final String? lastJobHistory;
  final String? expectedSalary;
  final String? availableEverywherePlacement;

  EmployeModel({
    this.userId,
    this.employeId,
    this.appliedPosition,
    this.name,
    this.identityNumber,
    this.gender,
    this.placeBirth,
    this.dateOfBirth,
    this.religion,
    this.bloodType,
    this.status,
    this.address,
    this.email,
    this.phoneNumber,
    this.otherNumberCanBeCall,
    this.lastEducation,
    this.skill,
    this.trainingHistory,
    this.lastJobHistory,
    this.expectedSalary,
    this.availableEverywherePlacement,
  });

  factory EmployeModel.fromJson(Map<String, dynamic> json) => EmployeModel(
        userId: json["userId"],
        employeId: json["employeId"],
        appliedPosition: json["appliedPosition"],
        name: json["name"],
        identityNumber: json["identityNumber"],
        gender: json["gender"],
        placeBirth: json["placeBirth"],
        dateOfBirth: json["dateOfBirth"],
        religion: json["religion"],
        bloodType: json["bloodType"],
        status: json["status"],
        address: json["address"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        otherNumberCanBeCall: json["otherNumberCanBeCall"],
        lastEducation: json["lastEducation"],
        skill: json["skill"],
        trainingHistory: json["trainingHistory"],
        lastJobHistory: json["lastJobHistory"],
        expectedSalary: json["expectedSalary"],
        availableEverywherePlacement: json["availableEverywherePlacement"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "employeId": employeId,
        "appliedPosition": appliedPosition,
        "name": name,
        "identityNumber": identityNumber,
        "gender": gender,
        "placeBirth": placeBirth,
        "dateOfBirth": dateOfBirth,
        "religion": religion,
        "bloodType": bloodType,
        "status": status,
        "address": address,
        "email": email,
        "phoneNumber": phoneNumber,
        "otherNumberCanBeCall": otherNumberCanBeCall,
        "lastEducation": lastEducation,
        "skill": skill,
        "trainingHistory": trainingHistory,
        "lastJobHistory": lastJobHistory,
        "expectedSalary": expectedSalary,
        "availableEverywherePlacement": availableEverywherePlacement,
      };
}
