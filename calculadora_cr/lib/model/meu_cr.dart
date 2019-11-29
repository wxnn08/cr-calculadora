class MeuCR {
  int credAprovados, credReprovadosFreq, credReprovados, credTotal;
  double crAtual;

  MeuCR(this.crAtual, this.credAprovados, this.credReprovadosFreq,
      this.credReprovados) {
    this.credTotal = credAprovados + credReprovados + credReprovadosFreq;
  }
}
