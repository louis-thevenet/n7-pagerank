with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Long_Float_Text_IO;	use Ada.Long_Float_Text_IO;

with Lire_Graphe; use Lire_Graphe;
with Matrice_Pleine;
package body PageRank is

procedure Afficher (n : Long_Float) is
begin
Put(n, 2);
end Afficher;

--  function Incremente_Float(Element : Long_Float) return Long_Float is
--  begin
--      return Element+1.0;
--  end Traitement;

--  function Divise_Float(Element : Long_Float, Denom : Long_Float) return Long_Float is
--  begin
--      return Element/Denom;
--  end Traitement;

    procedure Algorithme_PageRank(Alpha : in Long_Float;
                                    K : in Integer;
                                    Epsilon : in Long_Float;
                                    Pleine : in Boolean;
                                    Prefixe : in String;
                                    Fichier_Nom : in String) is
        File : Ada.Text_IO.File_Type;
        Taille : Integer;
    begin
        open (File, In_File, Fichier_Nom);
        Get (File, Taille);
        if Pleine then
            declare
                package Matrices is new Matrice_Pleine(Long_Float, Taille);
                use Matrices;
                --  procedure Incremente is new Applique(Incremente_Float);
                --  procedure Divise is new Applique(Divise_Float);
                procedure Completer_Graphe_Inst is new Completer_Graphe(T_Matrice, Element,Modifier_Element,Matrices.Taille);

                procedure Afficher_Matrice_Int is new Afficher_Matrice(Afficher);

                Graphe : T_Matrice;
                begin
                    Initialiser_Matrice(Graphe, 0.0);
                    Completer_Graphe_Inst(File, Graphe);
                    Afficher_Matrice_Int(Graphe);
                end;
        else
            null;
        end if;


    end Algorithme_PageRank;



end PageRank;