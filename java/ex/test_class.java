package ex;

class TestClass {
  public static void main(String [] args) {
    Class c1 = new Class();
    c1.period = "afternoon";
    c1.initials = "XPTO";
    c1.degree = 1;
    c1.type = "Slaver";

    Class c2 = new Class();
    c2.period = "morning";
    c2.initials = "ABC";
    c2.degree = 2;
    c2.type = "Master";

    System.out.println(c1.period);
    System.out.println(c1.initials);
    System.out.println(c1.degree);
    System.out.println(c1.type);

    System.out.println(c2.period);
    System.out.println(c2.initials);
    System.out.println(c2.degree);
    System.out.println(c2.type);
  }
}
