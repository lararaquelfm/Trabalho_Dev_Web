package controle.relatorio;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import modelo.produto.Produto;
import modelo.relatorio.RelatorioDAO;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.font.Standard14Fonts;

public class ProdutosEmFaltaServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment;filename=\"relatorio_produtos_em_falta.pdf\"");
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
        contentStream.showText("Relatório de Produtos em Falta no Estoque");
        contentStream.newLine();
        contentStream.newLine();
        contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 12);
        RelatorioDAO relatorioDAO = new RelatorioDAO();
        List<Produto> produtos = relatorioDAO.relatorioFaltaEstoque();
        for (Produto p : produtos) {
        contentStream.showText("ID produto: " + p.getId() + " | Descrição: " + p.getDescricao() + " | Preço: " + p.getPreco());
        contentStream.newLine();
        }
        contentStream.endText();
        }
        document.save(response.getOutputStream());
        }
    }
}