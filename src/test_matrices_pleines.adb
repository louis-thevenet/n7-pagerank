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
        Put_Line("Test Modifier OK");

    end Tester_Modifier;

    procedure Tester_Element(M: in out T_Matrice) is
    begin
        pragma Assert(Element(M,3,1)=0.0);
        Modifier(M,3,1,2.4);
        pragma Assert(Element(M,3,1)=2.4);
        Put_Line("Test Element OK");
    end Tester_Element;


    procedure Tester_Lignes_Matrice(M : T_Matrice) is
    begin
        pragma Assert(Lignes_Matrice(M)=3);
        Put_Line("Test Lignes_Matrice OK");
    end Tester_Lignes_Matrice;

    procedure Tester_Colonnes_Matrice(M : T_Matrice) is
    begin
        pragma Assert(Colonnes_Matrice(M)=3);
        Put_Line("Test Colonnes_Matrice OK");
    end Tester_Colonnes_Matrice;


begin
    Tester_Initialiser(M);
    Tester_Lignes_Matrice(M);
    Tester_Colonnes_Matrice(M);
    Tester_Element(M);
    Tester_Modifier(M);

end Test_Matrices_Pleines;
