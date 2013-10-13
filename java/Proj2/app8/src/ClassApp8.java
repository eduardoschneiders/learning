/**
* This class calculates the divisors of a number.
* @authors Eduardo Schneiders, José Schmidt
* @version 1.0
*/

import java.util.Scanner;


public class ClassApp8 {


	public static void main(String[] args) {

	        Scanner sc = new Scanner(System.in);
		System.out.print("Digite um valor para achar seus divisors: ");
		int num = sc.nextInt();

        	for (int i = 1; i < num; i++) {
				if(num % i == 0)
   	    			System.out.println(i + " é um divisor por " + num);
        	}
    
	}

}
