
public class ProjetoSemEncapsulamento {
	public int codigo;
	public String nome;
	public double preco;
	public double desconto_a_vista;
	public int getCodigo() {
		return codigo;
	}
	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public double getPreco() {
//		double desconto = this.getDesconto_a_vista();
//		if(desconto < 0 || desconto > 100 )
			return preco;
	}
	public void setPreco(double preco) {
		this.preco = preco;
	}
	public ProjetoSemEncapsulamento(int codigo, String nome, double preco, double desconto_a_vista) {
		super();
		this.codigo = codigo;
		this.nome = nome;
		this.preco = preco;
		this.desconto_a_vista = desconto_a_vista;
	}
	public double getDesconto_a_vista() {
		return desconto_a_vista;
	}
	public void setDesconto_a_vista(double desconto_a_vista) {
		this.desconto_a_vista = desconto_a_vista;
	}
	
	
	

}
