<%-- 
    Document   : detail
    Created on : 26-feb-2024, 10:51:27
    Author     : AlArcoMu
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
    <head>
        <title>Detail</title>
        <!-- Required meta tags -->
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

        <!-- Bootstrap CSS v5.2.1 -->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
            crossorigin="anonymous"
        />
    </head>

    <body>
        <div class="container">
            <nav class="navbar navbar-dark bg-dark">
                <div class="container d-flex justify-content-between">
                    <a class="navbar-brand" href="Controller?op=inicio"><img src="img/logo_nevasport.svg" alt="" width="150"></a>
                </div>
            </nav>
            <div class="card m-3">
                <h4 class="card-title bg-black text-white p-1 m-0"><img src="img/spain.gif" alt=""> ${estacionSelected.nombre}</h4>
                <div class="card-body">
                    <img src="${estacionSelected.plano}" alt="" width="100%">
                </div>
            </div>
            <div class="card m-3">
                <h4 class="card-title bg-black text-white p-1 m-0">Gallery:</h4>
                <div class="card-body">
                    <div class="row d-flex">
                        <c:forEach var="foto" items="${estacionSelected.imagenList}">
                            <div class="col-xl-3 col-lg-6 col-md-6 col-sm-6 p-3 d-fill">
                                <img src="${foto.foto}" alt="" width="300" height="200">
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
             <div class="row justify-content-center">
                <form action="Controller?op=PostComent" method="post">
                    <div class="mb-3 d-flex justify-content-center">
                        <input type="text" class="form-control" name="comentario" placeholder="Ingrese tu comentario" style="width: 500px;">
                        <button type="submit" class="btn btn-danger text-white">Post</button>
                    </div>
                </form>
            </div>
            <footer class="bg-dark text-white py-4 text-center d-flex justify-content-between">
                <img src="img/logo_nevasport.svg" alt="" width="200">
                <h5>&copy;AlArcoMu</h5>
                <img src="img/logo_infonieve.svg" alt="" width="200">
            </footer>
        </div>
        <!-- Bootstrap JavaScript Libraries -->
        <script
            src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
            integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
            crossorigin="anonymous"
        ></script>

        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
            integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
            crossorigin="anonymous"
        ></script>
    </body>
</html>

