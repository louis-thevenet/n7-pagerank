-- Ce package définit un type T_Matrice représentant une matrice et
-- les opérations associées à l'aide de tableaux.
generic
    N : Integer;
    P : Integer;
package Matrices_Pleines is

    type T_Matrice is private;

    -- Renvoie une matrice nulle
    procedure Initialiser(M : out T_Matrice);

    -- Modifier un élément de la matrice à la position (I, J) avec une nouvelle valeur.
    -- Les indices I et J doivent être valides.
    procedure Modifier(M : in out T_Matrice; I : in Integer; J : in Integer; Nouveau : Long_Float)
        with
            Pre  => 1 <= I and I <= Lignes_Matrice(M) and 1 <= J and J <= Colonnes_Matrice(M),
            Post => Element(M, I, J) = Nouveau;

    -- Obtenir la valeur de l'élément à la position (I, J) de la matrice.
    -- Les indices I et J doivent être valides.
    function Element(M: T_Matrice; I : Integer; J : Integer) return Long_Float
        with
            Pre => 1 <= I and I <= Lignes_Matrice(M) and 1 <= J and J <= Colonnes_Matrice(M);

    -- Afficher la matrice.
    procedure Afficher(M : T_Matrice);

    -- Obtenir le nombre de lignes de la matrice.
    function Lignes_Matrice(M : T_Matrice) return Integer;

    -- Obtenir le nombre de colonnes de la matrice.
    function Colonnes_Matrice(M : T_Matrice) return Integer;

    -- Obtenir la norme au carré de la matrice M.
    --function Norme_Au_Carre(M : T_Matrice) return Long_Float;

    -- Obtenir la combinaison linéaire de deux matrices.
    --function Combi_Lineaire(Lambda : Long_Float; M : T_Matrice; Mu : Long_Float; N : T_Matrice) return T_Matrice;

private
    -- Définir le type privé T_Matrice sous forme d'un tableau à deux dimensions.
    type T_Matrice_Pleine is array(1..N, 1..P) of Long_Float;

    type T_Matrice is record
        Mat : T_Matrice_Pleine;
        Lignes : Integer;
        Colonnes : Integer;
    end record;

end Matrices_Pleines;
