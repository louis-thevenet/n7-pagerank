with Vecteurs_Creux; use Vecteurs_Creux;

package Matrices_Creuses is

    type T_Matrice;

    procedure Initialiser(M : out T_Matrice);
    procedure Modifier(M : in out T_Matrice; I : in Integer; J : in Integer; Nouveau : Long_Float);
    function Element(M: T_Matrice; I : Integer; J : Integer) return Long_Float;
function Plus_Bas_Maillon(M : T_Matrice; I : Integer; J : Integer) return T_Vecteur_Creux;
function Plus_Haut_Maillon(M : T_Matrice; I : Integer; J : Integer) return T_Vecteur_Creux;
    procedure Afficher(M : T_Matrice);

    -- Le code suivant provoque un crash de GNAT
    --  generic
    --      with function Traitement(V : Long_Float) return Long_Float;
    --  procedure Pour_Chaque(M : in out T_Matrice);



	type T_Cellule_Matrice;

	type T_Matrice is access T_Cellule_Matrice;

	type T_Cellule_Matrice is
		record
			Indice : Integer;
			Valeur : T_Vecteur_Creux;
			Suivant : T_Matrice;
		end record;


end Matrices_Creuses;