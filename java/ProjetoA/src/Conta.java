/**
 * 
 * @author José Schmidt, Gabriel Tondin, Eduardo Schneiders
 *
 */

public class Conta {
	private String nome;
	private String numeroConta;
	private String senha;
	private String clienteDesde;
	private String telefoneContato;
	private String endereco;


	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getNumeroConta() {
		return numeroConta;
	}
	public void setNumeroConta(String numeroConta) {
		this.numeroConta = numeroConta;
	}
	public String getSenha() {
		return senha;
	}
	public void setSenha(String senha) {
		this.senha = senha;
	}
	public String getClienteDesde() {
		return clienteDesde;
	}
	public void setClienteDesde(String clienteDesde) {
		this.clienteDesde = clienteDesde;
	}
	public String getTelefoneContato() {
		return telefoneContato;
	}
	public void setTelefoneContato(String telefoneContato) {
		this.telefoneContato = telefoneContato;
	}
	public String getEndereco() {
		return endereco;
	}
	public void setEndereco(String endereco) {
		this.endereco = endereco;
	}
	
	public void imprimeValor(){
		System.out.println("Nome: " + this.getNome());
		System.out.println("Numero Conta: " + this.getNumeroConta());
		System.out.println("Senha: " + this.getSenha());
		System.out.println("Cliente Desde: " + this.getClienteDesde());
		System.out.println("Telefone: " + this.getTelefoneContato());
		System.out.println("Endereço: " + this.getEndereco());
	}
}
