class VariablesGlobals {
  VariablesGlobals(this.valueStateLedNotificationValues);
  bool valueStateLedNotificationValues;

  setVar(valor) {
    valueStateLedNotificationValues = valor;
  }

  getVar() {
    return valueStateLedNotificationValues;
  }
}
