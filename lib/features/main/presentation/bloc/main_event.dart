class MainEvent {}

class LoadProfile extends MainEvent {
  LoadProfile();

  @override
  List<Object?> get props => [];
}

class UpdateAvatar extends MainEvent {
  String urlAvatar;
  UpdateAvatar(this.urlAvatar);

  @override
  List<Object?> get props => [urlAvatar];
}

class LogOutProfile extends MainEvent {
  LogOutProfile();

  @override
  List<Object?> get props => [];
}
