package controle.foto;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import modelo.foto.Foto;
import modelo.foto.FotoDAO;

public class RemoverFotoServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        FotoDAO fotoDAO = new FotoDAO();
        Foto foto = fotoDAO.obterPeloId(id);
        Path path = Paths.get(foto.getFoto());
        Files.deleteIfExists(path);
        boolean sucesso = fotoDAO.remover(id);
        if (sucesso) {
            request.setAttribute("mensagem", "Foto removida com sucesso");
        } else {
            request.setAttribute("mensagem", "Não foi possível remover a foto");
        }
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("Produto");
        requestDispatcher.forward(request, response);
    }

}
