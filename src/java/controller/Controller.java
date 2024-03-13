package controller;

import entities.Comentario;
import entities.Estacion;
import entities.Provincia;
import entities.Usuario;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.NoResultException;
import javax.persistence.Query;
import org.apache.jasper.tagplugins.jstl.core.ForEach;
import util.JPAUtil;


/**
 * Servlet implementation class Controller
 */
@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Query q;
    private List provincias=null;
    private List estaciones=null;
    private Usuario usuario=null;
    private Provincia provinciaSelected=null;
    private Estacion estacionSelected=null;
    private Comentario comentarioobj=null;
    private List Allestaciones=null;
    private List<Comentario> comentarios=null;

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String op = request.getParameter("op");
		
		// Singleton
		EntityManager em = (EntityManager) session.getAttribute("em");
		if (em==null) {
                    // Create the EntityManager
                        em = JPAUtil.getEntityManagerFactory().createEntityManager();
			session.setAttribute("em", em);
		}
		
		switch (op) {
		case "inicio": {
                    q = em.createNamedQuery("Provincia.findAll");
                    provincias = q.getResultList();
                    q = em.createNamedQuery("Estacion.findAll");
                    Allestaciones = q.getResultList();
                    estaciones = Allestaciones;
                    session.setAttribute("provincias", provincias);
                    session.setAttribute("estaciones", estaciones);
                    session.setAttribute("Allestaciones", Allestaciones);
                    session.setAttribute("usuario", usuario);
                    request.getRequestDispatcher("home.jsp").forward(request, response);
                    break;
		}case "login":{
                    String nick = request.getParameter("nick");
                    String pass = request.getParameter("pass");
                    q = em.createQuery("SELECT u FROM Usuario u WHERE u.nick = '"+nick+"' AND u.pass = '"+pass+"'");
                    try {
                        usuario = (Usuario) q.getSingleResult();
                    } catch (NoResultException e) {
                    }


                    if (usuario==null) { // Login incorrecto procedemos a insertarlo
                        usuario = new Usuario(Short.valueOf("1"));
                        usuario.setNick(nick);
                        usuario.setPass(pass);
                        EntityTransaction t = em.getTransaction();
                        t.begin();
                        em.persist(usuario);
                        t.commit();
                    }
                    session.setAttribute("usuario", usuario);
                    request.getRequestDispatcher("home.jsp").forward(request, response);
                }
                case "logout":{
                    session.removeAttribute("usuario");
                    request.getRequestDispatcher("home.jsp").forward(request, response);
                }
                case "SelectedProvincia":{
                    String provSeleccionada = request.getParameter("provSeleccionada");
                    q = em.createQuery("SELECT p FROM Provincia p WHERE p.id = '"+provSeleccionada+"'");
                    provinciaSelected= (Provincia)q.getSingleResult();
                    estaciones=provinciaSelected.getEstacionList();
                    session.setAttribute("estaciones", estaciones);
                    session.setAttribute("usuario", usuario);
                    request.getRequestDispatcher("home.jsp").forward(request, response);
                }
                case "SelectedEstacion":{
                    String estSeleccionada = request.getParameter("estSeleccionada");
                    estacionSelected=em.find(Estacion.class, Short.valueOf(estSeleccionada));
                    session.setAttribute("estacionSelected", estacionSelected);
                    session.setAttribute("usuario", usuario);
                    request.getRequestDispatcher("detail.jsp").forward(request, response);
                }
                case "SelectedAll":{
                    q = em.createNamedQuery("Estacion.findAll");
                    estaciones = q.getResultList();
                    session.setAttribute("estaciones", estaciones);
                    session.setAttribute("usuario", usuario);
                    request.getRequestDispatcher("home.jsp").forward(request, response);
                }
                case "PostComent":{
                    usuario = (Usuario) session.getAttribute("usuario");
                    String comentario = request.getParameter("comentario");
                    estacionSelected = (Estacion) session.getAttribute("estacionSelected");
                    comentarioobj=new Comentario();
                    comentarioobj.setId(-1);
                    comentarioobj.setComentario(comentario);
                    comentarioobj.setEstacion(estacionSelected);
                    comentarioobj.setUsuario(usuario);
                    EntityTransaction t= em.getTransaction();
                    t.begin();
                    em.persist(comentarioobj);
                    t.commit();
                    session.setAttribute("usuario", usuario);
                    request.getRequestDispatcher("home.jsp").forward(request, response);
                }
                case "DameComents":{
                    String idestacion = request.getParameter("idestacion");
                    Estacion estacion=em.find(Estacion.class,Short.valueOf(idestacion));
                    comentarios = estacion.getComentarioList();
                    session.setAttribute("comentarios", comentarios);
                    request.getRequestDispatcher("comentarios.jsp").forward(request, response);
                }
                default:
                        throw new IllegalArgumentException("Unexpected value: " + op);
                }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
