
public class Bicicleta {
	int velocidade = 0;
	int marcha = 1;
	
	void MudarMarcha(int novoValor){
		marcha = novoValor;
	}
	
	void aumentarVelocidade(int incremento){
		velocidade += incremento;
	}
	
	void aplicarFreios(int decremento){
		velocidade -= decremento;
	}
}
