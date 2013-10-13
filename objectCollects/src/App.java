import java.awt.List;
import java.util.ArrayList;
import java.util.Iterator;


public class App {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Pessoa p1 = new Pessoa("eduardo", 10);
		Pessoa p2 = new Pessoa("teste", 20);

		
		ArrayList<Pessoa> listPeople = new ArrayList<Pessoa>();
		
		listPeople.add(p1);
		listPeople.add(p2);
		
		Iterator<Pessoa> it = listPeople.iterator();
		
		while(it.hasNext()){
			System.out.println(it.next().getNome());
		}
	}

}
