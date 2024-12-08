class UniqueException implements Exception{
final String message;

UniqueException(this.message);

@override
String toString() => message;
}