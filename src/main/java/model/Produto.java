package model;

public class Produto {

    private int idProduto;
    private String nome;
    private double peso;
    private int volume;
    private double valor;
    private String descricao;

    public Produto() {};

    public Produto(int idProduto, String nome, double peso, int volume, double valor, String descricao) {
		this.idProduto = idProduto;
		this.nome = nome;
		this.peso = peso;
		this.volume = volume;
		this.valor = valor;
		this.descricao = descricao;
	}
    
	public int getIdProduto() {
		return idProduto;
	}

	public void setIdProduto(int idProduto) {
		this.idProduto = idProduto;
	}



	public String getNome() {
		return nome;
	}



	public void setNome(String nome) {
		this.nome = nome;
	}



	public double getPeso() {
		return peso;
	}



	public void setPeso(double peso) {
		this.peso = peso;
	}



	public int getVolume() {
		return volume;
	}



	public void setVolume(int volume) {
		this.volume = volume;
	}



	public double getValor() {
		return valor;
	}



	public void setValor(double valor) {
		this.valor = valor;
	}



	public String getDescricao() {
		return descricao;
	}



	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String toString(){
        return "\nProdutos{" +
                " Nome: " + nome + '\'' +
                ", Peso: " + peso + '\'' +
                ", Volume: " + volume + '\'' +
                ", Valor: " + valor + '\'' + "}" ;
    }
}