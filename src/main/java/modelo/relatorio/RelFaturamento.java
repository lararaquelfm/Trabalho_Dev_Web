package modelo.relatorio;

import java.time.LocalDate;


public class RelFaturamento {
    private LocalDate data;
    private Double valor_total;
    
    public LocalDate getData(){
        return data;
    }
    
    public void setData(LocalDate data){
        this.data = data;
    }
    
    public Double getValorTotal(){
        return valor_total;
    }
    
    public void setValorTotal(Double valor_total){
        this.valor_total = valor_total;
    }
    
}
