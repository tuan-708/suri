import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/features/auth/presentation/pages/forgot_password.dart';
import 'package:suri_checking_event_app/features/auth/presentation/pages/login_page.dart';
import 'package:suri_checking_event_app/features/auth/presentation/pages/register_page.dart';
import 'package:suri_checking_event_app/features/event/data/models/event_detail_page_arguments.dart';
import 'package:suri_checking_event_app/features/event/data/models/event_special_detail_page_arguments.dart';
import 'package:suri_checking_event_app/features/event/data/models/share_event_page_arguments.dart';
import 'package:suri_checking_event_app/features/event/data/models/spin_wheel_arguments.dart';
import 'package:suri_checking_event_app/features/event/data/models/ticket_info_page_arguments.dart';
import 'package:suri_checking_event_app/features/event/data/models/ticket_info_special_page_arguments.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/event_detail_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/list_kol_entity.dart';
import 'package:suri_checking_event_app/features/event/presentation/pages/deal_hot_page.dart';
import 'package:suri_checking_event_app/features/event/presentation/pages/event_detail_page.dart';
import 'package:suri_checking_event_app/features/event/presentation/pages/event_detail_special.dart';
import 'package:suri_checking_event_app/features/event/presentation/pages/event_guide_page.dart';
import 'package:suri_checking_event_app/features/event/presentation/pages/event_timeline_page.dart';
import 'package:suri_checking_event_app/features/event/presentation/pages/kol_detail_page.dart';
import 'package:suri_checking_event_app/features/event/presentation/pages/list_event_page.dart';
import 'package:suri_checking_event_app/features/event/presentation/pages/queue_table_kol_page.dart';
import 'package:suri_checking_event_app/features/event/presentation/pages/list_kol_page.dart';
import 'package:suri_checking_event_app/features/event/presentation/pages/event_register_page.dart';
import 'package:suri_checking_event_app/features/event/presentation/pages/share_event_page.dart';
import 'package:suri_checking_event_app/features/event/presentation/pages/spin_wheel_page.dart';
import 'package:suri_checking_event_app/features/event/presentation/pages/ticket_special_page.dart';
import 'package:suri_checking_event_app/features/gift/data/models/gift_event_detail_page_arguments.dart';
import 'package:suri_checking_event_app/features/gift/presentation/pages/my_gift_event_page.dart';
import 'package:suri_checking_event_app/features/gift/presentation/pages/my_gift_page.dart';
import 'package:suri_checking_event_app/features/sponsor/data/models/list_gift_event_arguments.dart';
import 'package:suri_checking_event_app/features/sponsor/data/models/list_ponsors_event_page_arguments.dart';
import 'package:suri_checking_event_app/features/sponsor/data/models/sponsor_detail_page_arguments.dart';
import 'package:suri_checking_event_app/features/sponsor/presentation/pages/lists_ponsors_event_page.dart';
import 'package:suri_checking_event_app/features/sponsor/presentation/pages/sponsor_detail_page.dart';
import 'package:suri_checking_event_app/features/event/presentation/pages/ticket_page.dart';
import 'package:suri_checking_event_app/features/event/presentation/pages/voting_process_page.dart';
import 'package:suri_checking_event_app/features/gift/presentation/pages/gift_event_detail_page.dart';
import 'package:suri_checking_event_app/features/introduction/presentation/pages/introduction.dart';
import 'package:suri_checking_event_app/features/main/presentation/pages/main_page.dart';
import 'package:suri_checking_event_app/features/splash/presentation/splash_page.dart';
import 'package:suri_checking_event_app/features/user/presentation/pages/change_password_page.dart';
import 'package:suri_checking_event_app/features/user/presentation/pages/edit_user_page.dart';
import 'package:suri_checking_event_app/features/user/presentation/pages/my_rank_page.dart';
import 'package:suri_checking_event_app/features/user/presentation/pages/privacy_policy_page.dart';

class AppRoutes {
  // Splash
  static const String SPLASH_PAGE = '/splash';

