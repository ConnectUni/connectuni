import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/chat_list.dart';

//Provider that allows access to the chats database.
final chatDBProvider = Provider<ChatList>((ref) { return ChatList(mockChats); });