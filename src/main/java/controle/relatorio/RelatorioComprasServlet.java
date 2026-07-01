package controle.relatorio;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.List;
import modelo.relatorio.RelCompras;
import modelo.relatorio.RelatorioDAO;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.font.Standard14Fonts;

public class RelatorioComprasServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment;filename=\"relatorio_compras_cliente.pdf\"");
        try (PDDocument document = new PDDocument()) {
        PDPage page = new PDPage();
        document.addPage(page);
        try (PDPageContentStream contentStream = new PDPageContentStream(document, page)) {
        contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 12);
        contentStream.beginText();
        contentStream.setLeading(14.5f);
        contentStream.newLineAtOffset(50, 750);
        contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD),
        16);
        contentStream.showText("Relatório de Compras por Cliente");
        contentStream.newLine();
        contentStream.newLine();
        contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 12);
        LocalDate dataInicio = LocalDate.parse(request.getParameter("dataInicio"));
        LocalDate dataFim = LocalDate.parse(request.getParameter("dataFim"));
        RelatorioDAO relatorioDAO = new RelatorioDAO();
        List<RelCompras> relCompras = relatorioDAO.relatorioCompras(dataInicio, dataFim);
        for (RelCompras r : relCompras) {
        contentStream.showText("ID cliente: " + r.getId() + " | Nome do cliente: " + r.getNome() + " | Quantidade de Compras: " + r.getQntCompras());
        contentStream.newLine();
        }
        contentStream.endText();
        }
        document.save(response.getOutputStream());
        }
    }
}