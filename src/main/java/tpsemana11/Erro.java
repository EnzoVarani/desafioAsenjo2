/*
 * Classe de tratamento de erros
 * Mantém estrutura original do Prof. Mauricio Asenjo
 */
package tpsemana11;

/**
 * Classe para gerenciamento de erros do framework
 */
public class Erro {
    private static boolean erro;
    private static String mens;

    public static void setErro(boolean _erro)
    {
        erro=_erro;
    }

    public static void setErro(String _mens)
    {
        erro=true;
        mens=_mens;
    }

    public static boolean getErro() {return erro;}
    public static String getMens() {return mens;}
}
