package controle.foto;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import modelo.foto.FotoDAO;

public class MostrarFotoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        FotoDAO fotoDAO = new FotoDAO();
        String caminhoFoto = fotoDAO.obterPeloId(id).getFoto();
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
