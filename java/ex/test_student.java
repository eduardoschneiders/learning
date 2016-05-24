package ex;

class TestStudent {
  public static void main(String [] args){
    Student s1 = new Student();
    s1.name = "Eduardo";
    s1.rg = 123456789;

    Student s2 = new Student();
    s2.name = "matheus";
    s2.rg = 987654321;

    System.out.println(s1.name);
    System.out.println(s1.rg);

    System.out.println(s2.name);
    System.out.println(s2.rg);
  }
}
