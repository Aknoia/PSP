///True: "s" è un numero
///False: "s" non è un numero
bool controllaNumero(var variabile) {
  if (variabile == null) {
    return false;
  }
  return double.tryParse(variabile) != null;
}