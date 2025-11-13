/*
 * Framework de Acesso a Dados - Application Logic Data Access Layer
 * Mantém a estrutura original do Prof. Mauricio Asenjo
 */
package tpsemana11;

import java.lang.reflect.*;

/**
 * Application Logic Data Access Layer
 * Camada lógica de acesso a dados
 */
public class ALDAL {

    /**
     * Gera tabela no banco de dados baseado no objeto
     */
    public static void geraTabela(Object obj)
    {
        Field[] f  = obj.getClass().getDeclaredFields();
        String sql = "CREATE TABLE IF NOT EXISTS Tab" + obj.getClass().getSimpleName() + " (";

        for(int i=0; i<f.length; ++i)
        {
            sql += f[i].getName() + " " + (f[i].getType().getSimpleName().equals("String")?"VARCHAR(255)":f[i].getType());
            if (i!=(f.length-1)) sql = sql + ", ";
        }
        sql += ")";

        AFDAL.conecta();
        AFDAL.executeSQL(sql);
        AFDAL.desconecta();
    }

    /**
     * Insere objeto no banco de dados
     */
    public static void set(Object obj)
    {
        Field[] f  = obj.getClass().getDeclaredFields();
        String sql = "INSERT INTO Tab" + obj.getClass().getSimpleName() + " (";
        Method mtd;

        for(int i=0; i<f.length; ++i)
        {
            sql += f[i].getName();
            if (i!=(f.length-1)) sql = sql + ", ";
        }
        sql += ") VALUES (";

        for(int i=0; i<f.length; ++i)
        {
            try
            {
                String aux = "get" + f[i].getName().substring(0,1).toUpperCase() + f[i].getName().substring(1);
                mtd = obj.getClass().getMethod(aux);

                if (f[i].getType().getSimpleName().equals("String"))  
                    sql += "'" + mtd.invoke(obj) + "'";
                else
                    sql += mtd.invoke(obj);
            }
            catch(Exception e) {}
            if (i!=(f.length-1)) sql = sql + ", ";
        }
        sql += ")";

        AFDAL.conecta();
        AFDAL.executeSQL(sql);
        AFDAL.desconecta();
    }

    /**
     * Deleta objeto do banco de dados
     */
    public static void delete(Object obj)
    {
        Field[] f  = obj.getClass().getDeclaredFields();
        String sql = "DELETE FROM Tab" + obj.getClass().getSimpleName() + " WHERE ";
        Method mtd;
        String aux1, aux2;
        boolean flag = false;

        for (int i =0; i < f.length; ++i)
        {
            try
            {
                aux1 = "get" + f[i].getName().substring(0,1).toUpperCase() + f[i].getName().substring(1);  
                mtd = obj.getClass().getMethod(aux1);
                aux2 = mtd.invoke(obj).toString();
                if (!aux2.equals(""))
                {
                    if (flag) sql += " AND "; else flag = true;
                    sql += f[i].getName() + " = ";
                    if (f[i].getType().getSimpleName().equals("String"))  
                        sql += "'" + aux2 + "'";
                    else
                        sql += aux2;
                }
            }
            catch(Exception e) {}
        }

        AFDAL.conecta();
        AFDAL.executeSQL(sql);
        AFDAL.desconecta();
    }

    /**
     * Busca objeto no banco de dados
     */
    public static void get(Object obj)
    {
        Field[] f  = obj.getClass().getDeclaredFields();
        String sql = "SELECT * FROM Tab" + obj.getClass().getSimpleName() + " WHERE ";
        Method mtd;
        String aux1, aux2;
        boolean flag = false;

        for (int i =0; i < f.length; ++i)
        {
            try
            {
                aux1 = "get" + f[i].getName().substring(0,1).toUpperCase() + f[i].getName().substring(1);  
                mtd = obj.getClass().getMethod(aux1);
                aux2 = mtd.invoke(obj).toString();
                if (!aux2.equals(""))
                {
                    if (flag) sql += " AND "; else flag = true;
                    sql += f[i].getName() + " = ";
                    if (f[i].getType().getSimpleName().equals("String"))  
                        sql += "'" + aux2 + "'";
                    else
                        sql += aux2;
                }
            }
            catch(Exception e) {}
        }

        AFDAL.conecta();
        AFDAL.executeSelect(sql, obj);
        AFDAL.desconecta();
    }

    /**
     * Atualiza objeto no banco de dados
     */
    public static void update(Object dados, Object chaves)
    {
        Field[] f  = dados.getClass().getDeclaredFields();
        String sql = "UPDATE Tab" + dados.getClass().getSimpleName() + " SET ";
        Method mtd;
        String aux1, aux2;
        boolean flag = false;

        for (int i =0; i < f.length; ++i)
        {
            try
            {
                aux1 = "get" + f[i].getName().substring(0,1).toUpperCase() + f[i].getName().substring(1);  
                mtd = dados.getClass().getMethod(aux1);
                aux2 = mtd.invoke(dados).toString();
                if (!aux2.equals(""))
                {
                    if (flag) sql += ", "; else flag = true;
                    sql += f[i].getName() + " = ";
                    if (f[i].getType().getSimpleName().equals("String"))  
                        sql += "'" + aux2 + "'";
                    else
                        sql += aux2;
                }
            }
            catch(Exception e) {}
        }

        sql += " WHERE ";
        f  = chaves.getClass().getDeclaredFields();
        flag = false;

        for (int i =0; i < f.length; ++i)
        {
            try
            {
                aux1 = "get" + f[i].getName().substring(0,1).toUpperCase() + f[i].getName().substring(1);  
                mtd = chaves.getClass().getMethod(aux1);
                aux2 = mtd.invoke(chaves).toString();
                if (!aux2.equals(""))
                {
                    if (flag) sql += " AND "; else flag = true;
                    sql += f[i].getName() + " = ";
                    if (f[i].getType().getSimpleName().equals("String"))  
                        sql += "'" + aux2 + "'";
                    else
                        sql += aux2;
                }
            }
            catch(Exception e) {}
        }

        AFDAL.conecta();
        AFDAL.executeSQL(sql);
        AFDAL.desconecta();
    }
}
