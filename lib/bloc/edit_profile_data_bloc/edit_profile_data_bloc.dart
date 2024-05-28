import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:diplom_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:diplom_new/features/repository/change_address_organization_repository/change_address_organization_repository.dart';
import 'package:diplom_new/features/repository/change_name_organization_repository/change_name_organization_repository.dart';
import 'package:diplom_new/features/repository/change_number_organization_repository/change_number_organization_repository.dart';
import 'package:meta/meta.dart';

part 'edit_profile_data_event.dart';
part 'edit_profile_data_state.dart';

class EditProfileDataBloc
    extends Bloc<EditProfileDataEvent, EditProfileDataState> {
  String? _token;
  String? vendorId;
  EditProfileDataBloc() : super(EditProfileDataInitial()) {
    AuthMiddleware.authData.listen((event) {
      _token = event.toString();
      log('===== event=$event =====');
    });
    AuthMiddleware.user.listen((event) {
      vendorId = event.vendor?.id.toString();
      log('===== event=$event =====');
    });

    on<EditAddressEvent>(
      (event, emit) => emit(EditAddressState()),
    );
    on<EditNumberEvent>(
      (event, emit) => emit(EditNumberState()),
    );
    on<EditNameEvent>(
      (event, emit) => emit(EditNameState()),
    );
    on<EditProfileEvent>(
      (event, emit) async {
        if (state is EditAddressState) {
          log(state.toString());
          try {
            final repository = ChangeAddressOrganizationRepository(
              _token!,
              vendorId!,
              event.newData,
            );
            await repository.changeAddress();
            emit(EditSuccessState());
          } catch (e) {
            log(e.toString());
            emit(EditFailedState());
          }
        } else if (state is EditNumberState) {
          log(state.toString());
          try {
            final repository = ChangeNumberOrganizationRepository(
              _token!,
              vendorId!,
              event.newData,
            );
            await repository.changeNumber();
            emit(EditSuccessState());
          } catch (e) {
            log(e.toString());
            emit(EditFailedState());
          }
        } else if (state is EditNameState) {
          log(state.toString());
          try {
            final repository = ChangeNameOrganizationRepository(
              _token!,
              vendorId!,
              event.newData,
            );
            await repository.changeName();
            emit(EditSuccessState());
          } catch (e) {
            log(e.toString());
            emit(EditFailedState());
          }
        } else {
          log(state.toString());
        }
      },
    );
  }
}
