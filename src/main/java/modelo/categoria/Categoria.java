package modelo.categoria;

public class Categoria {
    private int id;
    private String nome;
    private String temporada;
    private String estilo;
    
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

    public String getTemporada() {
        return temporada;
    }
    public void setTemporada(String temporada) {
        this.temporada = temporada;
    }

    public String getEstilo() {
        return estilo;
    }
    public void setEstilo(String estilo) {
        this.estilo = estilo;
    }
}
