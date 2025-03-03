import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'all_chats_view_state.dart';

class AllChatsViewCubit extends Cubit<AllChatsViewState> {
  AllChatsViewCubit() : super(AllChatsViewInitial());
}
