import 'package:meta/meta.dart';

class IOException implements Exception
{
  final String message;
  IOException({@required this.message});
}