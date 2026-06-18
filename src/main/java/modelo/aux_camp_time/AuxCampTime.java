package modelo.aux_camp_time;

/**
 *
 * @author joao-gabriel
 */
public class AuxCampTime {
    private int id_campeonato;
    private int id_time;
    private int ano;
    
    public int getIdCampeonato(){
        return id_campeonato;
    }
    
    public void setIdCampeonato(int id_campeonato){
        this.id_campeonato = id_campeonato;
    }
    
    public int getIdTime(){
        return id_time;
    }
    
    public void setIdTime(int id_time){
        this.id_time = id_time;
    }
    
    public int getAno(){
        return ano;
    }
    
    public void setAno(int ano){
        this.ano = ano;
    }
}
