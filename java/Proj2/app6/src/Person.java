/**
* This class compares some properties of an Person object.
* @authors Eduardo Schneiders, José Schmidt
* @version 1.0
*/

public class Person {
	
	String name;
	double height;
	double weight;
	
	
	
	public Person(String name, double height, double weight){
		this.name = name;
		this.height = height;
		this.weight = weight;
	}
	
	public String whoIsWeighter(Person usuario){
		String higherName = "";
		String heavierName = "";
		String returnText = "";
		
		
		if(usuario.height > this.height)
			higherName = usuario.name;
		else
			higherName = this.name;
		
		if(usuario.weight > this.weight)
			heavierName = usuario.name;
		else
			heavierName = this.name;
		
		
		
		
		returnText = higherName + " é o mais alto\n";
		returnText += heavierName + " é o mais pesado";
		
		
		return returnText;
	}

}
