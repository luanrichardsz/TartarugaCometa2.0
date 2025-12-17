package model;

public class Produto {

    private int idProduto;
    private String nome;
    private double peso;
    private double volume;
    private double valor;

    public Produto(int idProduto, String nome, double peso, double volume, double valor) {
		super();
		this.idProduto = idProduto;
		this.nome = nome;
		this.peso = peso;
		this.volume = volume;
		this.valor = valor;
	}

	public Produto() {};

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

    public double getVolume() {
        return volume;
    }

    public void setVolume(double volume) {
        this.volume = volume;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public String toString(){
        return "\nProdutos{" +
                " Nome: " + nome + '\'' +
                ", Peso: " + peso + '\'' +
                ", Volume: " + volume + '\'' +
                ", Valor: " + valor + '\'' + "}" ;
    }
}