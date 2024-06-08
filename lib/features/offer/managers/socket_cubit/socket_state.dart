part of 'socket_cubit.dart';

@immutable
abstract class SocketState {}

class SocketInitialState extends SocketState {}

/// Inbox States
class SocketInboxConnectedState extends SocketState {}

class SocketInboxDisConnectedState extends SocketState {}

class SocketInboxListenState extends SocketState {}
