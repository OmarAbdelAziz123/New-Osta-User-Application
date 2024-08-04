part of 'wallet_cubit.dart';

@immutable
sealed class WalletState {}

final class WalletInitial extends WalletState {}

/// Wallet States
class WalletLoadingState extends WalletState {}

class WalletSuccessState extends WalletState {}

class WalletErrorState extends WalletState {}

/// Transactions States
class TransactionsLoadingState extends WalletState {}

class TransactionsSuccessState extends WalletState {}

class TransactionsErrorState extends WalletState {}
