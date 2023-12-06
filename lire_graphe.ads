
--with Ada.IO_Exceptions;
with Ada.Text_IO;			use Ada.Text_IO;
with Ada.Float_Text_IO;		use Ada.Float_Text_IO;
with Ada.Integer_Text_IO;	use Ada.Integer_Text_IO;
--with Ada.Command_line;		use Ada.Command_line;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
package Lire_Graphe is

type T_Graphe is private;


--generic
    --  type T_Matrice_Adj;
    --  with function Initialiser
    --  with procedure Modifier_Element (Matrice : in out T_Matrice_Adj; I : in Integer; J : in Integer);
function Creer_Graphe (Fichier : in String; Pleine : in Boolean) return T_Graphe;

generic
    type T_Matrice is private
procedure Completer_Graphe (File : in Ada.Text_IO.File_Type; G : in out T_Matrice);


end Lire_Graphe;