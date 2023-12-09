with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
with Ada.Long_Float_Text_IO;	use Ada.Long_Float_Text_IO;


package body PageRank_Result is
    procedure Initialiser(Resultat : in out  T_Resultat) is
    begin
    Resultat.Taille := Taille;
        for I in 1..Resultat.Taille loop
            Resultat.Poids(I) := 0.0;
            Resultat.Indices(I) := I;
        end loop;
    end Initialiser;

function Norme_Au_Carre(Poids : T_Tab_Poids) return Long_Float is
    Resultat : Long_Float := 0.0;
begin
    for I in 1..Taille loop
        Resultat := Resultat + Poids(I) * Poids(I);
    end loop;
    return Resultat;
end Norme_Au_Carre;

function Combi_Lineaire(lambda : Long_Float; Poids : T_Tab_Poids; mu : Long_Float; Poids2 : T_Tab_Poids) return  T_Tab_Poids is
    Resultat : T_Tab_Poids;
begin
    for I in 1..Taille loop
        Resultat(I) := lambda*Poids(I) + mu*Poids2(I);
    end loop;
    return Resultat;
end Combi_Lineaire;

procedure Afficher(Resultat : T_Resultat) is
begin
    for I in 1..Resultat.Taille loop
        Put(Resultat.Indices(I), 1);
        Put(" : ");
        Put(Resultat.Poids(I), 1,5,0);
        New_Line;
    end loop;
end Afficher;

procedure Trier (Resultat : in out T_Resultat) is
    X : Long_Float;
    J : Integer;
    begin
        for I in 1..Resultat.Taille loop
            X := Resultat.Poids(I);
            J := I;
            while J > 1 and then Resultat.Poids(J-1) < X loop
                Resultat.Poids(J) := Resultat.Poids(J-1);
                Resultat.Indices(J) := Resultat.Indices(J-1);
                J := J-1;
            end loop;
            Resultat.Poids(J) := X;
            Resultat.Indices(J) := I;
        end loop;
    end Trier;

end PageRank_Result;