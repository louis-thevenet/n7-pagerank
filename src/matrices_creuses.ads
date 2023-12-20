with Vecteurs_Creux; use Vecteurs_Creux;

package Matrices_Creuses is

    type T_Matrice is private;

    procedure Initialiser(M : out T_Matrice);
    procedure Modifier(M : in out T_Matrice; I : in Integer; J : in Integer; Nouveau : Long_Float);
    function Element(M: T_Matrice; I : Integer; J : Integer) return Long_Float;
    procedure Afficher(M : T_Matrice);
    --  function Lignes_Matrice(M : T_Matrice) return Integer;
    --  function Colonnes_Matrice(M : T_Matrice) return Integer;

private


	type T_Cellule_Matrice;

	type T_Matrice is access T_Cellule_Matrice;

	type T_Cellule_Matrice is
		record
			Indice : Integer;
			Valeur : T_Vecteur_Creux;
			Suivant : T_Matrice;
		end record;


end Matrices_Creuses;