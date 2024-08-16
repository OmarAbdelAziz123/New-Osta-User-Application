part of 'inbox_cubit.dart';

@immutable
sealed class InboxState {}

final class InboxInitial extends InboxState {}

/// Get All Conversations States
class GetAllConversationsLoadingState extends InboxState {}

class GetAllConversationsSuccessState extends InboxState {}

class GetAllConversationsErrorState extends InboxState {}
