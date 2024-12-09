import 'package:image_picker/image_picker.dart';
import 'package:suri_checking_event_app/features/user/data/models/change_password_payload.dart';
import 'package:suri_checking_event_app/features/user/data/models/change_profile_payload.dart';

class UserEvent {}

// Xóa tài khoản
class PostDeleteAccount extends UserEvent {
  PostDeleteAccount();

  @override
  List<Object?> get props => [];
}

// Thay đổi mật khẩu
class PostChangePassword extends UserEvent {
  ChangePasswordPayload payload;
  PostChangePassword(this.payload);

  @override
  List<Object?> get props => [];
}

// Đăng avatar
class UploadAvatar extends UserEvent {
  XFile pickFile;
  UploadAvatar(this.pickFile);

  @override
  List<Object?> get props => [pickFile];
}

// Change profile
class ChangeProfile extends UserEvent {
  ChangeProfilePayload payload;
  ChangeProfile(this.payload);

  @override
  List<Object?> get props => [payload];
}

// Get Event Remains
class GetEventRemains extends UserEvent {
  int payload;
  GetEventRemains(this.payload);

  @override
  List<Object?> get props => [payload];
}
