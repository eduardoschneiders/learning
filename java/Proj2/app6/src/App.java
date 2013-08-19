/**
* This class compares some properties of an Person object.
* @authors Eduardo Schneiders, José Schmidt
* @version 1.0
*/

public class App {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Person eduardo = new Person("Eduardo", 10.00, 51.00);
		Person jose = new Person("José", 11.00, 50.00);
		
		System.out.println(jose.whoIsWeighter(eduardo));
	}

}
