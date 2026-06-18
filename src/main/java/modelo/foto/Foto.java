package modelo.foto;

public class Foto {
    private int id;
    private String foto;
    private int idProduto;
    public Foto(){}

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getFoto() {
        return foto;
    }
    public void setFoto(String foto) {
        this.foto = foto;
    }

    public int getIdProduto(){
        return idProduto;
    }
    public void setIdProduto(int idProduto){
        this.idProduto = idProduto;
    }
}