<%-- 
    Document   : home
    Created on : 26-feb-2024, 9:50:17
    Author     : AlArcoMU
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
    <head>
        <title>AlArcoMu</title>
        <!-- Required meta tags -->
        <meta charset="utf-8" />
        <meta
            name="viewport"
            content="width=device-width, initial-scale=1, shrink-to-fit=no"
        />

        <!-- Bootstrap CSS v5.2.1 -->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
            crossorigin="anonymous"
        />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>

    <body>
        <div class="container">
            <nav class="navbar navbar-dark bg-dark">
                <div class="container d-flex justify-content-between">
                    <a class="navbar-brand" href="#"><img src="img/logo_nevasport.svg" alt="" width="150"></a>
                    <!-- Modal trigger button -->
                    <c:if test="${usuario==null}">
                        <button type="button" class="btn btn-success btn-lg"data-bs-toggle="modal" data-bs-target="#modalLogin">
                            Login
                        </button>
                    </c:if>
                    <c:if test="${usuario!=null}">
                        <div class="d-flex align-items-center">
                            <h5 class="text-white">Welcome ${usuario.nick}</h5>
                            <a type="button" class="btn btn-danger ms-3" href="Controller?op=logout" class="text-decoration-none">Logout</a>
                        </div>
                    </c:if>
                </div>
            </nav>
            <div id="carouselId" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner bg-light" role="listbox">
                    <div class="carousel-item active d-flex overflow-auto">
                        <a href="Controller?op=SelectedAll" id="All" class="col-lg-2 justify-content-center bg-info m-3 text-decoration-none"
                            onmouseover="cambiarFondo('All', 'bg-danger')"
                            onmouseout="cambiarFondo('All', 'bg-info')">
                            <h1 class="text-center text-black">Todas</h1>
                            <h5 class="text-center text-black">${Allestaciones.size()} estaciones</h5>
                        </a>
                        <c:forEach var="provincia" items="${provincias}">
                            <a href="Controller?op=SelectedProvincia&provSeleccionada=${provincia.id}" id="${provincia.id}" class="col-lg-2 justify-content-center bg-info m-3 text-decoration-none"
                                onmouseover="cambiarFondo('${provincia.id}', 'bg-danger')"
                                onmouseout="cambiarFondo('${provincia.id}', 'bg-info')">
                                <h1 class="text-center text-black">${provincia.nombre}</h1>
                                <h5 class="text-center text-black">${provincia.getEstacionList().size()} estaciones</h5>
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="row bg-light mb-5">
                <h3><i id="info" class="fa fa-info-circle mt-1" aria-hidden="true"></i> Estaciones de esquí alpino en España</h3>
                <c:forEach var="estacion" items="${estaciones}">
                    <div class="col-lg-3 col-md-6 col-sm-6 d-flex mt-3">
                    <div class="card p-0 d-fill">
                        <h4 class="card-title bg-black text-white p-1 m-0">${estacion.nombre}</h4>
                        <h6 class="card-title bg-info p-1 m-0">España: ${estacion.provincia.getNombre()}</h6>
                        <div class="card-body d-flex align-items-center">
                          <img src="${estacion.logo}" alt="" width="80">
                          <h6 class="text-center ms-5">${estacion.km} kilometros</h6>
                        </div>
                        <div class="d-flex justify-content-between m-2">
                            <c:if test="${usuario!=null}">
                                <a id="info" class="fa fa-info-circle fa-3x mt-1 text-decoration-none text-black" aria-hidden="true" href="Controller?op=SelectedEstacion&estSeleccionada=${estacion.id}"></a>
                                <!-- Modal Coments button -->
                                <a class="text-decoration-none text-black" data-bs-nombreestacion="${estacion.nombre}" data-bs-idestacion="${estacion.id}"  data-bs-toggle="modal" data-bs-target="#modalComent"><i class="fa fa-comment fa-3x mt-1" aria-hidden="true"></i></a>
                            </c:if>
                        </div> 
                    </div>
                </div>
                </c:forEach>
            </div>
            <footer class="bg-dark text-white py-4 text-center d-flex justify-content-between">
                <img src="img/logo_nevasport.svg" alt="" width="200">
                <h5>&copy;AlArcoMu</h5>
                <img src="img/logo_infonieve.svg" alt="" width="200">
            </footer>
        </div>
                <!-- Modal Login -->
                <!-- if you want to close by clicking outside the modal, delete the last endpoint:data-bs-backdrop and data-bs-keyboard -->
                <div
                    class="modal fade"
                    id="modalLogin"
                    tabindex="-1"
                    
                    role="dialog"
                    aria-labelledby="modalTitleId"
                    aria-hidden="true"
                >
                    <div
                        class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-sm"
                        role="document"
                    >
                        <div class="modal-content">
                            <div class="modal-header bg-dark">
                                <h5 class="modal-title text-info text-center" id="modalTitleId">
                                    Login & Register
                                </h5>
                            </div>
                            <form action="Controller?op=login" method="post">
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label for="" class="form-label">Nick</label>
                                        <input type="text" class="form-control" name="nick" id="" aria-describedby="helpId"
                                            placeholder="" />
        
                                    </div>
                                    <div class="mb-3">
                                        <label for="" class="form-label">Password</label>
                                        <input type="password" class="form-control" name="pass" id="" placeholder="" />
                                    </div>
        
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                        Cancel
                                    </button>
                                    <button type="submit" class="btn btn-primary">Login & register</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- Optional: Place to the bottom of scripts -->
                <script>
                    const myModal = new bootstrap.Modal(
                        document.getElementById("modalLogin"),
                        options,
                    );
                </script>
                
                <!-- Modal Body -->
                <!-- if you want to close by clicking outside the modal, delete the last endpoint:data-bs-backdrop and data-bs-keyboard -->
                <div
                    class="modal fade"
                    id="modalComent"
                    tabindex="-1"
                    data-bs-backdrop="static"
                    data-bs-keyboard="false"
                    
                    role="dialog"
                    aria-labelledby="modalTitleId"
                    aria-hidden="true"
                >
                    <div
                        class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg"
                        role="document"
                    >
                        <div class="modal-content">
                            <div class="modal-header bg-dark">
                                <h4 class="text-info">
                                    <!-- Nombre playa -->
                                </h4>
                            </div>
                            <div class="modal-body">
                                
                            </div>
                            <div class="modal-footer">
                                <button
                                    type="button"
                                    class="btn btn-secondary"
                                    data-bs-dismiss="modal"
                                >
                                    Close
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Optional: Place to the bottom of scripts -->
                <script>
                    const myModal2 = new bootstrap.Modal(
                        document.getElementById("modalComent"),
                        options,
                    );
                </script>
                
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
        <script type="text/javascript" src="js/js.js"></script>
        <script>
            function cambiarFondo(idElemento, claseFondo) {
                var elemento = document.getElementById(idElemento);
                elemento.classList.remove('bg-info', 'bg-danger');
                elemento.classList.add(claseFondo);
            }
        </script>
    </body>
</html>
