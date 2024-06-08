import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:osta_user_app/utils/constants/api_constants.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

part 'socket_state.dart';

class SocketCubit extends Cubit<SocketState> {
  SocketCubit() : super(SocketInitialState());

  static SocketCubit get(context) => BlocProvider.of(context);

  late IO.Socket socket;


  /// Socket Function
  socketFunc({required int userId}) {
    socket = IO.io(ApiConstants.socketUrl, <String, dynamic>{
      "transports": ["websocket"],
    });

    socket.onConnect((_) {
      logSuccess('Connect');
      emit(SocketInboxConnectedState());
    });

    socket.on('Osta.user$userId', (data) {
      logSuccess('----------------$data----------------------');
      emit(SocketInboxListenState());
    });

    socket.onError((data) {
      logError('Error in Socket Error: $data');
    });

    socket.onConnectError((data) {
      logError('Error in Socket Connect Error: $data');
    });

    socket.onDisconnect((_) {
      logSuccess('DisConnect');
      emit(SocketInboxDisConnectedState());
    });

    socket.on('Osta.user$userId', (_) => print('T3abnaaaaaaaaaaaa'));

  }

  // void connectAndListen({required int userId}){
  //   IO.Socket socket = IO.io(ApiConstants.socketUrl,
  //       OptionBuilder()
  //           .setTransports(['websocket']).build());
  //
  //   socket.onConnect((_) {
  //     print('connect');
  //     socket.emit('msg', 'test');
  //   });
  //
  //   /// When an event recieved from server, data is added to the stream
  //   socket.on('Osta.user$userId', (data) {
  //     logSuccess('----------------$data----------------------');
  //     emit(SocketInboxListenState());
  //   });
  //
  //   socket.onDisconnect((_) => print('disconnect'));
  //
  // }

  // onListenSocketFunc({required int userId}) {
  //   socket.on('Osta.user$userId', (data) {
  //     logSuccess(data);
  //     emit(SocketInboxListenState());
  //   });
  // }
  //
  // onDisConnectSocketFunc() {
  //   socket.onDisconnect((_) {
  //     logSuccess('DisConnect');
  //     emit(SocketInboxDisConnectedState());
  //   });
  // }

}