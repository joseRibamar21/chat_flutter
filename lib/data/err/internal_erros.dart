enum InternalErros {
  invalidadeData,
}

String intenalErrorMenssage(InternalErros error) {
  switch (error) {
    case InternalErros.invalidadeData:
      return "Dados Invalidos";
    default:
      return "Error";
  }
}
