/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ex;

/**
 *
 * @author aluno
 */
class Imprime {
  public static void teste ( ) {
    for(int contador = 1; contador <= 100; contador ++) {
      System . out . println ( contador );
    }
  }

  public static void testeII(){
    for(int contador = 1; contador <= 100; contador ++) {
      int resto = contador % 2;
      if( resto == 1) {
        System . out . println ("*");
      } else {
        System . out . println ("**");
      }
    }
  }

  public static void testepi () {
    for(int contador = 1; contador <= 100; contador ++) {

      if( contador % 4 == 0) {
        System.out.println("PI");
      } else {
        System.out.println( contador );
      }
    }
  }

  public static void fibonacci(int cont) {
    int pi;
    int ant;
    int antII;

    ant = 0;
    antII = 0;


    for(int contador = 1; contador <= cont; contador ++) {
      pi = ant + antII;
      antII = ant;

      if (pi > 0){
        ant = pi;
      }else{
        ant = 1;
      }

      System.out.println(pi);
    }
  }
}
