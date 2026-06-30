package controle.foto;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.List;
import modelo.foto.Foto;
import modelo.foto.FotoDAO;
import utils.Utils;

public class AdicionarFotoBDServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Part foto = request.getPart("foto");
        if(foto == null || foto.getSubmittedFileName().isEmpty()){
            request.setAttribute("mensagem", "Nenhuma imagem selecionada");
        } else {
            FotoDAO fotoDAO = new FotoDAO();
            List<Foto> fotos = fotoDAO.obterPeloProduto(id);
            int qnt = fotos.size();
            String extensao = foto.getSubmittedFileName().substring(foto.getSubmittedFileName().lastIndexOf("."));
            String nomeArquivo = String.format("%d_%d%s", qnt+1, id, extensao);
            boolean sucesso = false;
            sucesso = fotoDAO.inserir(Utils.UPLOAD_PATH + File.separator + nomeArquivo, id);
            if (sucesso) {
                File fotoFile = new File(Utils.UPLOAD_PATH, nomeArquivo);
                try (InputStream input = foto.getInputStream()) {
                    Files.copy(input, fotoFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }
                request.setAttribute("mensagem", "Imagem salva com sucesso");
            } else {
                request.setAttribute("mensagem", "Não foi possível salvar a imagem");
            }
        }
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("Produto");
        requestDispatcher.forward(request, response);
    }

}