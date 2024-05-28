part of 'edit_profile_data_bloc.dart';

@immutable
abstract class EditProfileDataEvent {}

class EditAddressEvent extends EditProfileDataEvent {}

class EditNameEvent extends EditProfileDataEvent {}

class EditNumberEvent extends EditProfileDataEvent {}

class EditProfileEvent extends EditProfileDataEvent {
  final String newData;

  EditProfileEvent({required this.newData});
}
