import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:mica_school_app/features/attendance/data/datasources/attendance_remote_data_source.dart';
import 'package:mica_school_app/features/attendance/data/datasources/attendance_remote_data_source_impl.dart';
import 'package:mica_school_app/features/attendance/data/repositories/attendance_repo_impl.dart';
import 'package:mica_school_app/features/attendance/domain/repositories/attendance_repo.dart';
import 'package:mica_school_app/features/attendance/domain/usecases/get_recent_scans_usecase.dart';
import 'package:mica_school_app/features/attendance/domain/usecases/get_user_logs_usecase.dart';
import 'package:mica_school_app/features/attendance/presentation/cubit/attendance_log_cubit/attendance_log_cubit.dart';
import 'package:mica_school_app/features/attendance/presentation/cubit/attendance_scan_cubit/attendance_scan_cubit.dart';
import 'package:mica_school_app/features/authentication/data/datasources/remote_data_sources/auth_remote_data_source.dart';
import 'package:mica_school_app/features/authentication/data/datasources/remote_data_sources/auth_remote_data_source_impl.dart';
import 'package:mica_school_app/features/authentication/data/repositories/auth_repo_impl.dart';
import 'package:mica_school_app/features/authentication/domain/repositories/auth_repo.dart';
import 'package:mica_school_app/features/authentication/domain/usecases/get_current_uid_usecase.dart';
import 'package:mica_school_app/features/authentication/domain/usecases/get_single_user_usecase.dart';
import 'package:mica_school_app/features/authentication/domain/usecases/is_sign_in_usecase.dart';
import 'package:mica_school_app/features/authentication/domain/usecases/sign_in_user_usecase.dart';
import 'package:mica_school_app/features/authentication/domain/usecases/sign_out_user_usecase.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/credential_cubit/credential_cubit.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/get_single_user_cubit/get_single_user_cubit.dart';
import 'package:mica_school_app/features/authentication/presentation/cubit/user_cubit/user_cubit.dart';
import 'package:mica_school_app/features/home/data/datasources/auth_remote_data_source.dart';
import 'package:mica_school_app/features/home/data/datasources/auth_remote_data_source_impl.dart';
import 'package:mica_school_app/features/home/data/repositories/home_repo_impl.dart';
import 'package:mica_school_app/features/home/domain/repositories/home_repo.dart';
import 'package:mica_school_app/features/home/domain/usecases/get_exam_usecase.dart';
import 'package:mica_school_app/features/home/domain/usecases/get_property_usecase.dart';
import 'package:mica_school_app/features/home/presentation/cubit/schedule_cubit/schedule_cubit.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory(() => AuthCubit(
        signOutUserUsecase: sl.call(),
        isSignInUsecase: sl.call(),
        getCurrentUidUsecase: sl.call(),
      ));

  sl.registerFactory(() => CredentialCubit(
        signInUserUsecase: sl.call(),

      ));

  sl.registerFactory(() => UserCubit(
        getUsersUsecase: sl.call(),
      ));

        sl.registerFactory(() => ScheduleCubit(
        getSubjectUsecase: sl.call(),
        getExamUsecase: sl.call(),
      ));

  sl.registerFactory(() => GetSingleUserCubit(
        getSingleUserUsecase: sl.call(),
      ));

  sl.registerFactory(() => AttendanceScanCubit(
        getRecentScansUsecase: sl.call(),
      ));

      sl.registerFactory(() => AttendanceLogsCubit(
        getStudentLogsUseCase: sl.call(),
      ));







  // Use Cases
  sl.registerLazySingleton(() => SignOutUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => IsSignInUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => GetCurrentUidUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => SignInUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => GetSingleUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => GetSubjectUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => GetExamUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => GetRecentScansUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => GetStudentLogsUseCase(repository: sl.call()));


  // Repository
  sl.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(authRemoteDataSource: sl.call()));

  sl.registerLazySingleton<HomeRepo>(
      () => HomeRepoImpl(homeRemoteDataSource: sl.call()));

  sl.registerLazySingleton<AttendanceRepo>(
      () => AttendanceRepoImpl(attendanceRemoteDataSource: sl.call()));


  //Remote Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
      firebaseFirestore: sl.call(),
      firebaseAuth: sl.call(),
      firebaseStorage: sl.call()));


       sl.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl(
      firebaseFirestore: sl.call(),));

       sl.registerLazySingleton<AttendanceRemoteDataSource>(() => AttendanceRemoteDataSourceImpl());



  // Externals
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;


  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseStorage);
}
