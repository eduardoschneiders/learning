package ex;

class TestaCliente {
  public static void main ( String [] args ) {
    Client c1 = new Client() ;
    c1.nome = " Rafael Cosentino";
    c1.code = 1;

    Client c2 = new Client() ;
    c2.nome = " Jonas Hirata";
    c2.code = 2;

    System.out.println(c1.nome) ;
    System.out.println(c1.code) ;

    System.out.println(c2.nome) ;
    System.out.println(c2.code) ;
  }
}
