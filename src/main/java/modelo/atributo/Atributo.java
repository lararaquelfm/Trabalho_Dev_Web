package modelo.atributo;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author tktgu
 */
public class Atributo {
    private int id;
    private String atributo;
    private String tabela;
    
    public int getId(){
        return id;
    }
    
    public void setId(int id){
        this.id = id;
    }
    
    public String getAtributo(){
        return atributo;
    }
    
    public void setAtributo(String atributo){
        this.atributo = atributo;
    }
    
    public String getTabela(){
        return tabela;
    }
    
    public void setTabela(String tabela){
        this.tabela = tabela;
    }
}
