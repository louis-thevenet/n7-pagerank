with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Integer_Text_IO;		use Ada.Integer_Text_IO;

package body Matrices_Creuses is
	procedure Detruire (M: in out T_Matrice) is
	begin
        for J in 1..Taille loop
            Detruire(M(J));
        end loop;

	end Detruire;

    procedure Initialiser(M : out T_Matrice) is
    begin
        for colonne in 1..Taille loop
            M(colonne):=Null;
        end loop;
    end Initialiser;

    function Est_Nulle(M: T_Matrice) return Boolean is
        vide: Boolean;
        colonne: Integer;
    begin
        vide := True;
        colonne := 1;
        while vide and colonne <= Taille loop
            vide := Vecteurs_Creux.Est_Nul(M(colonne));
            colonne:= colonne +1;
        end loop;
        return vide;
    end Est_Nulle;



    procedure Modifier(M : in out T_Matrice; I : in Integer; J : in Integer) is
    Indice_Error : exception;
    begin
        if J>Taille then
            raise Indice_Error;
        elsif Est_Nulle(M) then
            Initialiser(M);
            Vecteurs_Creux.Modifier(M(J), I);
        else
            Vecteurs_Creux.Modifier(M(J), I);
        end if;
    exception
    when Indice_Error =>
        Put_Line("L'indice de la colonne J doit être inférieur à aux nombres de colonnes de votre matrice (Taille)");
    end Modifier;

    function Element(M: T_Matrice; I : Integer; J : Integer) return Boolean is
    begin
        if Est_Nulle(M) then
            return False;
        else
            return Vecteurs_Creux.Composante(M(J),I);
        end if;
    end Element;

    procedure Afficher(M : T_Matrice) is
    begin
        for colonne in 1..Taille loop
			Put("Colonne : ");
            Put(colonne,1);
			Afficher(M(colonne));
			New_Line;
        end loop;
        Put("--end matrice--");
    end Afficher;

    --procedure Pour_Chaque(M : in out T_Matrice) is
    --    Tmp : T_Matrice;
    --    Tmp2 : T_Vecteur_Creux;
    --    colonne: Integer;
    --begin
    --    Tmp := M;
    --    colonne := 1;
    --    while Est_Nulle(tmp) and colonne<=Taille loop
    --        Tmp2 := M(colonne);
    --        while Tmp2 /= Null loop
    --           -- Tmp2.Valeur := Traitement(Tmp2.Valeur);
    --           Tmp2 := Tmp2.Suivant;
    --        end loop;
    --        colonne:=colonne+1;
    --    end loop;
    --end Pour_Chaque;


end Matrices_Creuses;
