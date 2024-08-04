import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osta_user_app/features/wallet/models/transactions_model.dart';
import 'package:osta_user_app/features/wallet/models/wallet_model.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';
import 'package:osta_user_app/utils/dio/dio_helper.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  static WalletCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  WalletModel walletModel = WalletModel();
  GetAllTransactionsModel getAllTransactionsModel = GetAllTransactionsModel();

  Future<void> walletFunction() async {
    emit(WalletLoadingState());
    await dioHelper.getData(endPoint: 'api/wallet').then((response) {
      walletModel = WalletModel.fromJson(response.data);
      emit(WalletSuccessState());
    }).catchError((error) {
      logError(error.toString());
      emit(WalletErrorState());
    });
  }

  Future<void> getAllTransactionsFunction() async {
    emit(TransactionsLoadingState());
    await dioHelper.getData(endPoint: 'api/wallet/transactions').then((response) {
      getAllTransactionsModel = GetAllTransactionsModel.fromJson(response.data);
      emit(TransactionsSuccessState());
    }).catchError((error) {
      logError(error.toString());
      emit(TransactionsErrorState());
    });
  }
}
