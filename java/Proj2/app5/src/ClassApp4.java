/**
* This class writes if a String is a palindrome.
* @authors Eduardo Schneiders, José Schmidt
* @version 1.0
*/

import java.util.Scanner;
public class ClassApp4 {

	public static void main(String[] args) {
		
		Scanner palavra = new Scanner(System.in);

		StringBuffer texto;

		System.out.println("Digite uma palavra ");
		texto = new StringBuffer(palavra.nextLine());

		String original = texto.toString();
		String inverso = texto.reverse().toString();
		
		if(inverso.equals(original))
			System.out.println("É um palindromo ");
		else
			System.out.println("Não é um palindromo ");
		
		
		System.out.println("Texto Invertido: "+inverso);
		System.out.println("Texto Original: "+original);
		

	}

}
