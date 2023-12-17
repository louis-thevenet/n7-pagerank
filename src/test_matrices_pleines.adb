with Ada.Text_IO;       use Ada.Text_IO;
with Matrices_Pleines;

procedure Test_Matrices_Pleines is

    package Matrices_Pleines_Inst is new Matrices_Pleines(3,3); use Matrices_Pleines_Inst;
    M,N : T_Matrice;

    -- Spécification des fonctions de Test
    procedure Tester_Initialiser(M: in out T_Matrice);

    procedure Tester_Modifier(M : in out T_Matrice);

    procedure Tester_Element(M: in out T_Matrice);

    procedure Tester_Lignes_Matrice(M : T_Matrice);

    procedure Tester_Colonnes_Matrice(M : T_Matrice);

    procedure Tester_Norme_Au_Carre(M: in out T_Matrice);

    procedure Tester_Combi_Lineaire(M : in out T_Matrice; N : in out T_Matrice);

    -- Implentation des fonctions de Test

    procedure Tester_Initialiser(M: in out T_Matrice) is
    begin
        Initialiser(M);
        pragma Assert(Lignes_Matrice(M) = 3);
        pragma Assert(Colonnes_Matrice(M) = 3);
        for I in 1..Lignes_Matrice(M) loop
            for J in 1.. Colonnes_Matrice(M) loop
                pragma Assert(Element(M,I,J)=0.0);
            end loop;
        end loop;
        Put_Line("Test Initialiser OK");
    end Tester_Initialiser;

    procedure Tester_Modifier(M : in out T_Matrice) is
    begin
        Modifier(M,2,3,4.56);
        pragma Assert(Element(M,2,3)=4.56);
        Put_Line(" Test Modifier OK");

    end Tester_Modifier;

    procedure Tester_Element(M: in out T_Matrice) is
    begin
        pragma Assert(Element(M,3,1)=0.0);
        Modifier(M,3,1,2.4);
        pragma Assert(Element(M,3,1)=2.4);
        Put_Line(" Test Element OK");
    end Tester_Element;


    procedure Tester_Lignes_Matrice(M : T_Matrice) is
    begin
        pragma Assert(Lignes_Matrice(M)=3);
        Put_Line(" Test Lignes_Matrice OK");
    end Tester_Lignes_Matrice;

    procedure Tester_Colonnes_Matrice(M : T_Matrice) is
    begin
        pragma Assert(Colonnes_Matrice(M)=3);
        Put_Line(" Test Colonnes_Matrice OK");
    end Tester_Colonnes_Matrice;

    procedure Tester_Norme_Au_Carre(M : in out T_Matrice) is
    begin
        Initialiser(M);
        Modifier(M,1,1,1.4);
        Modifier(M,1,2,3.3);
        Modifier(M,1,3,2.5);
        Modifier(M,2,1,7.8);
        Modifier(M,2,2,0.0);
        Modifier(M,2,3,2.3);
        Modifier(M,3,1,0.0);
        Modifier(M,3,2,2.0);
        Modifier(M,3,3,3.3);
        pragma Assert(Norme_Au_Carre(M)-1.0012000000000E+02<= 1.0E-06);
        Put_Line(" Test Norme Carree OK");

    end Tester_Norme_Au_Carre;

    procedure Tester_Combi_Lineaire(M : in out T_Matrice; N : in out T_Matrice) is
        C: T_Matrice;
        Test: T_Matrice;
        Lambda,Mu : Long_Float;
    begin
        Lambda:=2.3;
        Mu := 1.1;
        -- Matrice M --
        Initialiser(M);
        Modifier(M,1,1,1.4);
        Modifier(M,1,2,3.3);
        Modifier(M,1,3,2.5);
        Modifier(M,2,1,7.8);
        Modifier(M,2,2,0.0);
        Modifier(M,2,3,2.3);
        Modifier(M,3,1,0.0);
        Modifier(M,3,2,2.0);
        Modifier(M,3,3,3.3);
        -- Matrice N --
        Initialiser(N);
        Modifier(N,1,1,1.3);
        Modifier(N,1,2,0.0);
        Modifier(N,1,3,0.0);
        Modifier(N,2,1,2.1);
        Modifier(N,2,2,3.4);
        Modifier(N,2,3,2.7);
        Modifier(N,3,1,7.4);
        Modifier(N,3,2,0.0);
        Modifier(N,3,3,8.9);
        C := Combi_Lineaire(Lambda,M,Mu,N);

        -- Création de la matrice de test
        Initialiser(Test);
        Modifier(Test,1,1,4.65000);
        Modifier(Test,1,2,7.59000);
        Modifier(Test,1,3,5.75000);
        Modifier(Test,2,1,20.25000);
        Modifier(Test,2,2,3.74000);
        Modifier(Test,2,3,8.26000);
        Modifier(Test,3,1,8.14000);
        Modifier(Test,3,2,4.6000);
        Modifier(Test,3,3,17.38000);
        pragma Assert(Lignes_Matrice(M) = 3);
        pragma Assert(Colonnes_Matrice(M) = 3);
        for I in 1..Lignes_Matrice(M) loop
            for J in 1.. Colonnes_Matrice(M) loop
                pragma Assert(Element(C,I,J)-Element(Test,I,J)<= 1.0E-06);
            end loop;
        end loop;
        Put_Line("Test Combinaison Linéaire OK");
    end Tester_Combi_Lineaire;

begin
    Tester_Initialiser(M);
    Tester_Lignes_Matrice(M);
    Tester_Colonnes_Matrice(M);
    Tester_Norme_Au_Carre(M);
    Tester_Element(M);
    Tester_Modifier(M);
    Tester_Combi_Lineaire(M,N);

end Test_Matrices_Pleines;
