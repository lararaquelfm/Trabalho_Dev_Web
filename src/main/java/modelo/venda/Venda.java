package modelo.venda;

import java.time.LocalDateTime;

public class Venda {
    private int id;
    private LocalDateTime data_hora;
    private int id_usuario;
    
    public int getId(){
        return id;
    }
    
    public void setId(int id){
        this.id = id;
    }
    
    public LocalDateTime getDataHora(){
        return data_hora;
    }
    
    public void setDataHora(LocalDateTime data_hora){
        this.data_hora = data_hora;
    }
    
    public int getIdUsuario(){
        return id_usuario;
    }
    
    public void setIdUsuario(int id_usuario){
        this.id_usuario = id_usuario;
    }
}
