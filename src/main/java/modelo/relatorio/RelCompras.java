package modelo.relatorio;

public class RelCompras {
    private int id_usuario;
    private String nome_usuario;
    private int qnt_compras;
    
    public int getId(){
        return id_usuario;
    }
    
    public void setId(int id_usuario){
        this.id_usuario = id_usuario;
    }
    
    public String getNome(){
        return nome_usuario;
    }
    
    public void setNome(String nome){
        nome_usuario = nome;
    }
    
    public int getQntCompras(){
        return qnt_compras;
    }
    
    public void setQntCompras(int qnt_compras){
        this.qnt_compras = qnt_compras;
    }
    
}
