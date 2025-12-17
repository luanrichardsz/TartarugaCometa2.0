package model;

import java.util.ArrayList;

public class Entrega {

    private int idEntrega;
    private boolean realizada;
    public Cliente clienteRemetente;
    public Cliente clienteDestinatario;

    // Declarando a lista de produtos para o Produto_Entrega
    private ArrayList<ProdutoEntrega> produtos;

    public Entrega(boolean realizada, Cliente clienteRemetente, Cliente clienteDestinatario) {
        this.realizada = realizada;
        this.clienteRemetente = clienteRemetente;
        this.clienteDestinatario = clienteDestinatario;

        // inicializar a lista de produtos
        this.produtos = new ArrayList<>();
    }

    public Entrega(){};

    public int getIdEntrega() {
        return idEntrega;
    }

    public void setIdEntrega(int idEntrega) {
        this.idEntrega = idEntrega;
    }

    public boolean isRealizada() {
        return realizada;
    }

    public void setRealizada(boolean realizada) {
        this.realizada = realizada;
    }

    public Cliente getClienteRemetente() {
        return clienteRemetente;
    }

    public void setClienteRemetente(Cliente clienteRemetente) {
        this.clienteRemetente = clienteRemetente;
    }

    public Cliente getClienteDestinatario() {
        return clienteDestinatario;
    }

    public void setClienteDestinatario(Cliente clienteDestinatario) {
        this.clienteDestinatario = clienteDestinatario;
    }

    public ArrayList<ProdutoEntrega> getProdutos() {
        return produtos;
    }

    public void setProdutos(ArrayList<ProdutoEntrega> produtos) {
        this.produtos = produtos;
    }

    public String toString(){
        String listaProdutos = "" ;

        for (ProdutoEntrega proEnt : produtos) {
             listaProdutos += "\n Produto ID: " + proEnt.getProduto().getIdProduto() +
                              "\n Nome do Produto: " + proEnt.getProduto().getNome() +
                              "\n Quantidade: " + proEnt.getQuantidade() + "\n";
        }

        return "\nEntrega {" +
               "ID Entrega: " + getIdEntrega() +
               ", Realizada: " + isRealizada() +
               ", ID do Cliente Remetente: " + clienteRemetente.getIdCliente() +
               ", ID do Cliente Destinatario: " + clienteDestinatario.getIdCliente() +
               "\nProdutos: " + listaProdutos + "}";
    }
}
