import java.util.List;

public class CalculadoraSimples extends Calculadora {

	public CalculadoraSimples() {
		// TODO Auto-generated constructor stub
	}
	
	public Calculadora soma(List<Integer> listaValores){
		Calculadora calc = new Calculadora();
		int result = 0;
		
		for(int i = 0; i < listaValores.size(); i++){
			result = result + listaValores.get(i);
		}
		
		calc.operandos = listaValores;
		calc.resultado = result;
		
		return calc;
	}
	
	public Calculadora subtracao(List<Integer> listaValores){
		Calculadora calc = new Calculadora();
		int result = 0;
		
		for(int i = 0; i < listaValores.size(); i++){
			result = result - listaValores.get(i);
		}
		
		calc.operandos = listaValores;
		calc.resultado = result;
		
		return calc;
	}
	
	public Calculadora multiplicacao(List<Integer> listaValores){
		Calculadora calc = new Calculadora();
		int result = 0;
		
		for(int i = 0; i < listaValores.size(); i++){
			result = result * listaValores.get(i);
		}
		
		calc.operandos = listaValores;
		calc.resultado = result;
		
		return calc;
	}
	
	public Calculadora divisao(List<Integer> listaValores){
		Calculadora calc = new Calculadora();
		int result = 0;
		
		
			result = listaValores.get(0) / listaValores.get(1);
		
		
		calc.operandos = listaValores;
		calc.resultado = result;
		
		return calc;
	}

}
