/**
 * 
 * @author José Schmidt, Gabriel Tondin, Eduardo Schneiders
 *
 */

public class MeuProgramaOO {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		ContaPessoaFisica pf1 = new ContaPessoaFisica();
		ContaPessoaJuridica pj1 = new ContaPessoaJuridica();
		
		pf1.setNome("José Luiz da Silva");
		pf1.setNumeroConta("abc123");
		pf1.setSenha("senha");
		pf1.setClienteDesde("01/01/2000");
		pf1.setTelefoneContato("3565.5787");
		pf1.setEndereco("Rua Londres 45");
		pf1.setSalario("900,00");
		pf1.setCpf("021.250.300-81");
		
		
		pj1.setNome("Eduardo Schneiders");
		pj1.setNumeroConta("conta123");
		pj1.setSenha("senhasecreta");
		pj1.setClienteDesde("17/09/1990");
		pj1.setTelefoneContato("3543.8765");
		pj1.setEndereco("Rua Rio Pardo");
		pj1.setFaturamentoMensal("2.000.000,00");
		pj1.setCnpj("022.250.300-81");
		
		pf1.imprimeValor();
		pj1.imprimeValor();

	}

}
