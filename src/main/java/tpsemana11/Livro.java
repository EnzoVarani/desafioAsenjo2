/*
 * Modelo de dados: Livro
 * Classe de entidade para representar livros no sistema
 */
package tpsemana11;

/**
 * Classe Livro - Entidade de domínio
 */
public class Livro {
    private String id;
    private String titulo;
    private String autor;
    private String editora;
    private String ano;
    private String localizacao;

    public Livro() {}

    // Getters e Setters
    public void setId(String _id) {id = _id;}
    public void setTitulo(String _titulo) {titulo=_titulo;}
    public void setAutor(String _autor) {autor=_autor;}
    public void setEditora(String _editora) {editora=_editora;}
    public void setAno(String _ano) {ano = _ano;}
    public void setLocalizacao(String _localizacao) {localizacao=_localizacao;}

    public String getId() {return id;}
    public String getTitulo() {return titulo;}
    public String getAutor() {return autor;}
    public String getEditora() {return editora;}
    public String getAno() {return ano;}
    public String getLocalizacao() {return localizacao;}
}
