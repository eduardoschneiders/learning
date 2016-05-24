package ex;



/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author aluno
 */
public class Conta {
  private double saldo;
  public Conta ( ) {
  }
  public Conta (double saldo) {
    this.saldo = saldo;
  }
  public void creditar (double valor) {
    saldo = saldo + valor;
  }
  public void debitar (double valor) {
    saldo = saldo - valor;
  }
  public double obterSaldo ( ) {
    return saldo;
  }
}
