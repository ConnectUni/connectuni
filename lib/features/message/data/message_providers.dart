import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/message_list.dart';

final messagesDBProvider = Provider<MessageList>((ref) { return MessageList(allMessages: allMessages); });
