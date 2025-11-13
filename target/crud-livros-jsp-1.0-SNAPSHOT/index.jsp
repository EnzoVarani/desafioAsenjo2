<%@page import="java.sql.*"%>
<%@page import="tpsemana11.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sistema de Gerenciamento de Livros</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            overflow: hidden;
        }
        
        header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
        }
        
        .subtitle {
            opacity: 0.9;
            font-size: 1.1em;
        }
        
        .content {
            padding: 30px;
        }
        
        .search-bar {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
        }
        
        .search-bar input {
            flex: 1;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1em;
            transition: border-color 0.3s;
        }
        
        .search-bar input:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .btn {
            padding: 14px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
            transition: transform 0.3s, box-shadow 0.3s;
            border: none;
            cursor: pointer;
            font-size: 1em;
            display: inline-block;
            line-height: 1.4;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        
        .btn-secondary {
            background: #e0e0e0;
            color: #333;
        }
        
        .btn-container {
            text-align: right;
            margin-bottom: 20px;
        }
        
        .stats-box {
            padding: 14px 20px;
            background: linear-gradient(135deg, #f0f4ff 0%, #e8ecff 100%);
            border-radius: 8px;
            border-left: 4px solid #667eea;
            display: inline-block;
        }
        
        .stats-box h3 {
            margin: 0;
            color: #667eea;
            font-size: 1em;
            line-height: 1.4;
        }
        
        .header-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 20px 0;
            gap: 20px;
        }

        
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            animation: fadeIn 0.5s;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }
        
        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
        }
        
        td {
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
        }
        
        tr:hover {
            background-color: #f8f9ff;
        }
        
        .actions {
            display: flex;
            gap: 10px;
        }
        
        .btn-edit {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            padding: 8px 20px;
            font-size: 0.9em;
        }
        
        .btn-delete {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            padding: 8px 20px;
            font-size: 0.9em;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }
        
        .book-icon {
            font-size: 1.5em;
            margin-right: 5px;
        }
        
        .year-old { color: #8B4513; }
        .year-medium { color: #2E7D32; }
        .year-recent { color: #1976D2; }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>📚 Biblioteca Digital</h1>
            <p class="subtitle">Sistema de Gerenciamento de Livros</p>
        </header>
        
        <div class="content">
            <%
                String sucesso = request.getParameter("sucesso");
                if (sucesso != null) {
                    String mensagem = "";
                    if ("inserido".equals(sucesso)) mensagem = "✓ Livro inserido com sucesso!";
                    else if ("atualizado".equals(sucesso)) mensagem = "✓ Livro atualizado com sucesso!";
                    else if ("excluido".equals(sucesso)) mensagem = "✓ Livro excluído com sucesso!";
            %>
                <div class="alert alert-success">
                    <strong><%= mensagem %></strong>
                </div>
                <script>
                    setTimeout(function() {
                        window.history.replaceState({}, document.title, "index.jsp");
                        location.reload();
                    }, 3000);
                </script>
            <% } %>
            
            <form method="get" action="index.jsp" class="search-bar">
                <input type="text" name="busca" placeholder="🔍 Buscar por título, autor ou ID..." 
                       value="<%= request.getParameter("busca") != null ? request.getParameter("busca") : "" %>">
                <button type="submit" class="btn">Buscar</button>
                <% if (request.getParameter("busca") != null && !request.getParameter("busca").trim().isEmpty()) { %>
                    <a href="index.jsp" class="btn btn-secondary">Limpar</a>
                <% } %>
            </form>
            
            <%
                String termoBusca = request.getParameter("busca");
                String sqlCount = "SELECT COUNT(*) as total FROM TabLivro";
                String sqlList;
                
                if (termoBusca != null && !termoBusca.trim().isEmpty()) {
                    sqlList = "SELECT * FROM TabLivro WHERE titulo LIKE '%" + termoBusca + "%' " +
                              "OR autor LIKE '%" + termoBusca + "%' OR id LIKE '%" + termoBusca + "%' " +
                              "ORDER BY CAST(id AS UNSIGNED)";
                } else {
                    sqlList = "SELECT * FROM TabLivro ORDER BY CAST(id AS UNSIGNED)";
                }
                
                AFDAL.conecta();
                ResultSet rsCount = AFDAL.executeSelectList(sqlCount);
                int totalLivros = 0;
                if (rsCount != null && rsCount.next()) {
                    totalLivros = rsCount.getInt("total");
                }
            %>
            
            <div class="header-bar">
                <div class="stats-box">
                    <h3>📊 Total: <strong><%= totalLivros %></strong> livros</h3>
                </div>
                <div class="btn-container">
                    <a href="inserir.jsp" class="btn">➕ Novo Livro</a>
                </div>
            </div>
      
            <%
                ResultSet rs = AFDAL.executeSelectList(sqlList);
                boolean temLivros = false;
                if (rs != null && rs.next()) {
                    temLivros = true;
            %>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Título</th>
                        <th>Autor</th>
                        <th>Editora</th>
                        <th>Ano</th>
                        <th>Localização</th>
                        <th>Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        do {
                            int ano = Integer.parseInt(rs.getString("ano"));
                            String iconClass = ano < 2000 ? "year-old" : (ano < 2020 ? "year-medium" : "year-recent");
                            String icon = ano < 2000 ? "📖" : (ano < 2020 ? "📗" : "📘");
                    %>
                    <tr>
                        <td><%= rs.getString("id") %></td>
                        <td><span class="book-icon <%= iconClass %>"><%= icon %></span><strong><%= rs.getString("titulo") %></strong></td>
                        <td><%= rs.getString("autor") %></td>
                        <td><%= rs.getString("editora") %></td>
                        <td><%= rs.getString("ano") %></td>
                        <td><%= rs.getString("localizacao") %></td>
                        <td>
                            <div class="actions">
                                <a href="editar.jsp?id=<%= rs.getString("id") %>" class="btn btn-edit">✏️ Editar</a>
                                <a href="excluir.jsp?id=<%= rs.getString("id") %>" class="btn btn-delete" 
                                   onclick="return confirm('Tem certeza que deseja excluir o livro <%= rs.getString("titulo") %>?')">🗑️ Excluir</a>
                            </div>
                        </td>
                    </tr>
                    <%
                        } while(rs.next());
                    %>
                </tbody>
            </table>
            
            <%
                } else {
            %>
            
            <div class="empty-state">
                <h2 style="font-size: 4em; margin-bottom: 20px;">📚</h2>
                <h2>Nenhum livro encontrado</h2>
                <p style="margin-top: 10px;">
                    <% if (termoBusca != null && !termoBusca.trim().isEmpty()) { %>
                        Nenhum resultado para "<%= termoBusca %>". Tente outro termo.
                    <% } else { %>
                        Clique em "Novo Livro" para adicionar o primeiro livro à biblioteca
                    <% } %>
                </p>
            </div>
            
            <%
                }
                AFDAL.desconecta();
            %>
        </div>
    </div>
</body>
</html>
