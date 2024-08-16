import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osta_user_app/features/inbox/inbox_for_delivery/models/get_all_conversations_model.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';
import 'package:osta_user_app/utils/dio/dio_helper.dart';
part 'inbox_state.dart';

class InboxCubit extends Cubit<InboxState> {
  InboxCubit() : super(InboxInitial());

  static InboxCubit get(context) => BlocProvider.of(context);

  DioHelper dioHelper = DioHelper();

  GetAllConversationsModel getAllConversationsModel = GetAllConversationsModel();
  List<ConversationsData> conversationsList = [];

  Future<void> getAllConversationsFunction() async {
    conversationsList.clear();
    emit(GetAllConversationsLoadingState());
    await dioHelper.getData(endPoint: 'api/inbox').then((response) {
      getAllConversationsModel = GetAllConversationsModel.fromJson(response.data);
      conversationsList.addAll((response.data['data'] as List)
          .map((favCom) => ConversationsData.fromJson(favCom))
          .toList());

      emit(GetAllConversationsSuccessState());
    }).catchError((err) {
      logError(err.toString());
      emit(GetAllConversationsErrorState());
    });
  }
  // Future<void> getAllConversationsFunction() async {
  //   conversationsList.clear();
  //   emit(GetAllConversationsLoadingState());
  //   try {
  //     final response = await dioHelper.getData(endPoint: 'api/inbox');
  //
  //     // Ensure response.data is a Map, not a List
  //     if (response.data is Map<String, dynamic>) {
  //       // Parse as Map
  //       getAllConversationsModel = GetAllConversationsModel.fromJson(response.data);
  //       // Assuming response.data['data'] is a List
  //       final List<dynamic> data = response.data['data'];
  //       conversationsList.addAll(
  //         data.map((item) => ConversationsData.fromJson(item)).toList(),
  //       );
  //     } else if (response.data is List<dynamic>) {
  //       // Handle case where response.data is a List directly
  //       conversationsList.addAll(
  //         (response.data as List<dynamic>).map((item) => ConversationsData.fromJson(item)).toList(),
  //       );
  //     } else {
  //       // Handle unexpected response formats
  //       throw Exception('Unexpected response format');
  //     }
  //
  //     emit(GetAllConversationsSuccessState());
  //   } catch (err) {
  //     logError(err.toString());
  //     emit(GetAllConversationsErrorState());
  //   }
  // }

}
