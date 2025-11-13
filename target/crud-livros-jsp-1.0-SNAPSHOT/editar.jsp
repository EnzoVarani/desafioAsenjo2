<%@page import="tpsemana11.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Livro - Biblioteca Digital</title>
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
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
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
            border-color: #f093fb;
        }
        
        input[type="text"]:disabled {
            background: #f5f5f5;
            cursor: not-allowed;
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
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
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
            <h1>✏️ Editar Livro</h1>
        </header>
        
        <div class="content">
            <%
                String acao = request.getParameter("acao");
                String idBusca = request.getParameter("id");
                Livro livro = new Livro();
                
                if ("atualizar".equals(acao)) {
                    String novaLocalizacao = request.getParameter("localizacao");
                    String idAtual = request.getParameter("id");
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
                            livro.setId(idAtual);
                            ALDAL.get(livro);
                        }
                    } catch (NumberFormatException e) {
            %>
                        <div class="alert alert-error">
                            <strong>✗ Erro!</strong> O ano deve ser um número válido entre 1500 e 2025.
                        </div>
            <%
                        temErro = true;
                        livro.setId(idAtual);
                        ALDAL.get(livro);
                    }
                    
                    if (!temErro) {
                        AFDAL.conecta();
                        boolean localizacaoOcupada = AFDAL.exists(
                            "SELECT * FROM TabLivro WHERE localizacao = '" + novaLocalizacao + 
                            "' AND id != '" + idAtual + "'"
                        );
                        AFDAL.desconecta();
                        
                        if (localizacaoOcupada) {
            %>
                        <div class="alert alert-error">
                            <strong>✗ Erro!</strong> A localização "<%= novaLocalizacao %>" já está ocupada. Escolha outra prateleira.
                        </div>
            <%
                            livro.setId(idAtual);
                            ALDAL.get(livro);
                        } else {
                            Livro dados = new Livro();
                            dados.setTitulo(request.getParameter("titulo"));
                            dados.setAutor(request.getParameter("autor"));
                            dados.setEditora(request.getParameter("editora"));
                            dados.setAno(ano);
                            dados.setLocalizacao(novaLocalizacao);
                            
                            Livro chave = new Livro();
                            chave.setId(idAtual);
                            
                            ALDAL.update(dados, chave);
                            
                            if (!Erro.getErro()) {
                                response.sendRedirect("index.jsp?sucesso=atualizado");
                                return;
                            } else {
            %>
                        <div class="alert alert-error">
                            <strong>✗ Erro!</strong> <%= Erro.getMens() %>
                        </div>
            <%
                                livro.setId(idAtual);
                                ALDAL.get(livro);
                            }
                        }
                    }
                } else {
                    livro.setId(idBusca);
                    ALDAL.get(livro);
                    
                    if (Erro.getErro()) {
            %>
                        <div class="alert alert-error">
                            <strong>✗ Erro!</strong> Livro não encontrado.
                        </div>
                        <script>
                            setTimeout(function() {
                                window.location.href = 'index.jsp';
                            }, 2000);
                        </script>
            <%
                    }
                }
            %>
            
            <form method="post" action="editar.jsp">
                <input type="hidden" name="acao" value="atualizar">
                <input type="hidden" name="id" value="<%= livro.getId() %>">
                
                <div class="form-group">
                    <label for="id_display">📋 ID</label>
                    <input type="text" id="id_display" value="<%= livro.getId() != null ? livro.getId() : "" %>" disabled>
                </div>
                
                <div class="form-group">
                    <label for="titulo">📖 Título *</label>
                    <input type="text" id="titulo" name="titulo" required value="<%= livro.getTitulo() != null ? livro.getTitulo() : "" %>">
                </div>
                
                <div class="form-group">
                    <label for="autor">✍️ Autor *</label>
                    <input type="text" id="autor" name="autor" required value="<%= livro.getAutor() != null ? livro.getAutor() : "" %>">
                </div>
                
                <div class="form-group">
                    <label for="editora">🏢 Editora *</label>
                    <input type="text" id="editora" name="editora" required value="<%= livro.getEditora() != null ? livro.getEditora() : "" %>">
                </div>
                
                <div class="form-group">
                    <label for="ano">📅 Ano *</label>
                    <input type="text" id="ano" name="ano" required value="<%= livro.getAno() != null ? livro.getAno() : "" %>">
                    <div class="hint">Apenas anos entre 1500 e 2025</div>
                </div>
                
                <div class="form-group">
                    <label for="localizacao">📍 Localização *</label>
                    <input type="text" id="localizacao" name="localizacao" required value="<%= livro.getLocalizacao() != null ? livro.getLocalizacao() : "" %>">
                </div>
                
                <div class="btn-group">
                    <button type="button" class="btn btn-secondary" onclick="window.location.href='index.jsp'">
                        ← Cancelar
                    </button>
                    <button type="submit" class="btn btn-primary">
                        💾 Atualizar Livro
                    </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
