/**
 * 
 * @author José Schmidt, Gabriel Tondin, Eduardo Schneiders
 *
 */

public class ContaPessoaJuridica extends Conta {
	
	private String faturamentoMensal;
	private String cnpj;
	
	
	public String getFaturamentoMensal() {
		return faturamentoMensal;
	}
	public void setFaturamentoMensal(String faturamentoMensal) {
		this.faturamentoMensal = faturamentoMensal;
	}
	public String getCnpj() {
		return cnpj;
	}
	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}
	
	
	public void imprimeValor(){
		super.imprimeValor();
		System.out.println("Faturamento Mensal: " + this.getFaturamentoMensal());
		System.out.println("CNPJ: " + this.getCnpj());
	}
}
