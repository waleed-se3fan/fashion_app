part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class PickCameraState extends ProfileState {}

class UpdateProfileSucces extends ProfileState {}

class UpdateEyeState extends ProfileState {}

class ChangeStateState extends ProfileState {}
