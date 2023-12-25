with Ada.Text_IO; use Ada.Text_IO;
with Matrices_Creuses; use Matrices_Creuses;

procedure Test_Matrices_Creuses is
    M : T_Matrice;

    -- Spécification des fonctions de test
    procedure Tester_Initialiser(M: in out T_Matrice);

    procedure Tester_Modifier(M : in out T_Matrice);

    procedure Tester_Element(M: in out T_Matrice);

    procedure Tester_Afficher(M: in out T_Matrice);

    -- Implémentation des fonctions de test

    procedure Tester_Initialiser(M: in out T_Matrice) is
begin
    Initialiser(M);
    pragma Assert(M = null);
    Put_Line("Test Initialiser réussi");
end Tester_Initialiser;

procedure Tester_Modifier(M : in out T_Matrice) is
begin
    -- Test d'ajout au début
    Modifier(M, 1, 1, 1.0);
    pragma Assert(Element(M, 1, 1) = 1.0);

    -- Test d'ajout après
    Modifier(M, 1, 3, 2.0);
    pragma Assert(Element(M, 1, 3) = 2.0);

    -- Test d'ajout au milieu
    Modifier(M, 1, 2, 3.0);
    pragma Assert(Element(M, 1, 2) = 3.0);

    -- Test d'ajout au début de la colonne
    Modifier(M, 3, 1, 4.0);
    pragma Assert(Element(M, 3, 1) = 4.0);

    -- Test d'ajout après le début de la colonne
    Modifier(M, 2, 1, 5.0);
    pragma Assert(Element(M, 2, 1) = 5.0);

    Put_Line("Test Modifier réussi");
end Tester_Modifier;

procedure Tester_Element(M: in out T_Matrice) is
begin
    Modifier(M, 3, 1, 2.4);
    pragma Assert(Element(M, 3, 1) = 2.4);

    Put_Line("Test Element réussi");
end Tester_Element;

procedure Tester_Afficher(M: in out T_Matrice) is
begin
    -- Ce test dépendra de votre implémentation de Afficher
    -- Pour l'instant, il appelle simplement la procédure pour s'assurer qu'elle ne plante pas
    Afficher(M);
    Put_Line("Test Afficher réussi");
end Tester_Afficher;

begin
    Tester_Initialiser(M);
    Tester_Modifier(M);
    Tester_Element(M);
    Tester_Afficher(M);
end Test_Matrices_Creuses;
