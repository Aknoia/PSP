///Controlla se il valore è null
bool checkValoreNull(var valore) {
  if (valore == null || valore == 'null' || valore == '') {
    return true;
  }
  return false;
}