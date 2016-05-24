package ex;

class TestaCartaoDeCredito {
  public static void main (String [] args) {
    CreditCard cdc1 = new CreditCard();
    cdc1.numero = 111111;
    cdc1.dataDeValidade = "01/01/2013";

    CreditCard cdc2 = new CreditCard();
    cdc2.numero = 222222;
    cdc2.dataDeValidade = "01/01/2014";

    System.out.println (cdc1.numero) ;
    System.out.println (cdc1.dataDeValidade) ;

    System.out.println (cdc2.numero) ;
    System.out.println (cdc2.dataDeValidade) ;
  }
}
