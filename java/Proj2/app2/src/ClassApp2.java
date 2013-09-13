/**
* This class  reads 5 numbers and shows the bigger
* @authors Eduardo Schneiders, José Schmidt
* @version 1.0
*/
// Programa que lê 5 numeros e exibe o maior

	import java.util.Scanner;
	
	public class ClassApp2 {
	public static void main(String[] args) {
		final int NÚMEROS_A_LER = 5;
        Scanner sc = new Scanner(System.in);
        
        int máximo = Integer.MIN_VALUE;

        for (int i = 0; i < NÚMEROS_A_LER; i++) {
            System.out.print("Entre com o proximo inteiro: ");
            int num = sc.nextInt();
            if (num > máximo) {
                máximo = num;
            }
        }

        
        System.out.println("O maior numero eh: " + máximo);	
        
	}
}
