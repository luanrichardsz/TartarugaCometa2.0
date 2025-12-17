package model;

public class Cliente {
    private int idCliente;
    private String nome;
    private String cpfCnpj;
    private String razaoSocial;
    public Endereco enderecoCliente;
    private boolean isFisico;

    public Cliente(int idCliente ,String nome, String cpfCnpj, String razaoSocial, Endereco enderecoCliente) {
		this.idCliente = idCliente;
    	this.nome = nome;
		this.cpfCnpj = cpfCnpj;
		this.razaoSocial = razaoSocial;
		this.enderecoCliente = enderecoCliente;
	}

	public Cliente(){};

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCpfCnpj() {
        return cpfCnpj;
    }

    public void setCpfCnpj(String cpfCnpj) {
        this.cpfCnpj = cpfCnpj;
    }

    public String getRazaoSocial() {
        return razaoSocial;
    }

    public void setRazaoSocial(String razaoSocial) {
        this.razaoSocial = razaoSocial;
    }

    public Endereco getEnderecoCliente() {
        return enderecoCliente;
    }

    public void setEnderecoCliente(Endereco enderecoCliente) {
        this.enderecoCliente = enderecoCliente;
    }

    public boolean isFisico() {
        return isFisico;
    }

    public void setFisico(boolean fisico) {
        isFisico = fisico;
    }

    //Validação de CPF e CNPJ
    public void tipoCliente(){
        if (getCpfCnpj().length() == 11) {
            isFisico = true;
        } else if (getCpfCnpj().length() == 14) {
            isFisico = false;
        }
    }

    @Override
    public String toString() {
        return  "\nCliente{" +
                " Nome='" + nome + '\'' +
                ", cpf/Cnpj='" + cpfCnpj + '\'' +
                ", razaoSocial='" + razaoSocial + '\'' + "}";
    }
}

