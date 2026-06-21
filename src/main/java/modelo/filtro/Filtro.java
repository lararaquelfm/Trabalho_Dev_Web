/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.filtro;

/**
 *
 * @author tktgu
 */
public class Filtro {
    private int id;
    private String nome;
    private boolean checked;
    
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

    public boolean getChecked(){
        return checked;
    }
    
    public void setChecked(boolean checked){
        this.checked = checked;
    }
    
        
}
