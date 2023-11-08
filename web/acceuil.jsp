<%@ include file="header.jsp" %>
<%@ page import="objets.*, java.util.ArrayList" %>
<% 
    ArrayList<String []> allIp = (ArrayList<String []>) request.getAttribute("allIp");
%>
<!--CONTENU-->
<h4 class="fw-bold py-3 mb-4">Liste des noeuds</h4>
<div class="row w-100">
    <div class="col-md-12">
        <div class="card mb-4">
            <h5 class="card-header">Ajouter un noeud</h5>
            <div class="card-body">
                <form action="AddNode" method="GET">
                    <div class="row d-flex justify-content-evenly">
                        <div class="mb-3 row col-md-6">
                            <h5 class="card-header">Designation du noeud</h5>
                            <div class="card-body">
                                <div class="form-floating">
                                    <input type="text" class="form-control" id="floatingInput" name="designation" placeholder="" aria-describedby="floatingInputHelp" required="">
                                    <label for="floatingInput">Description</label>
                                    <div id="floatingInputHelp" class="form-text">
                                        Breve description
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3 row col-md-6">
                            <h5 class="card-header">Adresse IP</h5>
                            <div class="card-body">
                                <div class="form-floating">
                                    <input type="text" class="form-control" id="floatingInput" name="ip" placeholder="" aria-describedby="floatingInputHelp" required="">
                                    <label for="floatingInput">IP</label>
                                    <div id="floatingInputHelp" class="form-text">
                                        Veuillez preciser le port
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-outline-success">Ajouter le noeud</button>
                </form>
            </div>

        </div>
    </div>
    <div class="col-md-12">
        <div class="card">
            <div class="table-responsive text-nowrap">
                <table class="table">
                    <thead>
                        <tr>
                            <th class="text-center">Numero de noeud</th>
                            <th class="text-center">Designation du noeud</th>
                            <th class="text-center">Adresses IP</th>
                            <th class="text-center">Action</th>
                            <th class="text-center">Status</th>
                        </tr>
                    </thead>
                    <tbody class="table-border-bottom-0">
                        <% for(int i = 0; i < allIp.size(); i++) { %>
                        <tr>
                            <td class="text-center"><%= i + 1 %></td>
                            <td class="text-center"><%= allIp.get(i)[1] %></td>
                            <td class="text-center"><%= allIp.get(i)[2] %></td>
                            <td class="text-center">
                                <a class="dropdown-item" href="DropNode?designation=<%= allIp.get(i)[1] %>&ip=<%= allIp.get(i)[2] %>"><i class="bx bx-trash me-1"></i> supprimer</a>
                            </td>
                            <td class="status<%= allIp.get(i)[1] %> text-center">
                                
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</div>
<script>
    function updateStatus() {
        $.ajax({
            url: "pingStatus.jsp", // L'URL du servlet JSP pour effectuer le ping.
            success: function(data) {
                console.log(data);
                var statusArray = JSON.parse(data);
                var status = "<i class='bx bx-no-entry me-1'></i>";
                <% for(int i = 0; i < allIp.size(); i++) { %>
                if(statusArray[<%= i %>] == true) {
                    status = "<i class='bx bx-check-circle me-1'></i>";
                } else {
                    status = "<i class='bx bx-no-entry me-1'></i>";
                }
                    
                $(".status<%= allIp.get(i)[1] %>").html(status);
                <% } %>
            }
        });
    }

    // Mettre à jour le statut toutes les 5 secondes.
    setInterval(updateStatus, 2000);
    updateStatus(); // Mettre à jour le statut au chargement de la page.
</script>
<!--FIN CONTENU-->
<%@ include file="footer.jsp" %>