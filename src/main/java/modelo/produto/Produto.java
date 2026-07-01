/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.produto;

/**
 *
 * @author joao-gabriel
 */
public class Produto {
    private int id;
    private String descricao;
    private double preco;
    private String tamanho;
    private int quantidade;
    private int id_time;
    private int id_categoria;
    private int totalVendido;
    
    public int getId(){
        return id;
    }
    
    public void setId(int id){
        this.id = id;
    }
    
    public String getDescricao(){
        return descricao;
    }
    
    public void setDescricao(String descricao){
        this.descricao = descricao;
    }
    
    public double getPreco(){
        return preco;
    }
    
    public void setPreco(double preco){
        this.preco = preco;
    }
    
    public String getTamanho(){
        return tamanho;
    }
    
    public void setTamanho(String tamanho){
        this.tamanho = tamanho;
    }
    
    public int getQuantidade(){
        return quantidade;
    }
    
    public void setQuantidade(int quantidade){
        this.quantidade = quantidade;
    }
    
    public int getIdTime(){
        return id_time;
    }
    
    public void setIdTime(int id_time){
        this.id_time = id_time;
    }
    
    public int getIdCategoria(){
        return id_categoria;
    }
    
    public void setIdCategoria(int id_categoria){
        this.id_categoria = id_categoria;
    }

    public int getTotalVendido(){
        return totalVendido;
    }

    public void setTotalVendido(int totalVendido){
        this.totalVendido = totalVendido;
    }
}
