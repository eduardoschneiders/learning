/**
 * 
 * @author José Schmidt, Gabriel Tondin, Eduardo Schneiders
 *
 */

public class ContaPessoaFisica extends Conta {
	private String salario;
	private String cpf;
	
	public String getSalario() {
		return salario;
	}
	public void setSalario(String salario) {
		this.salario = salario;
	}
	public String getCpf() {
		return cpf;
	}
	public void setCpf(String cpf) {
		this.cpf = cpf;
	}
	
	public void imprimeValor(){
		super.imprimeValor();
		System.out.println("Salário: " + this.getSalario());
		System.out.println("CPF: " + this.getCpf());
	}

}
