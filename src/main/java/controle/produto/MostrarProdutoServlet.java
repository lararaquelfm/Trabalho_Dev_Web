package controle.produto;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Comparator;
import java.util.List;
import modelo.foto.Foto;
import modelo.foto.FotoDAO;

public class MostrarProdutoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        FotoDAO fotoDAO = new FotoDAO();
        List<Foto> fotos = fotoDAO.obterPeloProduto(id);
        fotos.sort(Comparator.comparingInt(foto ->{
            String nomeArquivo = foto.getFoto().substring(foto.getFoto().lastIndexOf("/") + 1);                            
            String[] partes = nomeArquivo.split("\\|");
            return Integer.parseInt(partes[0].trim());
        }));
        String caminhoFoto = fotos.getFirst().getFoto();
        response.setContentType(getServletContext().getMimeType(caminhoFoto));
        response.setContentLengthLong(new File(caminhoFoto).length());
        try (FileInputStream fis = new FileInputStream(new File(caminhoFoto)); OutputStream out = response.getOutputStream()) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }

}
