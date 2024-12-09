import 'package:dartz/dartz.dart';
import 'package:suri_checking_event_app/core/error/failures.dart';
import 'package:suri_checking_event_app/features/event/data/models/event_register_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/list_event_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/scan_qr_payload.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/event_detail_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/event_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/event_register_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/ticket_info_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/ticket_special_info_entity.dart';

abstract class EventRepository {
  Future<Either<Failure, EventDetailEntity>> getEventDetail(int payload);

  Future<Either<Failure, List<EventEntity>>> getListEvents(
      ListEventsPayload payload);

  Future<Either<Failure, EventRegisterEntity>> postEventRegister(
      EventRegisterPayload payload);

  Future<Either<Failure, TicketInfoEntity>> getTicketInfo(int payload);

  Future<Either<Failure, dynamic>> postScanQrCode(ScanQrPayload payload);

  Future<Either<Failure, TicketSpecialInfoEntity>> getTicketSpecialInfo(
      int payload);
}