  // Main
  static const String MAIN_PAGE = '/main_page';
  static const String HOME_PAGE = '/home';
  static const String ASSET_AUCTION_PAGE = '/asset_auction_page';
  static const String REGISTER_AUCTION_PAGE = '/register_auction_page';
  static const String NEW_PAGE = '/new_page';
  static const String USER_PAGE = '/user_page';

  // Auth
  static const String LOGIN_PAGE = '/login_page';
  static const String REGISTER_PAGE = '/register_page';
  static const String FORGOT_PASSWORD_PAGE = '/forgot_password_page';
  static const String CHANGE_PASSWORD_PAGE = '/change_password_page';
  static const String INTRODUCTION_PAGE = '/introduction_page';

  // Features
  static const String EVENT_DETAIL_PAGE = '/event_detail_page';
  static const String EVENT_SPECIAL_DETAIL_PAGE = '/event_special_detail_page';
  static const String REGISTER_EVENT_PAGE = '/register_event_page';
  static const String SPONSOR_DETAIL_PAGE = '/sponsor_detail_page';
  static const String GIFT_EVENT_DETAIL_PAGE = '/gift_event_detail_page';
  static const String TICKET_PAGE = '/ticket_page';
  static const String TICKET_SPECIAL_PAGE = '/ticket_special_page';
  static const String SHARE_EVENT_PAGE = '/share_event_page';
  static const String QUEUE_TABLE_KOL_PAGE = '/queue_table_kol_page';
  static const String LIST_KOL_PAGE = '/list_kol_page';
  static const String KOL_DETAIL_PAGE = '/kol_detail_page';
  static const String VOTING_PROCESS_PAGE = '/voting_process_page';
  static const String PRIVACY_POLICY_PAGE = '/privacy_police_page';
  static const String SPIN_WHEEL_PAGE = '/spin_wheel_page';
  static const String EDIT_USER_PAGE = '/edit_user_page';
  static const String LIST_SPONSORS_EVENT_PAGE = '/list_sponsors_event_page';
  static const String EVENT_TIMELINE_PAGE = '/event_timeline_page';
  static const String MY_GIFT_PAGE = '/my_gift_page';
  static const String MY_GIFT_EVENT_PAGE = '/my_gift_event_page';
  static const String MY_RANK_PAGE = '/my_rank_page';
  static const String DEAL_HOT_PAGE = '/deal_hot_page';
  static const String EVENT_GUIDE_PAGE = '/event_guide_page';
    static const String LIST_EVENT_PAGE = '/list_event_page';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Splash
      case SPLASH_PAGE:
        return slideFromRightRoute(const SplashPage());

      // Auth
      case INTRODUCTION_PAGE:
        return slideFromRightRoute(const IntroductionPage());
      case LOGIN_PAGE:
        return slideFromBottomRoute(const LoginPage());
      case REGISTER_PAGE:
        return fadeRoute(const RegisterPage());
      case FORGOT_PASSWORD_PAGE:
        return fadeRoute(const ForgotPassword());

      // Main
      case MAIN_PAGE:
        return slideFromRightRoute(const MainPage());

