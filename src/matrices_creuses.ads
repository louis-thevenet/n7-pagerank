with Vecteurs_Creux; use Vecteurs_Creux;

generic
    Taille: Integer;

package Matrices_Creuses is

    type T_Matrice;

    -- Initialiser une matrice creuse
    procedure Initialiser(M : out T_Matrice);

    -- Modifier un élément de la matrice creuse
    procedure Modifier(M : in out T_Matrice; I : in Integer; J : in Integer; Nouveau : Long_Float);

    -- Récupérer un élément de la matrice creuse
    function Element(M: T_Matrice; I : Integer; J : Integer) return Long_Float;

    -- Afficher la matrice creuse
    procedure Afficher(M : T_Matrice);

    -- Vérifier si tous les vecteurs creux composant la matrice sont nuls
    function Est_Nulle(M: T_Matrice) return Boolean;

    -- Le code suivant provoque un crash de GNAT
    --generic
    --    with function Traitement(V : Long_Float) return Long_Float;
    --procedure Pour_Chaque(M : in out T_Matrice);

	type T_Matrice is array(1..Taille) of T_Vecteur_Creux;
    type T_Facteurs is array(1..Taille) of Long_Float;
end Matrices_Creuses;
