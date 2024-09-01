import 'package:employe_app/src/data/auth_datasource.dart';
import 'package:employe_app/src/data/employe_datasource.dart';
import 'package:employe_app/src/models/employe_model.dart';
import 'package:employe_app/src/models/user_model.dart';
import 'package:employe_app/src/presentation/helper/constant.dart';
import 'package:employe_app/src/presentation/helper/methods.dart';
import 'package:employe_app/src/presentation/helper/navigator_helper.dart';
import 'package:employe_app/src/presentation/pages/auth/login_page.dart';
import 'package:employe_app/src/presentation/pages/profile/edit_profile.dart';
import 'package:employe_app/src/presentation/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel? user;
  EmployeModel? employeModel;
  bool isloadingHome = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      getUser();
      setState(() {});
    });
    super.initState();
  }

  getUser() async {
    setState(() {
      isloadingHome = true;
    });
    String? uid = AuthDataSource().getInLoggedUser();
    var resut = await AuthDataSource().getUser(uid ?? '');
    resut.fold(
      (l) {
        setState(() {
          isloadingHome = false;
        });
      },
      (r) async {
        var result = await EmployeDatasource().getEmploye(r.uid ?? '');
        result.fold(
          (l) {
            setState(() {
              isloadingHome = false;
            });
          },
          (r) {
            setState(() {
              employeModel = r;
              setState(() {
                isloadingHome = false;
              });
            });
          },
        );
        setState(() {
          user = r;
          setState(() {
            isloadingHome = false;
          });
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
        title: user?.role == 'admin'
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('List Pegawai'),
                  IconButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        if (FirebaseAuth.instance.currentUser == null) {
                          Navigator.pushReplacement(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.logout,
                      ))
                ],
              )
            : const Text('Home'),
        automaticallyImplyLeading: user?.role == 'admin' ? false : true,
      ),
      floatingActionButton: user?.role == 'admin'
          ? InkWell(
              onTap: () {
                NavigatorHelper.push(context, const EditProfile(isEdit: false));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: saffron,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Tambah\nPegawai'),
                ),
              ),
            )
          : Container(),
      drawer: user?.role == 'admin'
          ? Container()
          : Drawer(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(20),
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    verticalSpace(20),
                    const Text(
                      'Nama',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    verticalSpace(4),
                    Text(
                      user?.name ?? '-',
                    ),
                    verticalSpace(10),
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    verticalSpace(4),
                    Text(
                      user?.email ?? '-',
                    ),
                    verticalSpace(10),
                    const Text(
                      'No.Telp',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    verticalSpace(4),
                    Text(
                      employeModel?.phoneNumber ?? '-',
                    ),
                    verticalSpace(10),
                    const Text(
                      'Tempat Lahir',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    verticalSpace(4),
                    Text(
                      employeModel?.placeBirth ?? '-',
                    ),
                    verticalSpace(10),
                    const Text(
                      'Tanggal Lahir',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    verticalSpace(4),
                    Text(
                      employeModel?.dateOfBirth ?? '-',
                    ),
                    verticalSpace(10),
                    const Text(
                      'Jenis Kelamin',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    verticalSpace(4),
                    Text(employeModel?.gender ?? '-'),
                    const Text(
                      'Agama',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    verticalSpace(4),
                    Text(
                      employeModel?.religion ?? '-',
                    ),
                    verticalSpace(10),
                    const Text(
                      'Alamat',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    verticalSpace(4),
                    Text(
                      employeModel?.address ?? '-',
                    ),
                    verticalSpace(10),
                    const Text(
                      'Status Pegawai',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    verticalSpace(4),
                    Text(
                      employeModel?.status ?? '-',
                    ),
                    verticalSpace(10),
                    const Text(
                      'Golongan Darah',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    verticalSpace(4),
                    Text(
                      employeModel?.bloodType ?? '-',
                    ),
                    verticalSpace(30),
                    Button(
                      onPressed: () {
                        NavigatorHelper.push(
                            context,
                            EditProfile(
                              isEdit: employeModel == null ? false : true,
                            ));
                      },
                      child: const Center(
                        child: Text('Edit Profile'),
                      ),
                    ),
                    verticalSpace(20),
                    Button(
                      border: Border.all(color: saffron),
                      color: ghostWhite,
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        if (FirebaseAuth.instance.currentUser == null) {
                          Navigator.pushReplacement(
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        }
                      },
                      child: const Center(
                        child: Text('Logout'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      body: isloadingHome || user?.role == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : user?.role != 'admin'
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    top: 20,
                  ),
                  child: Text(
                    user?.role == null ? '' : 'Selamat Datang\n${user?.name}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : FutureBuilder(
                  future: EmployeDatasource().getAllEmploye(),
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 20,
                      ),
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          var item = snapshot.data![index];
                          return InkWell(
                            onTap: () {
                              NavigatorHelper.push(
                                context,
                                EditProfile(
                                  isEdit: true,
                                  employeModelDta: item,
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Card(
                                color: saffron,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Nama',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          verticalSpace(5),
                                          const Text(
                                            'Jabatan',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          verticalSpace(5),
                                          const Text(
                                            'Tempat, Tanggal Lahir',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          verticalSpace(5),
                                          const Text(
                                            'Status Pegawai',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      horizontalSpace(5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ': ${item.name}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          verticalSpace(5),
                                          Text(
                                            ': ${item.appliedPosition ?? ''}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          verticalSpace(5),
                                          Text(
                                            ': ${item.placeBirth}, ${item.dateOfBirth}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          verticalSpace(5),
                                          Text(
                                            ': ${item.status}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