      //Features
      case EVENT_DETAIL_PAGE:
        return fadeRoute(EventDetailPage(
          args: settings.arguments as EventDetailPageArguments,
        ));
      case EVENT_SPECIAL_DETAIL_PAGE:
        return fadeRoute(EventSpecialDetailPage(
          args: settings.arguments as EventDetailSpecialPageArguments,
        ));
      case LIST_SPONSORS_EVENT_PAGE:
        return fadeRoute(ListSponsorsEventPage(
          args: settings.arguments as ListSponsorsEventPageArguments,
        ));
      case REGISTER_EVENT_PAGE:
        return fadeRoute(EventRegisterPage(
          args: settings.arguments as EventDetailEntity,
        ));
      case SPONSOR_DETAIL_PAGE:
        return fadeRoute(SponsorDetailPage(
          args: settings.arguments as SponsorDetailPageArguments,
        ));
      case GIFT_EVENT_DETAIL_PAGE:
        return fadeRoute(GiftEventDetailPage(
          args: settings.arguments as GiftEventDetailPageArguments,
        ));
      case TICKET_PAGE:
        return fadeRoute(TicketPage(
          args: settings.arguments as TicketInfoPageArguments,
        ));
      case TICKET_SPECIAL_PAGE:
        return fadeRoute(TicketSpecialPage(
          args: settings.arguments as TicketInfoSpecialPageArguments,
        ));
      case SHARE_EVENT_PAGE:
        return fadeRoute(ShareEventPage(
            args: settings.arguments as ShareEventPageArguments));
      case QUEUE_TABLE_KOL_PAGE:
        return fadeRoute(const QueueTableKOLPage());
      case LIST_KOL_PAGE:
        return fadeRoute(const ListKOLPage());
      case KOL_DETAIL_PAGE:
        return fadeRoute(KOLDetailPage(
          args: settings.arguments as KOLDetailsEntity,
        ));
      case VOTING_PROCESS_PAGE:
        return fadeRoute(const VotingProcessPage());
      case CHANGE_PASSWORD_PAGE:
        return fadeRoute(const ChangePasswordPage());
      case PRIVACY_POLICY_PAGE:
        return fadeRoute(const PrivacyPolicyPage());
      case SPIN_WHEEL_PAGE:
        return fadeRoute(SpinWheelPage(
          args: settings.arguments as SpinWheelArguments,
        ));
      case EDIT_USER_PAGE:
        return fadeRoute(const EditUserPage());
      case EVENT_TIMELINE_PAGE:
        return fadeRoute(const EventTimeLinePage());
      case MY_GIFT_PAGE:
        return fadeRoute(const MyGiftPage());
      case MY_GIFT_EVENT_PAGE:
        return fadeRoute(MyGiftEventPage(
          args: settings.arguments as ListGiftEventArguments,
        ));
      case MY_RANK_PAGE:
        return fadeRoute(const MyRankPage());
      case DEAL_HOT_PAGE:
        return fadeRoute(const DealHotPage());
      case EVENT_GUIDE_PAGE:
        return fadeRoute(const EventGuidePage());
          case LIST_EVENT_PAGE:
        return fadeRoute(const ListEventPage());

      default:
        return slideFromRightRoute(const SplashPage());
    }
  }

  // 1. Hiệu ứng Slide từ phải
  static PageRouteBuilder slideFromRightRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Trượt từ phải
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  // 2. Slide effect from left
  static PageRouteBuilder slideFromLeftRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  // 3. Hiệu ứng Slide từ dưới lên
  static PageRouteBuilder slideFromBottomRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // Trượt từ dưới
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  // 4. Hiệu ứng Slide từ trên xuống
  static PageRouteBuilder slideFromTopRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0); // Trượt từ trên xuống
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  // 5. Hiệu ứng Fade in / Fade out
  static PageRouteBuilder fadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  // 6. Hiệu ứng Scale (phóng to dần)
  static PageRouteBuilder scaleRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return ScaleTransition(scale: animation.drive(tween), child: child);
      },
    );
  }

  // 7. Hiệu ứng Rotation (xoay)
  static PageRouteBuilder rotationRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return RotationTransition(turns: animation, child: child);
      },
    );
  }

  // 8. Hiệu ứng SizeTransition (giãn rộng)
  static PageRouteBuilder sizeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return Align(
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
        );
      },
    );
  }

  // 9. Hiệu ứng Slide + Fade kết hợp
  static PageRouteBuilder slideFadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return FadeTransition(
          opacity: animation,
          child:
              SlideTransition(position: animation.drive(tween), child: child),
        );
      },
    );
  }

  // 10. Hiệu ứng Skew (lệch góc)
  static PageRouteBuilder skewRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 1.0); // Lệch góc từ phải dưới
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }
}
