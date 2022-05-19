///iniziali per AVATAR
String prendiIniziali(String nome) {

  if (nome.isEmpty) {
    return ' ';
  }

  List<String> arrayNomi = nome.replaceAll(RegExp(r'\s+\b|\b\s'), ' ').split(' ');

  String iniziali = ((arrayNomi[0])[0]) + (arrayNomi.length == 1 ? ' ' : (arrayNomi[arrayNomi.length - 1])[0]);

  return iniziali;
}