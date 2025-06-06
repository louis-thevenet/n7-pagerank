with Ada.Text_IO;       use Ada.Text_IO;
with Vecteurs_Creux;    use Vecteurs_Creux;


procedure Test_Vecteurs_Creux is

    -- Spécification des fonctions de test
    procedure Tester_Composante;
    procedure Tester_Est_Nul;
    procedure Tester_Sont_Egaux;

    procedure Initialiser (VC0, VC1, VC2, VC3 : out T_Vecteur_Creux);
    procedure Detruire (VC0, VC1, VC2, VC3 : in out T_Vecteur_Creux);

    -- Implémentation des fonctions de test

    -- Procedure initialisant les vecteurs creux utilisés pour les tests
    procedure Initialiser (VC0, VC1, VC2, VC3 : out T_Vecteur_Creux) is
	begin
		-- VC0 est un vecteur nul
		Initialiser (VC0);

		-- VC1 est un vecteur à deux composante
		Initialiser (VC1);
		Modifier (VC1,  3);
        Modifier (VC1, 10);


          -- VC2 est un vecteur à trois composantes
		Initialiser (VC2);
        Modifier (VC2,    1);
		Modifier (VC2,    3);
        Modifier (VC2,  100);


         -- VC3 est un vecteur à 5 composantes
        Initialiser (VC3);
        Modifier (VC3,   1);
        Modifier (VC3,   2);
        Modifier (VC3,   3);
        Modifier (VC3,  10);
		Modifier (VC3, 150);


	end;

    -- Procedure pour détruire les différents vecteurs utilisés dans les tests
	procedure Detruire (VC0, VC1, VC2, VC3 : in out T_Vecteur_Creux) is
	begin
		Detruire (VC0);
		Detruire (VC1);
        Detruire (VC2);
        Detruire(VC3);
	end;


  procedure Tester_Composante is
        VC0, VC1, VC2, VC3: T_Vecteur_Creux;
    begin
        Initialiser (VC0, VC1, VC2,VC3);
        pragma Assert( True = Composante(VC2,100));
        pragma Assert( True = Composante(VC1,3));


        Put_Line("Test de la procédure Composante OK");
    end Tester_Composante;

	procedure Tester_Est_Nul is
		VC0, VC1, VC2, VC3: T_Vecteur_Creux;
	begin
		Initialiser (VC0, VC1, VC2,VC3);

		pragma Assert (Est_Nul (VC0));
		pragma Assert (not Est_Nul (VC1));
		pragma Assert (not Est_Nul (VC2));

        Detruire (VC0, VC1, VC2, VC3);
        Put_Line("Test de la fonction Nul OK");
	end Tester_Est_Nul;


	procedure Tester_Sont_Egaux is
		VC0, VC1, VC2, VC3,VC4: T_Vecteur_Creux;
	begin
		Initialiser (VC0, VC1, VC2, VC3);

		pragma Assert (Sont_Egaux (VC0, VC0));
		pragma Assert (Sont_Egaux  (VC1, VC1));
		pragma Assert (Sont_Egaux (VC2, VC2));

		pragma Assert (not Sont_Egaux (VC0, VC1));
		pragma Assert (not Sont_Egaux (VC0, VC2));
		pragma Assert (not Sont_Egaux  (VC1, VC2));

		pragma Assert (not Sont_Egaux  (VC1, VC0));
		pragma Assert (not Sont_Egaux (VC2, VC0));
		pragma Assert (not Sont_Egaux  (VC2, VC1));

		--On créé un vecteur VC4 avec les mêmes composantes que VC1
		Initialiser (VC4);
		Modifier (VC4, 10);
		Modifier (VC4,  3);

         -- On vérifie la symétrie de la fonction
        pragma Assert (Sont_Egaux (VC1, VC4));
		pragma Assert (Sont_Egaux (VC4, VC1));

        Detruire (VC0, VC1, VC2, VC3);
        Detruire (VC4);
        Put_Line("Test de la fonction Sont_Egaux_Iteratif OK");
	end Tester_Sont_Egaux;



begin

    Tester_Composante;
	Tester_Est_Nul;
	Tester_Sont_Egaux;

end Test_Vecteurs_Creux;
