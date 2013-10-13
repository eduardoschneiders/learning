import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Iterator;


public class CalculadoraComplexa extends Calculadora {

	public CalculadoraComplexa() {
		// TODO Auto-generated constructor stub
	}
	
	public Calculadora restoDivisao(List<Integer> listaValores){
		
		int result = listaValores.get(0) % listaValores.get(1);
	
		Calculadora calc = new Calculadora();
		calc.operandos = listaValores;
		calc.resultado = result;
		
		return calc;
		
	}
	
	public Calculadora potencia(List<Integer> listaValores){
		
		int result = (int) Math.pow(listaValores.get(0), listaValores.get(1));
	
		Calculadora calc = new Calculadora();
		calc.operandos = listaValores;
		calc.resultado = result;
		
		return calc;
		
	}
	
public Calculadora valorMaximo(List<Integer> listaValores){
		
		int valorMaior = 0;
		for(int i = 0; i < listaValores.size(); i++){
			
			if(listaValores.get(i) > valorMaior)
				valorMaior = listaValores.get(i);
			
			
		}
	
		Calculadora calc = new Calculadora();
		calc.operandos = listaValores;
		calc.resultado = valorMaior;
		
		return calc;
		
	}

	public Calculadora valorMinimo(List<Integer> listaValores){
		
		int valorMenor = listaValores.get(0);
		for(int i = 0; i < listaValores.size(); i++){
	
			if(listaValores.get(i) < valorMenor)
				valorMenor = listaValores.get(i);
		}
	
		Calculadora calc = new Calculadora();
		calc.operandos = listaValores;
		calc.resultado = valorMenor;
		
		return calc;		
	}

	public Calculadora valorMedio(List<Integer> listaValores){

		int total = 0;
		for(int i = 0; i < listaValores.size(); i++){
			total += listaValores.get(i);
		}

		double media = total / listaValores.size();

		Calculadora calc = new Calculadora();
		calc.operandos = listaValores;
		calc.resultado = media;

		return calc;		
	}
	
	public Calculadora moda(List<Integer> listaValores){

		HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();		

		int value = 0;

		for(int i = 0; i < listaValores.size(); i++){
			if(map.containsKey(listaValores.get(i)))
				value = map.get(listaValores.get(i)) + 1;	
			else 
				value = 1;
			
			map.put(listaValores.get(i),  value);
		}
		
		Iterator iterator = map.entrySet().iterator();
		int maior = 0;
		int numeroMaior = 0;
		while (iterator.hasNext()){
			Map.Entry mapEntry = (Map.Entry) iterator.next();
			
			if((int) mapEntry.getValue() > maior){
				maior = (int) mapEntry.getValue();
				numeroMaior = (int) mapEntry.getKey();
			}
				
		}

		Calculadora calc = new Calculadora();
		calc.operandos = listaValores;
		calc.resultado = numeroMaior;

		return calc;		
	}
	
	public Calculadora fatorial(List<Integer> listaValores) {

		int result = 0;
		for(int i = listaValores.get(0); i >= 1; i--){
			if(result == 0)
				result = i;
			else
				result = i * result;
		}
		
		Calculadora calc = new Calculadora();
		calc.operandos = listaValores;
		calc.resultado = result;

		return calc;		
	}

}
