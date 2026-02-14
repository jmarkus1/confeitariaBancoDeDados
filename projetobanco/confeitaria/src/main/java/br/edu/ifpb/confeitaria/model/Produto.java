package br.edu.ifpb.confeitaria.model;

public class Produto {
    // as colunas da tabela no banco
    private int id;
    private String nome;
    private String descricao;
    private double preco;

    //construtor vazio o Java usa ele para criar o objeto
    public Produto() {
    }

    //construtor completo pra criar o produto já com os dados
    public Produto(int id, String nome, String descricao, double preco) {
        this.id = id;
        this.nome = nome;
        this.descricao = descricao;
        this.preco = preco;
    }

    //Get e Set pegar get pega e o set salva
    //O jsp usa o Get para mostrar o nome e o preço
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public double getPreco() {
        return preco;
    }

    public void setPreco(double preco) {
        this.preco = preco;
    }
}

