import 'package:bloc/bloc.dart';
import 'package:citracker/services/firebase_auth_service.dart';
import 'package:meta/meta.dart';

import '../../core/constants/storage.dart';
import '../../global.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LogoutActionEvent>(_logoutHandler);
  }

  void _logoutHandler(
      LogoutActionEvent event, Emitter<ProfileState> emit) async {
    emit(LogoutLoading());
    try {
      FirebaseAuthService().logout();
      await Global.storageService
          .remove(StorageConstants.STORAGE_USER_TOKEN_KEY);
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailed(message: e.toString()));
    }
  }
}
