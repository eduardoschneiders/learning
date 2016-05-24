package ex;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

// javac -d . *.java
// java ex.Principal

public class Principal {
  public static void main (String[] args) {
    Conta c1 = new Conta();
    c1.creditar(10.0);
    System.out.println(c1.obterSaldo());
    Conta c2 = new Conta(50.0);
    c2.creditar(10.0);
    System.out.println(c2.obterSaldo());

    Imprime.teste();
    Imprime.testeII();
    Imprime.testepi();
    Imprime.fibonacci(13);
  }
}