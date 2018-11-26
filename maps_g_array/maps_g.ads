
generic
   type Key_Type is private;
   type Value_Type is private;
   Max_Size: in Natural;
   with function "=" (K1, K2: Key_Type) return Boolean;

package Maps_G is
--Paquete de ARRAYS.

   type Map is limited private;
   --Tipo para utilizar: GET,PUT,DELETE.

   procedure Get (M       : Map;
                  Key     : in  Key_Type;
                  Value   : out Value_Type;
                  Success : out Boolean);


   Full_Map : exception;
   procedure Put (M     : in out Map;
                  Key   : in Key_Type;
                  Value : in Value_Type);

   procedure Delete (M      : in out Map;
                     Key     : in  Key_Type;
                     Success : out Boolean);


   function Map_Length (M : Map) return Natural;

   --
   -- Cursor Interface for iterating over Map elements
   --

   type Cursor is limited private;
   function First (M: Map) return Cursor;
   procedure Next (C: in out Cursor);
   function Has_Element (C: Cursor) return Boolean;
   --function Last (M:Map) return Cursor;
   --procedure Prev (C: in out Cursor);

   type Element_Type is record
      Key:   Key_Type;
      Value: Value_Type;
   end record;

   No_Element: exception;

   -- Raises No_Element if Has_Element(C) = False;
   --Devuelve KEY + VALUE:
   function Element (C: Cursor) return Element_Type;

private

   --type Cell;
   --type Cell_A is access Cell;

   type Cell is record
      Key   : Key_Type;
      Value : Value_Type;
      Empty : Boolean:= True;
   end record;

   type Cell_Array is array(1..Max_Size) of Cell;
   type Cell_Array_A is access Cell_Array;

   type Map is record
      P_Array: Cell_Array_A:= new Cell_Array;
      Length  : Natural:= 0;
   end record;

   type Cursor is record
      M       : Map;
      Position: Natural;
   end record;

end Maps_G;