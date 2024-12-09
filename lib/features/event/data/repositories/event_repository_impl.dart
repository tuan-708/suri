import 'package:dartz/dartz.dart';
import 'package:suri_checking_event_app/core/error/exceptions.dart';
import 'package:suri_checking_event_app/core/error/failures.dart';
import 'package:suri_checking_event_app/features/event/data/datasources/event_remote_data_source.dart';
import 'package:suri_checking_event_app/features/event/data/models/event_register_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/list_event_payload.dart';
import 'package:suri_checking_event_app/features/event/data/models/scan_qr_payload.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/event_detail_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/event_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/event_register_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/ticket_info_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/ticket_special_info_entity.dart';
import 'package:suri_checking_event_app/features/event/domain/repositories/event_repositories.dart';

class EventRepositoryImpl implements EventRepository {
  final EventRemoteDataSource eventRemoteDataSource;
  EventRepositoryImpl({required this.eventRemoteDataSource});

  @override
  Future<Either<Failure, EventDetailEntity>> getEventDetail(int payload) async {
    try {
      final eventDetail = await eventRemoteDataSource.getEventDetail(payload);
      return right(eventDetail);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<EventEntity>>> getListEvents(
      ListEventsPayload payload) async {
    try {
      final events = await eventRemoteDataSource.getListEvents(payload);
      return right(events);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EventRegisterEntity>> postEventRegister(
      EventRegisterPayload payload) async {
    try {
      final eventRegister =
          await eventRemoteDataSource.postEventRegister(payload);
      return right(eventRegister);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TicketInfoEntity>> getTicketInfo(int payload) async {
    try {
      final ticketInfo = await eventRemoteDataSource.getTicketInfo(payload);
      return right(ticketInfo);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> postScanQrCode(ScanQrPayload payload) async {
    try {
      final scanQr = await eventRemoteDataSource.postScanQrCode(payload);
      return right(scanQr);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TicketSpecialInfoEntity>> getTicketSpecialInfo(
      int payload) async {
    try {
      final ticketInfo =
          await eventRemoteDataSource.getTicketSpecialInfo(payload);
      return right(ticketInfo);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
