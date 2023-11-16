import 'package:flutter_riverpod/flutter_riverpod.dart';

List<String> interests = [
  'Computer Science',
  'Mathematics',
  'Business',
  'Art',
  'Music',
  'Graphic Design',
  'Finance',
];

final interestsProvider = StateProvider<List<String>>((ref) { return interests; });