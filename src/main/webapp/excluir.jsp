<%@page import="tpsemana11.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Excluir Livro - Biblioteca Digital</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            min-height: 100vh;
            padding: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .container {
            max-width: 500px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            overflow: hidden;
            text-align: center;
        }
        
        header {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            color: white;
            padding: 30px;
        }
        
        h1 {
            font-size: 2em;
        }
        
        .content {
            padding: 40px;
        }
        
        .alert {
            padding: 20px;
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
        
        .icon {
            font-size: 4em;
            margin-bottom: 20px;
        }
        
        p {
            font-size: 1.1em;
            color: #666;
            margin-bottom: 10px;
        }
        
        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: bold;
            transition: transform 0.3s;
        }
        
        .btn:hover {
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>🗑️ Excluir Livro</h1>
        </header>
        
        <div class="content">
            <%
                String id = request.getParameter("id");
                
                if (id != null && !id.trim().isEmpty()) {
                    Livro livro = new Livro();
                    livro.setId(id);
                    
                    ALDAL.delete(livro);
                    
                    if (!Erro.getErro()) {
                        response.sendRedirect("index.jsp?sucesso=excluido");
                        return;
                    } else {
            %>
                        <div class="icon">✗</div>
                        <div class="alert alert-error">
                            <strong>Erro ao excluir!</strong>
                        </div>
                        <p><%= Erro.getMens() %></p>
            <%
                    }
                } else {
            %>
                    <div class="icon">⚠️</div>
                    <div class="alert alert-error">
                        <strong>ID inválido!</strong>
                    </div>
                    <p>Não foi possível identificar o livro a ser excluído.</p>
            <%
                }
            %>
            
            <a href="index.jsp" class="btn">← Voltar para Lista</a>
        </div>
    </div>
</body>
</html>
