part of 'edit_profile_data_bloc.dart';

@immutable
abstract class EditProfileDataState {}

class EditProfileDataInitial extends EditProfileDataState {}

class EditAddressState extends EditProfileDataState {}

class EditNameState extends EditProfileDataState {}

class EditNumberState extends EditProfileDataState {}

class EditSuccessState extends EditProfileDataState {}

class EditFailedState extends EditProfileDataState {}
