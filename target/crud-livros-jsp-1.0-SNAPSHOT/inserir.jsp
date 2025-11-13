<%@page import="tpsemana11.*"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Novo Livro - Biblioteca Digital</title>
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
            max-width: 800px;
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
            font-size: 2em;
        }
        
        .content {
            padding: 40px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
        }
        
        input[type="text"] {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1em;
            transition: border-color 0.3s;
        }
        
        input[type="text"]:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        
        .btn {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-secondary {
            background: #e0e0e0;
            color: #333;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }
        
        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        .hint {
            font-size: 0.85em;
            color: #666;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>➕ Adicionar Novo Livro</h1>
        </header>
        
        <div class="content">
            <%
                String acao = request.getParameter("acao");
                String proximoId = "001";
                
                AFDAL.conecta();
                ResultSet rsMaxId = AFDAL.executeSelectList("SELECT MAX(CAST(id AS UNSIGNED)) as maxId FROM TabLivro");
                if (rsMaxId != null && rsMaxId.next()) {
                    int maxId = rsMaxId.getInt("maxId");
                    proximoId = String.format("%03d", maxId + 1);
                }
                AFDAL.desconecta();
                
                if ("inserir".equals(acao)) {
                    String id = request.getParameter("id");
                    String localizacao = request.getParameter("localizacao");
                    String ano = request.getParameter("ano");
                    boolean temErro = false;
                    
                    try {
                        int anoInt = Integer.parseInt(ano);
                        if (anoInt < 1500 || anoInt > 2025) {
            %>
                        <div class="alert alert-error">
                            <strong>✗ Erro!</strong> O ano deve ser um número entre 1500 e 2025.
                        </div>
            <%
                            temErro = true;
                        }
                    } catch (NumberFormatException e) {
            %>
                        <div class="alert alert-error">
                            <strong>✗ Erro!</strong> O ano deve ser um número válido entre 1500 e 2025.
                        </div>
            <%
                        temErro = true;
                    }
                    
                    if (!temErro) {
                        AFDAL.conecta();
                        boolean idJaExiste = AFDAL.exists("SELECT * FROM TabLivro WHERE id = '" + id + "'");
                        boolean localizacaoOcupada = AFDAL.exists("SELECT * FROM TabLivro WHERE localizacao = '" + localizacao + "'");
                        AFDAL.desconecta();
                        
                        if (idJaExiste) {
            %>
                        <div class="alert alert-error">
                            <strong>✗ Erro!</strong> Já existe um livro cadastrado com o ID "<%= id %>". Use outro ID.
                        </div>
            <%
                        } else if (localizacaoOcupada) {
            %>
                        <div class="alert alert-error">
                            <strong>✗ Erro!</strong> A localização "<%= localizacao %>" já está ocupada. Escolha outra prateleira.
                        </div>
            <%
                        } else {
                            Livro livro = new Livro();
                            livro.setId(id);
                            livro.setTitulo(request.getParameter("titulo"));
                            livro.setAutor(request.getParameter("autor"));
                            livro.setEditora(request.getParameter("editora"));
                            livro.setAno(ano);
                            livro.setLocalizacao(localizacao);
                            
                            ALDAL.set(livro);
                            
                            if (!Erro.getErro()) {
                                response.sendRedirect("index.jsp?sucesso=inserido");
                                return;
                            } else {
            %>
                        <div class="alert alert-error">
                            <strong>✗ Erro!</strong> <%= Erro.getMens() %>
                        </div>
            <%
                            }
                        }
                    }
                }
            %>
            
            <form method="post" action="inserir.jsp">
                <input type="hidden" name="acao" value="inserir">
                
                <div class="form-group">
                    <label for="id">📋 ID *</label>
                    <input type="text" id="id" name="id" required 
                           value="<%= request.getParameter("id") != null ? request.getParameter("id") : proximoId %>" 
                           placeholder="Ex: <%= proximoId %>">
                    <div class="hint">ID sugerido: <%= proximoId %></div>
                </div>
                
                <div class="form-group">
                    <label for="titulo">📖 Título *</label>
                    <input type="text" id="titulo" name="titulo" required placeholder="Ex: Clean Code"
                           value="<%= request.getParameter("titulo") != null ? request.getParameter("titulo") : "" %>">
                </div>
                
                <div class="form-group">
                    <label for="autor">✍️ Autor *</label>
                    <input type="text" id="autor" name="autor" required placeholder="Ex: Robert C. Martin"
                           value="<%= request.getParameter("autor") != null ? request.getParameter("autor") : "" %>">
                </div>
                
                <div class="form-group">
                    <label for="editora">🏢 Editora *</label>
                    <input type="text" id="editora" name="editora" required placeholder="Ex: Alta Books"
                           value="<%= request.getParameter("editora") != null ? request.getParameter("editora") : "" %>">
                </div>
                
                <div class="form-group">
                    <label for="ano">📅 Ano *</label>
                    <input type="text" id="ano" name="ano" required placeholder="Ex: 2009"
                           value="<%= request.getParameter("ano") != null ? request.getParameter("ano") : "" %>">
                    <div class="hint">Apenas anos entre 1500 e 2025</div>
                </div>
                
                <div class="form-group">
                    <label for="localizacao">📍 Localização *</label>
                    <input type="text" id="localizacao" name="localizacao" required placeholder="Ex: Prateleira A-01"
                           value="<%= request.getParameter("localizacao") != null ? request.getParameter("localizacao") : "" %>">
                </div>
                
                <div class="btn-group">
                    <button type="button" class="btn btn-secondary" onclick="window.location.href='index.jsp'">
                        ← Cancelar
                    </button>
                    <button type="submit" class="btn btn-primary">
                        💾 Salvar Livro
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
