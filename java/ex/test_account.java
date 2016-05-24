package ex;

class TestaConta {
  public static void main ( String [] args ) {
    Account c1 = new Account () ;
    c1.number = 1234;
    c1.balance = 1000;
    c1.limit = 500;

    Account c2 = new Account () ;
    c2.number = 5678;
    c2.balance = 2000;
    c2.limit = 250;

    System.out.println ( c1.number ) ;
    System.out.println ( c1.balance ) ;
    System.out.println ( c1.limit ) ;

    Account test = new Account () ;
    System.out.println(test.limit);
  }
}
