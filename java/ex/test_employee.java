package ex;

class TestEmployee {
  public static void main(String [] args){
    Employee e1 = new Employee();
    e1.name = "Employee 1";
    e1.salary = 2500.00;

    Employee e2 = new Employee();
    e2.name = "Employee 2";
    e2.salary = 1500.00;

    System.out.println(e1.name);
    System.out.println(e1.salary);

    System.out.println(e2.name);
    System.out.println(e2.salary);
  }
}
