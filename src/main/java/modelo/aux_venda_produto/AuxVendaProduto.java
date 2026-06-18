package modelo.aux_venda_produto;

/**
 *
 * @author petcomp
 */
public class AuxVendaProduto {
    private int id_venda;
    private int id_produto;
    private int quantidade;
    private double preco;
    
    public int getIdVenda(){
        return id_venda;
    }
    
    public void setIdVenda(int id_venda){
        this.id_venda = id_venda;
    }
    
    public int getIdProduto(){
        return id_produto;
    }
    
    public void setIdProduto(int id_produto){
        this.id_produto = id_produto;
    }
    
    public int getQuantidade(){
        return quantidade;
    }
    
    public void setQuantidade(int quantidade){
        this.quantidade = quantidade;
    }
    
    public double getPreco(){
        return preco;
    }
    
    public void setPreco(double preco){
        this.preco = preco;
    }
}
