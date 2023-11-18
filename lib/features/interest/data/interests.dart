import 'package:flutter_riverpod/flutter_riverpod.dart';

List<String> interests = [
  'Computer Science',
  'Mathematics',
  'Business',
  'Art',
  'Music',
  'Graphic Design',
  'Finance',
  'Physics',
  'Engineering',
  'Psychology',
  'Political Science',
  'Literature and Writing',
  'History',
  'Film',
  'Photography',
  'Entrepreneurship',
  'Theater and Drama',
  'Dance',
  'Economics',
  'Anthropology',
  'Graphic Novels and Comics',
  'Astronomy',
  'Game Development',
  'Journalism',
  'Data Science',
  'Fashion Design',
  'Nutrition and Dietetics',
  'Public Relations',
];

final interestsProvider = StateProvider<List<String>>((ref) { return interests; });