/*
 * Framework de Acesso a Dados - Adaptado para MySQL
 * Baseado no framework original do Prof. Mauricio Asenjo
 */
package tpsemana11;

import java.sql.*;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

/**
 * Access Framework Data Access Layer
 * Camada de acesso a dados adaptada para MySQL
 */
public class AFDAL {
    private static Connection con;

    // Configurações de conexão MySQL
    private static final String DB_URL = "jdbc:mysql://localhost:3306/biblioteca_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin";

    /**
     * Conecta ao banco de dados MySQL
     */
    public static void conecta()
    {
        Erro.setErro(false);
        try
        {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        }
        catch (Exception e)
        {
            Erro.setErro(e.getMessage());
        }
    }

    /**
     * Desconecta do banco de dados
     */
    public static void desconecta()
    {
        Erro.setErro(false);
        try 
        {
            if (con != null && !con.isClosed())
                con.close();
        }
        catch (Exception e)
        {
            Erro.setErro(e.getMessage());
        }
    }

    /**
     * Executa comandos SQL (INSERT, UPDATE, DELETE)
     */
    public static void executeSQL(String _sql)
    {
        Erro.setErro(false);
        try 
        {
            Statement st = con.createStatement();
            st.executeUpdate(_sql);
            st.close();
        }
        catch(Exception e)
        {
            Erro.setErro(e.getMessage());
        }
    }

    /**
     * Executa SELECT e preenche objeto com reflection
     */
    public static void executeSelect(String _sql, Object obj)
    {
        ResultSet rs;
        Erro.setErro(false);
        try
        {
            PreparedStatement st = con.prepareStatement(_sql);
            rs = st.executeQuery();
            if (rs.next())
            {
                Field[] f  = obj.getClass().getDeclaredFields();
                Method mtd;
                String aux;
                for(int i=0; i<f.length; ++i)
                {
                    aux="set"+f[i].getName().substring( 0, 1 ).toUpperCase() + f[i].getName().substring( 1 );
                    try 
                    {
                        mtd = obj.getClass().getMethod(aux, new Class[] {f[i].getType()});
                        mtd.invoke(obj, new Object[] {rs.getString(f[i].getName())});
                    }
                    catch(Exception e){}
                }
            }
            else
            {
                Erro.setErro(obj.getClass().getSimpleName() + " não localizado."); 
                return; 
            }
            st.close();
        }
        catch (Exception e)
        {
            Erro.setErro(e.getMessage());
        }
    }

    /**
     * Executa SELECT e retorna ResultSet para listagens
     */
    public static ResultSet executeSelectList(String _sql)
    {
        ResultSet rs = null;
        Erro.setErro(false);
        try
        {
            Statement st = con.createStatement();
            rs = st.executeQuery(_sql);
        }
        catch (Exception e)
        {
            Erro.setErro(e.getMessage());
        }
        return rs;
    }
    
        public static boolean exists(String sql)
    {
        ResultSet rs = null;
        Erro.setErro(false);
        try
        {
            Statement st = con.createStatement();
            rs = st.executeQuery(sql);
            boolean result = rs.next();
            st.close();
            return result;
        }
        catch (Exception e)
        {
            Erro.setErro(e.getMessage());
            return false;
        }
    }
}
