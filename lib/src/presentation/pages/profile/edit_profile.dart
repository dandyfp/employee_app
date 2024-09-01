import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:employe_app/src/data/auth_datasource.dart';
import 'package:employe_app/src/data/employe_datasource.dart';
import 'package:employe_app/src/models/employe_model.dart';
import 'package:employe_app/src/models/user_model.dart';
import 'package:employe_app/src/presentation/helper/constant.dart';
import 'package:employe_app/src/presentation/helper/date_format.dart';
import 'package:employe_app/src/presentation/helper/methods.dart';
import 'package:employe_app/src/presentation/helper/navigator_helper.dart';
import 'package:employe_app/src/presentation/helper/validator.dart';
import 'package:employe_app/src/presentation/pages/auth/register_page.dart';
import 'package:employe_app/src/presentation/pages/home/home_page.dart';
import 'package:employe_app/src/presentation/widgets/button.dart';
import 'package:employe_app/src/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EditProfile extends StatefulWidget {
  final EmployeModel? employeModelDta;

  final bool isEdit;
  const EditProfile({
    super.key,
    required this.isEdit,
    this.employeModelDta,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

TextEditingController nameController = TextEditingController();
TextEditingController appliedPositionController = TextEditingController();
TextEditingController identityNumberController = TextEditingController();
TextEditingController genderController = TextEditingController();
TextEditingController placeBirthController = TextEditingController();
TextEditingController dateOfBirthController = TextEditingController();
TextEditingController religionController = TextEditingController();
TextEditingController bloodTypeController = TextEditingController();
TextEditingController statusController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController otherNumberCanBeCallController = TextEditingController();
TextEditingController skillController = TextEditingController();
TextEditingController expectedSalaryController = TextEditingController();
TextEditingController availableEverywherePlacementController =
    TextEditingController();
TextEditingController lastJobHistoryController = TextEditingController();
TextEditingController trainingHistoryController = TextEditingController();
TextEditingController lastEducationController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();

class _EditProfileState extends State<EditProfile> {
  Gender? gender = Gender.male;
  Placment? placment = Placment.yes;
  Status? status = Status.yes;
  bool isLoadingSave = false;

  EmployeDatasource employeDatasourc = EmployeDatasource();

  UserModel? userData;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      getUser();
      setState(() {});
    });
    super.initState();
  }

  getUser() async {
    String? uid = AuthDataSource().getInLoggedUser();
    var resut = await AuthDataSource().getUser(uid ?? '');
    resut.fold(
      (l) {},
      (r) async {
        if (widget.isEdit == true && r.role != 'admin') {
          var result = await employeDatasourc.getEmploye(r.uid ?? '');
          result.fold(
            (l) {},
            (r) {
              gender = r.gender == 'perempuan' ? Gender.female : Gender.male;
              placment = r.availableEverywherePlacement == 'yes'
                  ? Placment.yes
                  : Placment.no;
              nameController.text = r.name ?? '';
              appliedPositionController.text = r.appliedPosition ?? '';
              identityNumberController.text = r.phoneNumber ?? '';
              placeBirthController.text = r.placeBirth ?? '';
              dateOfBirthController.text = r.dateOfBirth ?? '';
              religionController.text = r.religion ?? '';
              bloodTypeController.text = r.bloodType ?? '';
              statusController.text = r.status ?? '';
              addressController.text = r.address ?? '';
              otherNumberCanBeCallController.text =
                  r.otherNumberCanBeCall ?? '';
              skillController.text = r.skill ?? '';
              expectedSalaryController.text = r.expectedSalary ?? '';
              lastJobHistoryController.text = r.lastJobHistory ?? '';
              trainingHistoryController.text = r.trainingHistory ?? '';
              lastEducationController.text = r.lastEducation ?? '';
              phoneNumberController.text = r.phoneNumber ?? '';
            },
          );
        } else if (widget.isEdit == true && r.role == 'admin') {
          status = widget.employeModelDta?.status == 'Aftif'
              ? Status.yes
              : Status.no;
          gender = widget.employeModelDta?.gender == 'perempuan'
              ? Gender.female
              : Gender.male;
          placment =
              widget.employeModelDta?.availableEverywherePlacement == 'yes'
                  ? Placment.yes
                  : Placment.no;
          nameController.text = widget.employeModelDta?.name ?? '';
          appliedPositionController.text =
              widget.employeModelDta?.appliedPosition ?? '';
          identityNumberController.text =
              widget.employeModelDta?.phoneNumber ?? '';
          placeBirthController.text = widget.employeModelDta?.placeBirth ?? '';
          dateOfBirthController.text =
              widget.employeModelDta?.dateOfBirth ?? '';
          religionController.text = widget.employeModelDta?.religion ?? '';
          bloodTypeController.text = widget.employeModelDta?.bloodType ?? '';
          statusController.text = widget.employeModelDta?.status ?? '';
          addressController.text = widget.employeModelDta?.address ?? '';
          otherNumberCanBeCallController.text =
              widget.employeModelDta?.otherNumberCanBeCall ?? '';
          skillController.text = widget.employeModelDta?.skill ?? '';
          expectedSalaryController.text =
              widget.employeModelDta?.expectedSalary ?? '';
          lastJobHistoryController.text =
              widget.employeModelDta?.lastJobHistory ?? '';
          trainingHistoryController.text =
              widget.employeModelDta?.trainingHistory ?? '';
          lastEducationController.text =
              widget.employeModelDta?.lastEducation ?? '';
          phoneNumberController.text =
              widget.employeModelDta?.phoneNumber ?? '';
          setState(() {});
        }

        setState(() {
          emailController.text = r.email ?? '';
          userData = r;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            verticalSpace(30),
            if (userData?.role == 'admin') const Text('Status Pegawai'),
            if (userData?.role == 'admin')
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Radio<Status>(
                            value: Status.yes,
                            groupValue: status,
                            activeColor: saffron,
                            fillColor: WidgetStateProperty.all(saffron),
                            onChanged: (Status? value) async {
                              EmployeModel data = EmployeModel(
                                userId: AuthDataSource().getInLoggedUser(),
                                employeId: widget.employeModelDta?.employeId,
                                appliedPosition: appliedPositionController.text,
                                address: addressController.text,
                                gender: gender == Gender.female
                                    ? 'Perempuan'
                                    : 'Laki-laki',
                                bloodType: bloodTypeController.text,
                                dateOfBirth: dateOfBirthController.text,
                                placeBirth: placeBirthController.text,
                                email: emailController.text,
                                name: nameController.text,
                                identityNumber: identityNumberController.text,
                                availableEverywherePlacement:
                                    placment == Placment.yes ? 'Ya' : 'Tidak',
                                expectedSalary: expectedSalaryController.text,
                                lastEducation: lastEducationController.text,
                                lastJobHistory: lastEducationController.text,
                                otherNumberCanBeCall:
                                    otherNumberCanBeCallController.text,
                                phoneNumber: phoneNumberController.text,
                                religion: religionController.text,
                                skill: skillController.text,
                                trainingHistory: trainingHistoryController.text,
                                status: 'Aktif',
                              );
                              setState(() {
                                isLoadingSave = true;
                              });
                              if (widget.isEdit == true) {
                                var result =
                                    await employeDatasourc.updateEmploye(data);
                                result.fold((l) {
                                  setState(() {
                                    isLoadingSave = false;
                                  });
                                }, (r) {
                                  setState(() {
                                    isLoadingSave = false;
                                    NavigatorHelper.pushAndRemoveUntil(
                                      context,
                                      const HomePage(),
                                      (route) => false,
                                    );
                                    AnimatedSnackBar.material(
                                            'Success Edit Data',
                                            type: AnimatedSnackBarType.success)
                                        .show(context);
                                  });
                                });
                              }
                              var result =
                                  await employeDatasourc.updateEmploye(data);
                              result.fold(
                                (l) {
                                  setState(() {
                                    isLoadingSave = false;
                                  });
                                },
                                (r) {
                                  setState(() {
                                    isLoadingSave = false;

                                    AnimatedSnackBar.material(
                                            'Success Edit Data',
                                            type: AnimatedSnackBarType.success)
                                        .show(context);
                                  });
                                },
                              );
                              setState(() {
                                status = value;
                              });
                            },
                          ),
                        ),
                        horizontalSpace(4),
                        const Text(
                          'Aktif',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Radio(
                            value: Status.no,
                            groupValue: status,
                            activeColor: saffron,
                            fillColor: WidgetStateProperty.all(
                              saffron,
                            ),
                            onChanged: (Status? value) async {
                              EmployeModel data = EmployeModel(
                                userId: AuthDataSource().getInLoggedUser(),
                                appliedPosition: appliedPositionController.text,
                                address: addressController.text,
                                gender: gender == Gender.female
                                    ? 'Perempuan'
                                    : 'Laki-laki',
                                bloodType: bloodTypeController.text,
                                dateOfBirth: dateOfBirthController.text,
                                placeBirth: placeBirthController.text,
                                email: emailController.text,
                                name: nameController.text,
                                identityNumber: identityNumberController.text,
                                availableEverywherePlacement:
                                    placment == Placment.yes ? 'Ya' : 'Tidak',
                                expectedSalary: expectedSalaryController.text,
                                lastEducation: lastEducationController.text,
                                lastJobHistory: lastEducationController.text,
                                otherNumberCanBeCall:
                                    otherNumberCanBeCallController.text,
                                phoneNumber: phoneNumberController.text,
                                religion: religionController.text,
                                skill: skillController.text,
                                trainingHistory: trainingHistoryController.text,
                                status: 'Tidak Aktif',
                              );
                              setState(() {
                                isLoadingSave = true;
                              });
                              if (widget.isEdit == true) {
                                var result =
                                    await employeDatasourc.updateEmploye(data);
                                result.fold((l) {
                                  setState(() {
                                    isLoadingSave = false;
                                  });
                                }, (r) {
                                  setState(() {
                                    isLoadingSave = false;
                                    NavigatorHelper.pushAndRemoveUntil(
                                      context,
                                      const HomePage(),
                                      (route) => false,
                                    );
                                    AnimatedSnackBar.material(
                                            'Success Edit Data',
                                            type: AnimatedSnackBarType.success)
                                        .show(context);
                                  });
                                });
                              }
                              var result =
                                  await employeDatasourc.updateEmploye(data);
                              result.fold(
                                (l) {
                                  setState(() {
                                    isLoadingSave = false;
                                  });
                                },
                                (r) {
                                  setState(() {
                                    isLoadingSave = false;

                                    AnimatedSnackBar.material(
                                            'Success Edit Data',
                                            type: AnimatedSnackBarType.success)
                                        .show(context);
                                  });
                                },
                              );
                              setState(() {
                                status = value;
                              });
                            },
                          ),
                        ),
                        horizontalSpace(4),
                        const Text(
                          'Non Aktif',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            verticalSpace(30),
            KTextField(
              label: 'Posisi yang Dilamar',
              maxLines: 1,
              minLines: 1,
              controller: appliedPositionController,
              keyboardType: TextInputType.name,
              borderColor: Colors.grey,
              validator: Validator.requiredValidator.call,
            ),
            verticalSpace(10),
            KTextField(
              label: 'Nama',
              maxLines: 1,
              minLines: 1,
              controller: nameController,
              keyboardType: TextInputType.name,
              borderColor: Colors.grey,
              validator: Validator.requiredValidator.call,
            ),
            verticalSpace(10),
            KTextField(
              label: 'No.KTP ',
              maxLines: 1,
              minLines: 1,
              controller: identityNumberController,
              keyboardType: TextInputType.name,
              borderColor: Colors.grey,
              validator: Validator.requiredValidator.call,
            ),
            verticalSpace(10),
            KTextField(
              label: 'Tempat Lahir',
              maxLines: 1,
              minLines: 1,
              controller: placeBirthController,
              keyboardType: TextInputType.name,
              borderColor: Colors.grey,
              validator: Validator.requiredValidator.call,
            ),
            verticalSpace(10),
            KTextField(
              label: 'Tanggal Lahir',
              maxLines: 1,
              minLines: 1,
              isOption: true,
              controller: dateOfBirthController,
              keyboardType: TextInputType.name,
              borderColor: Colors.grey,
              validator: Validator.requiredValidator.call,
              onTap: () {
                showDatePicker(context);
              },
            ),
            verticalSpace(10),
            const Text('Jenis Kelamin'),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Radio<Gender>(
                          value: Gender.male,
                          groupValue: gender,
                          activeColor: saffron,
                          fillColor: WidgetStateProperty.all(saffron),
                          onChanged: (Gender? value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                      ),
                      horizontalSpace(4),
                      const Text(
                        'Laki-Laki',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Radio(
                          value: Gender.female,
                          groupValue: gender,
                          activeColor: saffron,
                          fillColor: WidgetStateProperty.all(
                            saffron,
                          ),
                          onChanged: (Gender? value) {
                            setState(() {
                              gender = value;
                            });
                          },
                        ),
                      ),
                      horizontalSpace(4),
                      const Text(
                        'Perempuan',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            KTextField(
              label: 'Agama',
              maxLines: 1,
              minLines: 1,
              controller: religionController,
              keyboardType: TextInputType.name,
              borderColor: Colors.grey,
              validator: Validator.requiredValidator.call,
            ),
            verticalSpace(10),
            KTextField(
              label: 'Golongan Darah',
              maxLines: 1,
              minLines: 1,
              controller: bloodTypeController,
              keyboardType: TextInputType.name,
              borderColor: Colors.grey,
              validator: Validator.requiredValidator.call,
            ),
            verticalSpace(10),
            KTextField(
              label: 'Alamat',
              maxLines: 1,
              minLines: 1,
              controller: addressController,
              keyboardType: TextInputType.name,
              borderColor: Colors.grey,
              validator: Validator.requiredValidator.call,
            ),
            verticalSpace(10),
            KTextField(
              label: 'Email',
              maxLines: 1,
              minLines: 1,
              isOption: true,
              controller: emailController,
              keyboardType: TextInputType.name,
              borderColor: Colors.grey,
              validator: Validator.requiredValidator.call,
            ),
            verticalSpace(10),
            KTextField(
              label: 'No.Telp',
              maxLines: 1,
              minLines: 1,
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              borderColor: Colors.grey,
              validator: Validator.requiredValidator.call,
            ),
            verticalSpace(10),
            KTextField(
              label: 'ORANG TERDEKAT YANG DAPAT DIHUBUNGI',
              maxLines: 1,
              minLines: 1,
              controller: otherNumberCanBeCallController,
              keyboardType: TextInputType.number,
              borderColor: Colors.grey,
              validator: Validator.requiredValidator.call,
            ),
            verticalSpace(10),
            KTextField(
              label: 'Pendidikan Terakhir',
              maxLines: 1,
              minLines: 1,
              controller: lastEducationController,
              keyboardType: TextInputType.name,
              borderColor: Colors.grey,
              validator: Validator.requiredValidator.call,
            ),
            verticalSpace(10),
            KTextField(
              label: 'Riwayat Pelatihan',
              maxLines: 1,
              minLines: 1,
              controller: trainingHistoryController,
              keyboardType: TextInputType.name,
              borderColor: Colors.grey,
              validator: Validator.requiredValidator.call,
            ),
            verticalSpace(10),
            KTextField(
              label: 'Riwayat Pekerjaan Terakhir',
              maxLines: 1,
              minLines: 1,
              controller: lastJobHistoryController,
              keyboardType: TextInputType.name,
              borderColor: Colors.grey,
              validator: Validator.requiredValidator.call,
            ),
            verticalSpace(10),
            KTextField(
              label: 'Skill',
              maxLines: 1,
              minLines: 1,
              controller: skillController,
              keyboardType: TextInputType.name,
              borderColor: Colors.grey,
              validator: Validator.requiredValidator.call,
            ),
            verticalSpace(10),
            const Text('Bersedia ditempatkan di seluruh kantor perusahaan'),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Radio<Placment>(
                          value: Placment.no,
                          groupValue: placment,
                          activeColor: saffron,
                          fillColor: WidgetStateProperty.all(saffron),
                          onChanged: (Placment? value) {
                            setState(() {
                              placment = value;
                            });
                          },
                        ),
                      ),
                      horizontalSpace(4),
                      const Text(
                        'Tidak',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Transform.scale(
                        scale: 1.5,
                        child: Radio(
                          value: Placment.yes,
                          groupValue: placment,
                          activeColor: saffron,
                          fillColor: WidgetStateProperty.all(
                            saffron,
                          ),
                          onChanged: (Placment? value) {
                            setState(() {
                              placment = value;
                            });
                          },
                        ),
                      ),
                      horizontalSpace(4),
                      const Text(
                        'Ya',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            KTextField(
              label: 'Penghasilan yang Diharapkan',
              maxLines: 1,
              minLines: 1,
              controller: expectedSalaryController,
              keyboardType: TextInputType.name,
              borderColor: Colors.grey,
              validator: Validator.requiredValidator.call,
            ),
            verticalSpace(10),
            Button(
              isLoading: isLoadingSave,
              isDisabled: isLoadingSave,
              onPressed: () async {
                EmployeModel data = EmployeModel(
                  userId: AuthDataSource().getInLoggedUser(),
                  appliedPosition: appliedPositionController.text,
                  address: addressController.text,
                  gender: gender == Gender.female ? 'Perempuan' : 'Laki-laki',
                  bloodType: bloodTypeController.text,
                  dateOfBirth: dateOfBirthController.text,
                  placeBirth: placeBirthController.text,
                  email: emailController.text,
                  name: nameController.text,
                  identityNumber: identityNumberController.text,
                  availableEverywherePlacement:
                      placment == Placment.yes ? 'Ya' : 'Tidak',
                  expectedSalary: expectedSalaryController.text,
                  lastEducation: lastEducationController.text,
                  lastJobHistory: lastEducationController.text,
                  otherNumberCanBeCall: otherNumberCanBeCallController.text,
                  phoneNumber: phoneNumberController.text,
                  religion: religionController.text,
                  skill: skillController.text,
                  trainingHistory: trainingHistoryController.text,
                  status: widget.isEdit == true
                      ? widget.employeModelDta?.status
                      : 'Tidak aktif',
                );
                setState(() {
                  isLoadingSave = true;
                });
                var result = widget.isEdit == false
                    ? await employeDatasourc.createEmploye(data)
                    : await employeDatasourc.updateEmploye(data);
                result.fold(
                  (l) {
                    setState(() {
                      isLoadingSave = false;
                    });
                  },
                  (r) {
                    setState(() {
                      isLoadingSave = false;
                      NavigatorHelper.pushAndRemoveUntil(
                        context,
                        const HomePage(),
                        (route) => false,
                      );
                      AnimatedSnackBar.material('Success Edit Data',
                              type: AnimatedSnackBarType.success)
                          .show(context);
                    });
                  },
                );
              },
              child: const Center(
                child: Text('Save'),
              ),
            ),
            verticalSpace(20)
          ],
        ),
      ),
    );
  }

  showDatePicker(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SfDateRangePicker(
              onSelectionChanged:
                  (DateRangePickerSelectionChangedArgs value) {},
              showActionButtons: true,
              confirmText: 'Konfirmasi',
              cancelText: 'Batal',
              onCancel: () {
                Navigator.pop(context);
              },
              onSubmit: (val) {
                setState(() {
                  dateOfBirthController.text = FormatDate().formatDate(
                      val.toString(),
                      context: context,
                      format: 'dd MMM yyyy');
                });
                Navigator.pop(context);
              },
              selectionColor: saffron,
              todayHighlightColor: saffron,
              rangeSelectionColor: saffron.withOpacity(0.75),
              selectionMode: DateRangePickerSelectionMode.single,
              initialSelectedDate: DateTime.now(),
            ),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

enum Gender {
  female,
  male,
}

enum Placment {
  yes,
  no,
}

enum Status {
  yes,
  no,
}
