package ex;


class TestaAgencia {
  public static void main ( String [] args ) {
    Agency a1 = new Agency();
    a1.number = 1234;

    Agency a2 = new Agency();
    a2.number = 5678;

    System.out.println ( a1.number) ;

    System.out.println ( a2.number ) ;
  }
}
