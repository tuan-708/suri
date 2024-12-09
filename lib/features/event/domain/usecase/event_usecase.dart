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
import 'package:suri_checking_event_app/features/event/domain/repositories/event_repositories.dart';

class EventUseCases {
  final EventRepository eventRepository;
  EventUseCases({required this.eventRepository});

  Future<Either<Failure, EventDetailEntity>> getEventDetail(int payload) async {
    return await eventRepository.getEventDetail(payload);
  }

  Future<Either<Failure, List<EventEntity>>> getListEvents(
      ListEventsPayload payload) async {
    return await eventRepository.getListEvents(payload);
  }

  Future<Either<Failure, EventRegisterEntity>> postEventRegister(
      EventRegisterPayload payload) async {
    return await eventRepository.postEventRegister(payload);
  }

  Future<Either<Failure, TicketInfoEntity>> getTicketInfo(int payload) async {
    return await eventRepository.getTicketInfo(payload);
  }

  Future<Either<Failure, dynamic>> postScanQrCode(ScanQrPayload payload) async {
    return await eventRepository.postScanQrCode(payload);
  }

  Future<Either<Failure, TicketSpecialInfoEntity>> getTicketSpecialInfo(
      int payload) async {
    return await eventRepository.getTicketSpecialInfo(payload);
  }
}
