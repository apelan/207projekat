package servlets;

import dao.GameDAO;
import dao.GameDAOImpl;
import entities.Game;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

//location="C:/Users/ladmin/Desktop/Proj/GameCorner/web/res/pics"
@WebServlet

//location=Treba da ide putanja do project foldera + \\res\\pics zato sto tu cuvamo slike i odatle se ucitavaju u prikazu
//nadjite putanju gde vam je project folder
//npr C:\\Users\\UlogovanUser\\Desktop\\GameCorner\\web\\res\\pics
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50,
        location="C:\\Users\\flash\\Desktop\\git\\207projekat\\GameCorner\\web\\res\\pics") //ko mene je ovako
public class UploadPictureGame extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            Part part = request.getPart("image");
            String fileName = extractFileName(part);

            String savePath = File.separator + fileName;
            File f = new File(savePath);
            part.write(savePath + File.separator);
            response.sendRedirect("home.jsp");
            GameDAO dao = new GameDAOImpl();
            int gameID = Integer.parseInt(request.getParameter("gameIDPicUpload"));
            Game g = dao.readById(gameID);
            g.setImage(savePath);
            dao.update(g);
            response.flushBuffer();
        }
    }
    
    private String extractFileName(Part part){
        String cd = part.getHeader("content-disposition");
        String[] items = cd.split(";");
        for(String s: items){
            if(s.trim().startsWith("filename")){
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
