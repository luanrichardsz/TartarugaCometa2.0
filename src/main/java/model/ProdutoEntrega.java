package model;

public class ProdutoEntrega {
    public Produto produto;
    private int quantidade;
    private double frete;
    
	public ProdutoEntrega(Produto produto, int quantidade, double frete) {
		super();
		this.produto = produto;
		this.quantidade = quantidade;
		this.frete = frete;
	}
	
	public ProdutoEntrega() {}

	public Produto getProduto() {
		return produto;
	}

	public void setProduto(Produto produto) {
		this.produto = produto;
	}

	public int getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}

	public double getFrete() {
		return frete;
	}

	public void setFrete(double frete) {
		this.frete = frete;
	}    
}
