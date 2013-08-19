/**
* This class compares Numbers, and calculate the average.
* @authors Eduardo Schneiders, José Schmidt
* @version 1.0
*/

import java.util.Scanner;


public class ClassApp6 {


	public static void main(String[] args) {
		final int NUMEROS_A_LER = 3;
        Scanner sc = new Scanner(System.in);
        int mínimo = Integer.MAX_VALUE;
        int máximo = Integer.MIN_VALUE;
        int acumulador = 0;

        for (int i = 0; i < NUMEROS_A_LER; i++) {
            System.out.print("Entre com o proximo inteiro: ");
            int num = sc.nextInt();
            acumulador += num;
            
            if (num < mínimo) {
                mínimo = num;
            }
            if (num > máximo) {
                máximo = num;
            }
        }

        System.out.println("O menor numero eh: " + mínimo);
        System.out.println("O maior numero eh: " + máximo);
        System.out.println("Média: " + acumulador / NUMEROS_A_LER);
    
	}

}
