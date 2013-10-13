/**
* This class shows the length of a String.
* @authors Eduardo Schneiders, José Schmidt
* @version 1.0
*/

import java.util.Scanner;

public class ClassApp3 {
	public static void main(String[] args) {
		
		Scanner palavra = new Scanner( System.in );
		System.out.print("Entre com a primeira palavra: ");
	    String a = palavra.nextLine();

	    System.out.print("Entre com a segunda palavra: ");
	    String b = palavra.nextLine();
		
	    System.out.println("O tamanho da primeira palavra é:" + a.length());
	    System.out.println("O tamanho da segunda palavra é:" + b.length());

	    if(a.length() > b.length())
	    	System.out.println("A maior palavra é a primeira");
	    else
	    	System.out.println("A maior palavra é a segunda");
		
		

	}

}
